# frozen_string_literal: true

class ServersController < ApplicationController
  add_breadcrumb 'ホーム', :root_path
  add_breadcrumb 'サーバー'

  def index
    @servers = current_user.servers
  end

  def create
    respond_to do |format|
      response = Discordrb::API::User.servers("Bearer #{current_user.token}")
    rescue RestClient::Unauthorized, RestClient::Forbidden
      message = '期限切れのトークン、もう一度ログインしてください'
      format.html { redirect_to servers_path, alert: message }
      format.json { render json: { alert: { type: 'danger', message: message } } }
    else
      @servers = Server.where_or_create_by_discord_api_response!(response, user_id: current_user.id)

      flash.now[:notice] = 'サーバーリストの更新が成功しました'
      format.html { render :index }
      format.json { render :index, status: :created, location: servers_path }
    end
  end

  def update
    @server = Server.find(params[:id])

    ReadHistoryMessagesJob.perform_later(@server) unless @server.updating

    respond_to do |format|
      flash[:notice] = '過去のメッセージを読み込んでいますので、後で戻ってください'
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
end
