# frozen_string_literal: true

require 'application_system_test_case'

class ServersTest < ApplicationSystemTestCase
  test 'visiting joined servers' do
    login_user users(:vinh)
    visit servers_path
    assert_text 'bootcamp'
    assert_text 'shiba'
  end

  test 'visiting unmanaged servers' do
    login_user users(:vinh)
    visit server_path(servers(:shiba))
    assert_text 'あなたはこのサーバーの管理者ではありません'
  end
end
