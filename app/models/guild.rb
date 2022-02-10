# frozen_string_literal: true

class Guild < ApplicationRecord
  belongs_to :server
  belongs_to :user

  def permissions_or_zero
    permissions || 0
  end
end
