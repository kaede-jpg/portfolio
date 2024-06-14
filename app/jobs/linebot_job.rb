class LinebotJob < ApplicationJob
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(record)
    monitored = record.user
    monitors = User.monitors_of(monitored)
    message = {
      type: 'text',
      text: "#{monitored.name}さんが食事を記録しました！\nさっそくリアクションしましょう！\n#{records_url}"
    }
    monitors.each do |monitor|
      next unless monitor.linked_line?

      uid = Authentication.line_of(monitor).uid
      client.push_message(uid, message)
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :bot_channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :bot_channel_access_token)
    end
  end
end
