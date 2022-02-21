# frozen_string_literal: true

require 'application_system_test_case'

class RanksTest < ApplicationSystemTestCase
  test 'visting leaderboard as a manager' do
    login_user users(:vinh)
    visit root_url
    assert_text '過去統計'
  end

  test 'visiting bootcamp leaderboard' do
    login_user users(:vinh)
    visit root_url

    find('#server-select').click
    find('#react-select-2-listbox').find('span', text: 'bootcamp').click

    find('#period-select').click
    find('#react-select-4-listbox').first('div', text: '2022-01').click

    assert_text 'vinh#1111'
    assert_text '10'
  end
end
