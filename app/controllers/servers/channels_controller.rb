# frozen_string_literal: true

class Servers::ChannelsController < ApplicationController
  before_action :set_server
  before_action :set_channel, only: :show
  before_action :set_selectors, only: %i[index show]

  def index
    @ranks = Rank.monthly(rankable_type: 'Server', rankable_id: @server.id, period: @period)
  end

  def show
    redirect_to server_channels_path(@server.id), notice: 'チャットチャネルじゃありません' unless @channel.channel_type.zero?

    @ranks = Rank.monthly(rankable_type: 'Channel', rankable_id: @channel.id, period: @period)
  end

  def create
    response = Discordrb::API::Server.channels("Bot #{ENV['DISCORD_BOT_TOKEN']}", @server.id)
  rescue RestClient::Unauthorized, RestClient::Forbidden
    redirect_to server_channels_path(@server.id), alert: '期限切れのトークン、もう一度ログインしてください'
  rescue Discordrb::Errors::NoPermission
    redirect_to server_channels_path(@server.id), alert: 'ボットはこのサーバーに招待されていません'
  else
    Channel.where_or_create_by_discord_api_response!(response, server_id: @server.id)

    redirect_to server_channels_path(@server.id), notice: 'サーバーリストの更新が成功しました'
  end

  private

  def set_server
    @server = Server.find(params[:server_id])
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def set_selectors
    @period  = params[:period] || Time.current.strftime('%Y-%m')
    @periods = Rank.distinct.pluck(:period).sort.reverse
    @servers = current_user.servers
    @channels = Channel.includes(:children).where(server: @server).where(parent_id: nil)
  end
end
