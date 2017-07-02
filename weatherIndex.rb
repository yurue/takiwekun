# coding: utf-8

require 'open-uri'
require 'nokogiri'

def get_weather_index
  # スクレイピング先のURL
  url = [
    'http://www.tenki.jp/indexes/cloth_dried/2/6/3310.html',
    'http://www.tenki.jp/indexes/dress/2/6/3310.html',
    'http://www.tenki.jp/indexes/starry_sky/2/6/3310.html',
    'http://www.tenki.jp/indexes/umbrella/2/6/3310.html',
    'http://www.tenki.jp/indexes/beer/2/6/3310.html'
  ]

  charset = nil

  weatherIndex = {}

  for i in 0..4 do
    html = open(url[i]) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを作成
    doc = Nokogiri::HTML.parse(html, nil, charset)

    dateIndex = {}

    # 指数の名前 例 : /index/beer/
    index_name = doc.xpath('//li[@class="selected"]/a/@href')[1].inner_text
    index_name.slice!(0, 9)
    index_name.slice!('/')

    # 今日の指数
    today_index = doc.xpath('//dl[@id="exponentLargeLeft"]/dd/dl/dd').inner_text.to_i

    # 明日の指数
    tomorrow_index = doc.xpath('//dl[@id="exponentLargeRight"]/dd/dl/dd').inner_text.to_i

    dateIndex['today'] = today_index
    dateIndex['tomorrow'] = tomorrow_index

    weatherIndex[index_name] = dateIndex
  end

  # 紫外線のスクレイピング
  html = open('http://www.tenki.jp/indexes/uv_index_ranking/2/6/3310.html') do |f|
    charset = f.charset # 文字種別を取得
    f.read # htmlを読み込んで変数htmlに渡す
  end

  # htmlをパース(解析)してオブジェクトを作成
  doc = Nokogiri::HTML.parse(html, nil, charset)

  dateIndex = {}

  # 指数の名前
  index_name = doc.xpath('//li[@class="selected"]/a/@href')[1].inner_text
  index_name.slice!(0, 9)
  index_name.slice!('/')

  # 今日の指数
  today_index = doc.xpath('//dl[@id="exponentLargeLeft"]/dd/span').inner_text

  # 明日の指数
  tomorrow_index = doc.xpath('//dl[@id="exponentLargeRight"]/dd/span').inner_text

  dateIndex['today'] = today_index
  dateIndex['tomorrow'] = tomorrow_index

  weatherIndex[index_name] = dateIndex

  weatherIndex
end
