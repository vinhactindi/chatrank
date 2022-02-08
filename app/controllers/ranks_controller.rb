# frozen_string_literal: true

class RanksController < ApplicationController
  def index
    respond_to do |format|
      server = if params[:rankable_type] == 'Server'
                 Server.find(params[:rankable_id])
               else
                 Channel.find(params[:rankable_id]).server
               end

      if server&.updating
        format.json { render json: { updating: true } }
      else
        @ranks = Rank.monthly(rankable_type: params[:rankable_type], rankable_id: params[:rankable_id], period: params[:period])

        format.json
      end
    end
  end
end
