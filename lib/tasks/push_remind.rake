namespace :push_remind do
  desc 'LINEBOT：投稿忘れのリマインド'
  task push_line_remind: :environment do
    client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :bot_channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :bot_channel_access_token)
    end

    monitoreds = User.left_joins(:records)
                     .where(role: :monitored)
                     .where('records.created_at IS NULL OR records.created_at < ?', 24.hours.ago)
    monitoreds.each do |monitored|
      message = {
        type: 'text',
        text: "#{monitored.name}さんが食事の記録をサボっているみたい…。\n声をかけてあげよう！"
      }
      monitors = User.monitors_of(monitored)
      monitors.each do |monitor|
        next unless monitor.linked_line?

        uid = Authentication.line_of(monitor).uid

        client.push_message(uid, message)
      end
    end
  end
end
