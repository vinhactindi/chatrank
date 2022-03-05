# frozen_string_literal: true

class ReadHistoryMessagesJob < ApplicationJob
  queue_as :default

  rescue_from StandardError, with: :server_updated
  after_perform :server_updated

  def perform(server)
    server.read_history_messages
  end

  private

  def server_updated
    arguments.first.update(updating: false)
  end
end
