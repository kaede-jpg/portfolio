class LinebotJob < ApplicationJob
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(record)
    user = record.user
    users = User.monitors_of(user)
    message = {
                type: 'text',
                text: "#{user.name}さんが食事を記録しました！\nさっそくリアクションしましょう！\n#{records_url}"
            }
    users.each do |user|
      if user.linked_line?
        uid = Authentication.line_of(user).uid
      else
        next
      end
      response = client.push_message(uid, message)
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :bot_channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :bot_channel_access_token)
    }
  end
end
