# frozen_string_literal: true

class Guild < ApplicationRecord
  belongs_to :server
  belongs_to :user
end
