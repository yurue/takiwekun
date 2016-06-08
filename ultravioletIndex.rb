# coding: utf-8

# 紫外線指数の値をスクレイピングにより取得し、指数値を元に紫外線に対するコメントを
# 付けて文章化するモジュール。

def get_ultraviolet_comment(ultraviolet_value)
	# 紫外線指数値からいい感じのコメントでその日紫外線の強さがどうかアドバイスする文章を生成する関数
	# 引数にultraviolet_value(紫外線指数値)を渡すと、それに見合った外出の際の紫外線へのアドバイスを行います。

	ultraviolet_value_to_comment = {
		"弱い" => "特に心配はいらないかとおもいます",
		# "やや弱い" => "特に心配いらない紫外線指数値ではありますが、心配であれば日焼け止めを。",
		"やや強い" => "日焼け止めクリームを使った方がよさそうです。",
		"強い" => "帽子をかぶり、日焼け止めを使った方がよさそうです。いつもバッグに常備すると安心です。",
		"非常に強い" => "日焼け止めクリーム必須です。日中外を歩く場合は帽子や日傘が必要かも。",
		"きわめて強い" => "水脹れ、発熱が生じることも。"
	}

	return ultraviolet_value_to_comment[ultraviolet_value]
end

def get_today_ultraviolet(weather_index)
	# 取得した今日の紫外線指数を整形して文章にして渡す関数
	# 例：	今日の紫外線指数：やや強い
	# 		日焼け止めクリームを使った方がよさそうです。

	# 今日の紫外線指数の値を代入
	ultraviolet_value = weather_index['uv_index_ranking']['today']
	# 値とコメントをいい感じに整形
	today_ultraviolet_main = "今日の紫外線指数：#{ultraviolet_value}\n" +
							 "#{get_ultraviolet_comment(ultraviolet_value)}"

	return today_ultraviolet_main
end

def get_tomorrow_ultraviolet(weather_index)
	# 取得した明日の紫外線指数を整形して文章にして渡す関数
	# 例：	明日の紫外線指数：強い
	# 		帽子をかぶる、日焼け止めを使った方がよさそうです。いつもバッグに常備すると安心です。

	# 明日の紫外線指数の値を代入
	ultraviolet_value = weather_index['uv_index_ranking']['tomorrow']
	# 値とコメントをいい感じに整形
	tomorrow_ultraviolet_main = "明日の紫外線指数：#{ultraviolet_value}\n" +
								"#{get_ultraviolet_comment(ultraviolet_value)}"

	return tomorrow_ultraviolet_main
end