# coding: utf-8

# 傘指数の値をスクレイピングにより取得し、値を元に傘に対するコメントを
# 付けて文章化するモジュール。

def get_umbrella_comment(umbrella_value)
  # 傘指数からいい感じのコメントでその日傘が必要かどうかアドバイスする文章を生成する関数
  # 引数にumbrella_value(傘指数)を渡すと、それに見合った外出の際の傘の必要性をアドバイスを行います。

  umbrella_value_to_comment = {
    0 => '傘は必要ありません！',
    10 => '傘を持って行かなくても大丈夫です！',
    20 => '傘を使うことは恐らくなさそうなので、持って行かなくても大丈夫です。',
    30 => '降ってもそこまで濡れないと思うので傘は必要なさそう。',
    40 => '折りたたみ傘がカバンに入っていると安心かも。',
    50 => '折りたたみ傘を持って出かけよう！',
    60 => '傘を持って出かけた方が安心です。',
    70 => '傘を持って出かけましょう。',
    80 => '雨が降りそうです。傘を持って出かけましょう。',
    90 => '小さめの傘だと心もとないかも。大きい傘を持って出かけましょう！',
    100 => '傘を持って出かけよう！'
  }

  umbrella_value_to_comment[umbrella_value]
end

def get_today_umbrella(weather_index)
  # 取得した今日の傘指数を整形して文章にして渡す関数
  # 例：	今日の傘指数：70
  # 		傘を持って出かけましょう。

  # 今日の傘指数の値を代入
  umbrella_value = weather_index['umbrella']['today']
  # 値とコメントをいい感じに整形
  today_umbrella_main = "今日の傘指数：#{umbrella_value}\n" \
                             "#{get_umbrella_comment(umbrella_value)}"

  today_umbrella_main
end

def get_tomorrow_umbrella(weather_index)
  # 取得した明日の傘指数を整形して文章にして渡す関数
  # 例：　明日の傘指数：30
  # 		降ってもそこまで濡れないと思うので傘は必要なさそう。

  # 明日の傘指数の値を代入
  umbrella_value = weather_index['umbrella']['tomorrow']
  # 値とコメントをいい感じに整形
  tomorrow_umbrella_main = "明日の傘指数：#{umbrella_value}\n" \
                                 "#{get_umbrella_comment(umbrella_value)}"

  tomorrow_umbrella_main
end
