# frozen_string_literal: true

class ServersController < ApplicationController
  add_breadcrumb 'ホーム', :root_path
  add_breadcrumb 'サーバー'

  before_action :set_server, only: %i[show update]
  before_action :logged_in_manager!, only: %i[show update]

  def index
    @servers = current_user.servers
  end

  def show; end

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
    respond_to do |format|
      if @server.channels.any?
        ReadHistoryMessagesJob.perform_later(@server) unless @server.updating
        flash[:notice] = '過去のメッセージを読み込んでいますので、後で戻ってください'
      else
        flash[:alert] = '最初にチャネル一覧を更新してください'
      end
      format.html { redirect_to root_path }
      format.json { render json: { flash: flash.to_h } }
    end
  end

  private

  def set_server
    @server = Server.find(params[:id])
  end

  def logged_in_manager!
    redirect_to root_path, alert: 'あなたはこのサーバーの管理者ではありません' unless current_user.manage? @server
  end
end
