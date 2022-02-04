# frozen_string_literal: true

class Servers::ChannelsController < ApplicationController
  before_action :set_server, only: %i[index create show]
  before_action :set_period, only: %i[index show]

  def index
    @channels = Channel.includes(:children).where(server: @server).where(parent_id: nil)
    @ranks = Rank.monthly(rankable_type: 'Server', rankable_id: @server.id, period: @period)
  end

  def show
    @channel = Channel.find(params[:id])
    redirect_to server_channels_path(@server.id), notice: 'チャットチャネルじゃありません' unless @channel.channel_type.zero?

    @rank = Rank.monthly(rankable_type: 'Channel', rankable_id: @channel.id, period: @period)
  end

  def create
    response = Discordrb::API::Server.channels("Bot #{ENV['DISCORD_BOT_TOKEN']}", @server.id)
  rescue RestClient::Unauthorized, RestClient::Forbidden
    redirect_to server_channels_path(@server.id), alert: '期限切れのトークン、もう一度ログインしてください'
  else
    Channel.where_or_create_by_discord_api_response!(response, server_id: @server.id)

    redirect_to server_channels_path(@server.id), notice: 'サーバーリストの更新が成功しました'
  end

  private

  def set_server
    @server = Server.find(params[:server_id])
  end

  def set_period
    @period  = params[:period] || Time.current.strftime('%Y-%m')
    @periods = Rank.distinct.pluck(:period)
  end
end
