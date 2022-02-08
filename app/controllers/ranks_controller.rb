# frozen_string_literal: true

class RanksController < ApplicationController
  def index
    @ranks = Rank.monthly(rankable_type: params[:rankable_type], rankable_id: params[:rankable_id], period: params[:period])
  end
end
