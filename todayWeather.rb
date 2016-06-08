# coding: utf-8

require './weatherImage'

# スクレイピング関係
require 'date'
# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# 朝につぶやく「きょうの天気」
# get_outline_weather関数は、本日の天気のアウトライン
# get_today_weather関数は、本日の天気の概要（天気、気温、降水確率）

def get_today_weather()
	# 今日の天気をツイートする形に文章を生成する関数
	# 例：	滝沢市の天気をお知らせ！
	# 		本日X月X日（X）は曇り☁のち雨☔で、
	# 		最高気温は23℃[+3], 最低気温は14℃[-3]となる見込みです。
	# 		降水確率は…
	# 		06-12:---
	# 		12-18:---
	# 		18-24:60％
	# 		という予報になっています。

	# 今日の日付を取得
	today_date = Date.today
	week = %w[日 月 火 水 木 金 土]

	# ウェブスクレイピングした天気を取得
	weather_scraping = 'http://www.tenki.jp/forecast/2/6/3310/3216-daily.html'

	charset = nil
	html = open(weather_scraping) do |f|
		charset = f.charset # 文字種別を取得
		f.read # htmlを読み込んで変数htmlに渡す
	end

	# htmlをパース（解析）してオブジェクトを生成
	doc = Nokogiri::HTML.parse(html, nil, charset)

	# 今日の天気を取得
	today_forecast = get_image(doc.xpath('//p[@class="wethreDrtalIiconText"]')[0].inner_text)
	# 今日の最高気温を取得
	today_maxTemp = doc.xpath('//tr[@class="highTemp"]/td[@class="temp"]/span[@class="bold"]')[0].inner_text
	today_maxTempDiff = doc.xpath('//tr[@class="highTemp"]/td[@class="tempdiff"]')[0].inner_text
	#　今日の最低気温を取得
	today_minTemp = doc.xpath('//tr[@class="lowTemp"]/td[@class="temp"]/span[@class="bold"]')[0].inner_text
	today_minTempDiff = doc.xpath('//tr[@class="lowTemp"]/td[@class="tempdiff"]')[0].inner_text
	# 今日の降水確率を取得
	rainyper_6_12 = doc.xpath('//tr[@class="rainProbability"]/td')[1].inner_text
	rainyper_12_18 = doc.xpath('//tr[@class="rainProbability"]/td')[2].inner_text
	rainyper_18_24 = doc.xpath('//tr[@class="rainProbability"]/td')[3].inner_text

	# 滝沢市／今日の天気
	today_weather_announce = "滝沢市の天気をお知らせ！\n" +
							 "本日#{today_date.month}月#{today_date.day}日(#{week[today_date.wday]})は" +
							 "#{today_forecast}で、\n" +
							 "最高気温は#{today_maxTemp}℃#{today_maxTempDiff}、" +
							 "最低気温は#{today_minTemp}℃#{today_minTempDiff}となる見込みです。\n" +
							 "降水確率は…\n" +
							 "06-12 : #{rainyper_6_12}\n" +
							 "12-18 : #{rainyper_12_18}\n" +
							 "18-24 : #{rainyper_18_24}\n" +
							 "という予報になっています。"

	return today_weather_announce
end