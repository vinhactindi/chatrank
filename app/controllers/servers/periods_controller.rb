# frozen_string_literal: true

class Servers::PeriodsController < ApplicationController
  before_action :set_server

  def index
    @periods = Rank.where(rankable_id: @server.id).where(rankable_type: 'Server').distinct.pluck(:period).sort.reverse
  end

  private

  def set_server
    @server = Server.find(params[:server_id])
  end
end
