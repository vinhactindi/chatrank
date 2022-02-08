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

      format.html { render :index, notice: 'サーバーリストの更新が成功しました' }
      format.json { render :index, status: :created, location: server_channels_path(@server.id) }
    end
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
    @channels = Channel.includes(:children).where(server: @server).where(channel_type: 0)
  end
end
