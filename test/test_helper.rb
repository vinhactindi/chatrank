# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

Capybara.default_max_wait_time = 5
Capybara.disable_animation = true
Webdrivers.cache_time = 86_400
Selenium::WebDriver.logger.ignore(:browser_options)

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all

  OmniAuth.config.test_mode = true

  def discord_account_mock(name, uid)
    auth_hash = {
      provider: 'discord',
      uid: uid,
      info: {
        name: name
      },
      extra: {
        raw_info: {
          discriminator: '1234'
        }
      },
      credentials: {
        token: 'ODDFOFXUpgf7yEntul5ockCA' # fake
      }
    }
    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(auth_hash)
  end
end

ActiveSupport.on_load(:action_dispatch_system_test_case) do
  ActionDispatch::SystemTesting::Server.silence_puma = true
end
