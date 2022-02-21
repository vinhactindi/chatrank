# frozen_string_literal: true

require 'test_helper'

class ServerTest < ActiveSupport::TestCase
  test '.manage_by?' do
    vinh = users(:vinh)
    bootcamp = servers(:bootcamp)
    assert bootcamp.manage_by?(vinh)
  end
end
