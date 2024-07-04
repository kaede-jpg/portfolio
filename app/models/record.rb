class Record < ApplicationRecord
  has_one_attached :meal_image

  validates :meal_image, presence: true, blob: { content_type: :image }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :stamped_records, dependent: :destroy

  require 'base64'
  require 'open-uri'
  require 'ruby/openai'
  include Rails.application.routes.url_helpers

  def recognition_name_and_calorie
    # 画像をBase64エンコード
    image_url = rails_blob_url(meal_image)
    image_data = URI.open(image_url, &:read)
    base64_image = Base64.encode64(image_data)
    # Data URIを作成
    data_uri = "data:image/png;base64,#{base64_image}"
    # chatGPTへ送信しレスポンスを受け取る
    client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key))
    response = client.chat(
      parameters: {
        model: 'gpt-4o',
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
    response.dig('choices', 0, 'message', 'content')
  end
end
