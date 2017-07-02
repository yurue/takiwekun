# coding: utf-8

require 'twitter'

# tweetモジュール
# do_Tweetを呼び出せばかんたんにtweetできるモジュール

# ツイッターのAPIキー
CONSUMER_KEY = ''.freeze
CONSUMER_SECRET = ''.freeze
ACCESS_TOKEN_KEY = ''.freeze
ACCESS_TOKEN_SECRET = ''.freeze

def do_tweet(content)
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = CONSUMER_KEY
    config.consumer_secret = CONSUMER_SECRET
    config.access_token = ACCESS_TOKEN_KEY
    config.access_token_secret = ACCESS_TOKEN_SECRET
  end

  # ツイート
  client.update(content)
end
