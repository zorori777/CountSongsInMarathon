class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
          when Line::Bot::Event::MessageType::Location
            location = Location.new(
              address: set_address(event.message),
              post_code: set_post_code(event.message)
            )
            location.save!

            message = {
              "type": "template",
              "altText": "わたさん頑張ってるらしいよww",
              "template": {
                "type": "image_carousel",
                "columns": [
                  {
                    "imageUrl": "https://c1.staticflickr.com/9/8132/29971985550_e666791121_b.jpg",
                    "action": {
                      "type": "uri",
                      "label": "神曲!!",
                      "uri": "https://countsongs.herokuapp.com/auty"
                    }
                  }
                ]
              }
            }
          else
            # deployなどが安定したら画像を使えるようにしたい
            message = {
              type: 'text',
              text: "反応いたしません。"
            }
        end
        client.reply_message(event['replyToken'], message)
    end
    }
    head :ok
  end

  def set_post_code(message)
    message['address'].match(/\d\d\d-\d\d\d\d/).to_s
  end

  def set_address(message)
    message['address'].gsub(/〒\d\d\d-\d\d\d\d /, "")
  end
end
