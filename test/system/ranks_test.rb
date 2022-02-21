# frozen_string_literal: true

require 'application_system_test_case'

class RanksTest < ApplicationSystemTestCase
  test 'visting leaderboard as a manager' do
    login_user users(:vinh)
    visit root_url
    assert_text '過去統計'
  end
end
