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

  desc 'read history messsages'
  task read: :environment do
    puts "Bot will read server all messages! Please, don't force quit until the end."
    server = Server.find(ARGV[0])
    server.read_history_messages

    exit
  end
end
