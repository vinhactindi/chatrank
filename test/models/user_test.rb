# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '.find_or_create_from_auth_hash!' do
    uid = 123_456_789
    auth_hash = {
      provider: 'discord',
      uid: uid,
      info: {
        name: 'carol'
      },
      extra: {
        raw_info: {
          discriminator: '1234'
        }
      },
      credentials: {
        token: 'testtest'
      }
    }
    user = User.find_or_create_from_auth_hash!(auth_hash)
    assert_equal User.find(uid), user
  end

  test '.manage?' do
    vinh = users(:vinh)
    bootcamp = servers(:bootcamp)
    assert vinh.manage?(bootcamp)
  end
end
