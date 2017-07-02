# coding: utf-8

# 服装指数の値をスクレイピングにより取得し、指数値を元にとコメントを
# 付けて文章化するモジュール。

def get_clothes_comment(clothes_value)
  # 服装指数値からいい感じのコメントでその日かアドバイスする文章を生成する関数
  # 引数にclothes_value(服装指数値)を渡すと、等とアドバイスを行います。

  clothes_value_to_comment = {
    0 => 'ダウンジャケット、マフラー、手袋が必要かも。',
    10 => 'ダウンジャケットを着て出かけよう。',
    20 => 'マフラーと手袋が欠かせません。',
    30 => 'コートを着ないと結構寒いなあ。',
    40 => 'セーターが必要になりそうだね。',
    50 => '薄手のカーディガンが欲しいな。',
    60 => '昼間は長袖一枚着れば十分。',
    70 => '朝晩は上着が欲しい涼しさです。',
    80 => '半袖のポロシャツで過ごせそう。',
    90 => 'Tシャツ一枚で過ごせる暑さだ。',
    100 => 'Tシャツ一枚でもかなり暑い。'
  }

  clothes_value_to_comment[clothes_value]
end

def get_today_clothes(weather_index)
  # 取得した今日の服装指数を整形して文章にして渡す関数
  # 例：	今日の服装指数：60
  # 		昼間は上着が欲しい涼しさです。

  # 今日の服装指数の値を代入
  clothes_value = weather_index['dress']['today']
  # 値とコメントをいい感じに整形
  today_clothes_main = "今日の服装指数：#{clothes_value}\n" \
                            "#{get_clothes_comment(clothes_value)}"

  today_clothes_main
end

def get_tomorrow_clothes(weather_index)
  # 取得した明日の服装指数を整形して文章にして渡す関数
  # 例：	明日の服装指数：70
  # 		朝晩は上着が欲しい涼しさです。

  # 明日の服装指数の値を代入
  clothes_value = weather_index['dress']['tomorrow']
  # 値とコメントをいい感じに整形
  tomorrow_clothes_main = "明日の服装指数：#{clothes_value}\n" \
                                "#{get_clothes_comment(clothes_value)}"

  tomorrow_clothes_main
end
