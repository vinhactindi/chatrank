# frozen_string_literal: true

namespace :bot do
  desc 'run bot'
  task run: :environment do
    trap('SIGINT') do
      puts '- Your bot has stopped!'
      exit
    end

    Bot.run
  end
end
