# frozen_string_literal: true

class ServersController < ApplicationController
  def index
    @servers = Server.all
  end

  def create
    response = Discordrb::API::User.servers("Bearer #{current_user.token}")
  rescue RestClient::Unauthorized, RestClient::Forbidden
    redirect_to servers_path, alert: '期限切れのトークン、もう一度ログインしてください'
  else
    Server.where_or_create_by_discord_api_response!(response, user_id: current_user.id)

    redirect_to servers_path, notice: 'サーバーリストの更新が成功しました'
  end

  def update
    @server = Server.find(params[:id])
    @server.ranks.destroy_all
    @server.channels.each do |channel|
      channel.ranks.destroy_all
      channel.update_messages_count!(ENV['DISCORD_BOT_TOKEN'])
    end

    redirect_to server_channels_path(@server), notice: '各メンバーのメッセージ回数の更新が成功しました'
  end
end
