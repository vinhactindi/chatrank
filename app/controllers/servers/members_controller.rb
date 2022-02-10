# frozen_string_literal: true

class Servers::MembersController < Servers::BaseController
  def index
    add_breadcrumb 'メンバー一覧'
    @members = @server.users
  end
end
