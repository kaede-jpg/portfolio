class MealAdviseJob < ApplicationJob
  queue_as :default

  require 'base64'
  require 'open-uri'
  require 'ruby/openai'
  include Rails.application.routes.url_helpers

  def perform(record)
    # 画像をBase64エンコード
    image_url = rails_blob_url(record.meal_image)
    image_data = URI.parse(image_url).read
    base64_image = Base64.encode64(image_data)
    # Data URIを作成
    data_uri = "data:image/png;base64,#{base64_image}"
    # chatGPTへ送信しレスポンスを受け取る
    client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key))
    response = client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        messages: [{
          role: 'user',
          content: [
            { type: 'text',
              text: 'Return the name of the food in this image and calorie, in 30 characters or less in Japanese.' },
            { type: 'image_url',
              image_url: { url: data_uri,
                           detail: 'low' } }
          ]
        }]
      }
    )
    record.update(meal_advise: response.dig('choices', 0, 'message', 'content'))
  end
end
