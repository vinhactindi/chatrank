# frozen_string_literal: true

class Servers::ChannelsController < ApplicationController
  add_breadcrumb 'ホーム', :root_path
  add_breadcrumb 'サーバー', :servers_path

  before_action :set_server

  def index
    @channels = Channel.includes(:children).where(server: @server).where(channel_type: 0)
  end

  def create
    respond_to do |format|
      response = Discordrb::API::Server.channels("Bot #{ENV['DISCORD_BOT_TOKEN']}", @server.id)
    rescue RestClient::Unauthorized, RestClient::Forbidden
      message = '期限切れのトークン、もう一度ログインしてください'
      format.html { redirect_to server_channels_path(@server.id), alert: message }
      format.json { render json: { alert: { type: 'danger', message: message } } }
    rescue Discordrb::Errors::NoPermission
      message = 'ボットはこのサーバーに招待されていません'
      format.html { redirect_to server_channels_path(@server.id), alert: message }
      format.json { render json: { alert: { type: 'danger', message: message } } }
    else
      @channels = Channel.where_or_create_by_discord_api_response!(response, server_id: @server.id)
      @channels.select! { |channel| channel.channel_type.zero? }

      flash.now[:notice] = 'サーバーリストの更新が成功しました'
      format.html { render :index }
      format.json { render :index, status: :created, location: server_channels_path(@server.id) }
    end
  end

  private

  def set_server
    @server = Server.find(params[:server_id])
    add_breadcrumb @server.name
  end
end
