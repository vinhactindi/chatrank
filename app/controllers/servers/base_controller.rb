# frozen_string_literal: true

class Servers::BaseController < ApplicationController
  add_breadcrumb 'ホーム', :root_path
  add_breadcrumb '参加したサーバー', :servers_path

  before_action :set_server
  before_action :logged_in_manager!

  private

  def set_server
    @server = Server.find(params[:server_id])
    add_breadcrumb @server.name, server_path(@server)
  end

  def logged_in_manager!
    redirect_to servers_path, alert: 'あなたはこのサーバーの管理者ではありません' unless current_user.manage? @server
  end
end
