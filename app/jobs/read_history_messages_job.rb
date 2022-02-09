class ReadHistoryMessagesJob < ApplicationJob
  queue_as :default

  def perform(server)
    server.read_history_messages
  end
end
