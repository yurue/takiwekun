# coding: utf-8

# 天気指数の値をスクレイピングにより取得し、値を元に選択に対するコメントを
# 付けて文章化するモジュール。

def get_laundry_comment(laundry_value)
	# 洗濯指数からいい感じのコメントでその日の洗濯をアドバイスする文章を生成する関数
	# 引数にlaundry_value(洗濯指数)を渡すと、それに見合った洗濯アドバイスを行います。

	laundry_value_to_comment = {
		0 => "ほとんど乾きません。除湿器があればなんとか…。",
		10 => "部屋干しがいいです。プラス除湿器があればいいかも。",
		20 => "乾きづらいので、朝から干してもあまり乾かないかも。室内干しをオススメします。",
		30 => "雨に濡れちゃう可能性もあるので部屋干しがいいかも。乾燥機があれば使うことをオススメします。",
		40 => "早い時間に洗濯すれば、夕方にはなんとか乾くかも。じっくり干せば問題なし。",
		50 => "シャツや薄手の服、化学繊維のものは乾くかもしれない。",
		60 => "朝に干せば厚くない洋服であれば、乾きます。",
		70 => "Tシャツは乾くけど、厚手のものは乾きづらいです。",
		80 => "昼に洗濯しても夕方までには乾くかも。洗濯日和です。",
		90 => "バスタオルもバッチリ乾く洗濯日和です！",
		100 => "ジーンズも厚手の洋服もバッチリ乾く、絶好の洗濯日和です！"
	}

	return laundry_value_to_comment[laundry_value]
end

def get_today_laundry(weather_index)
	# 取得した今日の洗濯指数を整形して文章にして渡す関数
	# 例：	今日の洗濯指数：30
	# 		雨に濡れちゃう可能性もあるので部屋干しがいいかも。乾燥機があれば使うことをオススメします。

	# 今日の洗濯指数の値を代入
	laundry_value = weather_index['cloth_dried']['today']
	# 値とコメントをいい感じに整形
	today_laundry_main = "今日の洗濯指数：#{laundry_value}\n" +
						 "#{get_laundry_comment(laundry_value)}"

	return today_laundry_main
end

def get_tomorrow_laundry(weather_index)
	# 取得した明日の洗濯指数を整形して文章にして渡す関数
	# 例：	明日の洗濯指数：70
	# 		Tシャツは乾くけど、厚手のものは乾きづらいです。

	# 明日の洗濯指数の値を代入
	laundry_value = weather_index['cloth_dried']['tomorrow']
	# 値とコメントをいい感じに整形
	tomorrow_laundry_main = "明日の洗濯指数：#{laundry_value}\n" +
							"#{get_laundry_comment(laundry_value)}"

	return tomorrow_laundry_main
end