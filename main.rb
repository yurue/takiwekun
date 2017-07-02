# coding: utf-8

require 'date'

require 'net/http'
require 'uri'
require 'json'

require './tweet'
require './todayWeather'
require './tomorrowWeather'
require './livedoorWeather'
require './weatherIndex'
require './laundryIndex'
require './clothesIndex'
require './starIndex'
require './umbrellaIndex'
require './ultravioletIndex'
require './beerIndex'

weather_index = get_weather_index

# 【何時に何を呟くか　CRON実行　→ 5 7,9,12,18,21 * * * 】
#  7時	:	今日の天気 get_today_weather を実行,
#   		今日のアウトライン get_outline_weather を実行,
#   		傘指数 get_today_umbrella を実行,
#   		紫外線指数 get_today_ultraviolet　を実行
#  9時:	洗濯指数　	get_today_laundry　を実行
# 12時:	今日の今からの天気　get_outline_weather を実行,
#    		これからの今日の降水確率
# 18時:	明日の天気 get_tomorrow_weather を実行,
#   		星空指数 	get_today_star を実行,
#   		ビール指数 get_today_beer　を実行
# 21時:	明日の天気 get_tomorrow_weather を実行,
#   		いまから明日にかけてのアウトライン get_outline_weather を実行,
#   		星空指数 get_today_star を実行

# 現在時刻取得
now_hour = DateTime.now.hour

case now_hour
when 7 then
  # 7時に...

  # 今日の天気をつぶやく
  todayWeather = get_today_weather
  puts todayWeather
  do_tweet(todayWeather)

  # 今日のアウトラインをつぶやく
  todayOutline = get_outline_weather
  puts todayOutline
  do_tweet(todayOutline)

  # 今日の傘指数をつぶやく
  todayUmbrella = get_today_umbrella(weather_index)
  puts todayUmbrella
  do_tweet(todayUmbrella)

  # 今日の紫外線指数をつぶやく
  todayUltraviolet = get_today_ultraviolet(weather_index)
  puts todayUltraviolet
  do_tweet(todayUltraviolet)

when 8 then
  # 8時に...

  # 今日の服装指数をつぶやく
  todayClothes = get_today_clothes(weather_index)
  puts todayClothes
  do_tweet(todayClothes)

when 9 then
  # 9時に...

  # 今日の洗濯指数をつぶやく
  todayLaundry = get_today_laundry(weather_index)
  puts todayLaundry
  do_tweet(todayLaundry)

when 12 then
  # 12時に...

  # 今日のこれからのアウトラインをつぶやく
  todayOutline = get_outline_weather
  puts todayOutline
  do_tweet(todayOutline)

when 18 then
  # 18時に...

  # 明日の天気をつぶやく
  tomorrowWeather = get_tomorrow_weather
  puts tomorrowWeather
  do_tweet(tomorrowWeather)

  # 星空指数をつぶやく
  todayStar = get_today_star(weather_index)
  puts todayStar
  do_tweet(todayStar)

  # ビール指数をつぶやく
  todayBeer = get_today_beer(weather_index)
  puts todayBeer
  do_tweet(todayBeer)

when 21 then
  # 21時に...

  # 明日の天気をつぶやく
  tomorrowWeather = get_tomorrow_weather
  puts tomorrowWeather
  do_tweet(tomorrowWeather)

  # 今日明日にかけてのアウトラインをつぶやく
  todayOutline = get_outline_weather
  puts todayOutline
  do_tweet(todayOutline)

  # 星空指数をつぶやく
  todayStar = get_today_star(weather_index)
  puts todayStar
  do_tweet(todayStar)

  # 明日の服装指数をつぶやく
  tomorrowClothes = get_tomorrow_clothes(weather_index)
  puts tomorrowClothes
  do_tweet(todayClothes)

else
  puts 'エラー：どこにも当てはまらない時間のため何も呟かない'
end
