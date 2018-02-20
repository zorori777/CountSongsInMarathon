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

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
          when Line::Bot::Event::MessageType::Location
            location = Location.new(
              post_code: event.message['address'].match(/\d\d\d-\d\d\d\d/).to_s,
              address: event.message['address'].gsub(/〒\d\d\d-\d\d\d\d /, "")
            )
            location.save!
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
end
