# coding: utf-8

require "twitter"

# tweetモジュール
# do_Tweetを呼び出せばかんたんにtweetできるモジュール

# ツイッターのAPIキー
CONSUMER_KEY = ""
CONSUMER_SECRET = ""
ACCESS_TOKEN_KEY = ""
ACCESS_TOKEN_SECRET = ""


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