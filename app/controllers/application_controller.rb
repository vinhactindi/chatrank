# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :logged_in_user!
  helper_method :current_user

  private

  def logged_in_user!
    session[:return_to] = request.url
    redirect_to welcome_url unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
