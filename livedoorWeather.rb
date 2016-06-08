# coding: utf-8

require 'net/http'
require 'uri'
require 'json'

require './weatherImage'
require './transformationTone'

def get_livedoor_weather(id)
	# Livedoor Weather Web Serviceの天気を取得する関数
	# - 取得して return で結果を返す

	# JSONデータ取得先
	livedoor_uri = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=' + id
	uri = URI.parse(livedoor_uri)
	json = Net::HTTP.get(uri)
	result = JSON.parse(json)
end

def description_formating(weather_outline)
	# 取得した天気情報の概要（descriptionのtext）情報を整形する関数
	# - そのままdescription,textを出力すると200文字近い。
	# - Twiterの制限文字数は140文字なため、そのままだとツイートできない。
	# - そこで、余分な情報をスライス等して140文字以内にまとめる。

	# 改行コードの削除
	temporarily = weather_outline.gsub(/[\r\n]/,"")
	# 岩手県以前の文章は不要なため、岩手県のindexを取得
	start_index = temporarily.index('岩手県')
	# <天気変化等の留意点>は不要なので < のindexを取得
	end_index = temporarily.index('<') - 1
	# 文字列を必要な範囲で指定してスライスしリターン
	return temporarily.slice(start_index..end_index)
end

def get_outline_weather()
	# 現在からの天気の見通しであるアウトラインを生成する関数
	# 例:	明日の傘指数：30現在の岩手県滝沢市は、曇りや晴れで、雨や雷雨となっている所があります。
	# 		3日夜は、気圧の谷の影響によって、曇りで雨や雷雨となる所があると思います。
	# 		4日は、高気圧に覆われて晴れますが、気圧の谷や寒気の影響によって、
	# 		朝晩は曇りで雨の降る所がある見込みです。

	# livedoorの天気を取得する(岩手県内陸)
	weather_live = get_livedoor_weather('030010')

	weather_outline = description_formating(weather_live['description']['text'])
	soft_weather_outline = get_soft_tone(weather_outline)
	return soft_weather_outline
end