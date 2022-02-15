# frozen_string_literal: true

class RanksController < ApplicationController
  def index
    respond_to do |format|
      @server = case params[:rankable_type]
                when 'Server'
                  Server.find(params[:rankable_id])
                when 'Channel'
                  Channel.find(params[:rankable_id]).server
                end

      current_user.last_seen_server = @server
      current_user.save

      if @server&.updating
        flash.now[:alert] = '過去のメッセージを読み込んで、ランキング一覧を作成中ので、数分がかかるようです。'
        format.json { render json: { updating: true, flash: flash.to_h } }
      else
        @ranks = Rank.monthly(rankable_type: params[:rankable_type], rankable_id: params[:rankable_id], period: params[:period])

        flash.now[:notice] = 'メッセージがありません！ボットがサーバーにあることを確認してください。' if @ranks.empty?
        format.json
      end
    end
  end
end
