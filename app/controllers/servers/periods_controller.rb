# frozen_string_literal: true

class Servers::PeriodsController < Servers::BaseController
  def index
    @periods = Rank.where(rankable_id: @server.id).where(rankable_type: 'Server').distinct.pluck(:period).sort.reverse
  end
end
