# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting root path' do
    login_user users(:vinh)
    visit root_url
    assert_selector 'label', text: 'サーバー'
  end
end
