# frozen_string_literal: true

class Servers::BaseController < ApplicationController
  add_breadcrumb 'ホーム', :root_path
  add_breadcrumb '参加したサーバー', :servers_path

  before_action :set_server

  private

  def set_server
    @server = Server.find(params[:server_id])
    add_breadcrumb @server.name, server_path(@server)
  end
end
