namespace :bot do
  desc 'run bot'
  task run: :environment do
    Bot.instance.message do |event|
      event.respond "user: #{event.user.id}, server: #{event.server&.id}, channel: #{event.channel.id}"
    end

    Bot.instance.run
  end
end
