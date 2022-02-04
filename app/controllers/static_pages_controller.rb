# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    redirect_to servers_path
  end
end
