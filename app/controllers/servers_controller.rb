# frozen_string_literal: true

class ServersController < ApplicationController
  add_breadcrumb 'ホーム', :root_path
  add_breadcrumb '参加したサーバー', :servers_path

  before_action :set_server, only: %i[show update]
  before_action :logged_in_manager!, only: %i[show update]

  def index
    @servers = current_user.servers.order(:name)
  end

  def show
    add_breadcrumb @server.name, server_path(@server)
  end

  def create
    respond_to do |format|
      response = Discordrb::API::User.servers("Bearer #{current_user.token}")
    rescue RestClient::Unauthorized, RestClient::Forbidden
      flash.now[:alert] = '期限切れのトークン、もう一度ログインしてください'
      format.html { redirect_to servers_path }
      format.json { render json: { flash: flash.to_h } }
    else
      @servers = Server.where_or_create_by_discord_api_response!(response, user_id: current_user.id)

      flash.now[:notice] = 'サーバーリストの更新が成功しました'
      format.html { render :index }
      format.json { render :index, status: :created, location: servers_path }
    end
  end

  def update
    if @server.channels.empty?
      flash.now[:alert] = '最初にチャネル一覧を更新してください'
    elsif @server.updating
      flash.now[:notice] = '過去のメッセージを読み込んでいますので、後で戻ってください'
    elsif @server.update(updating: true)
      flash.now[:notice] = '過去のメッセージを読み込んでいますので、後で戻ってください'
      ReadHistoryMessagesJob.perform_later(@server)
    end
    render :show
  end

  private

  def set_server
    @server = Server.find(params[:id])
  end

  def logged_in_manager!
    redirect_to servers_path, alert: 'あなたはこのサーバーの管理者ではありません' unless current_user.manage? @server
  end
end
