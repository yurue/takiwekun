# coding: utf-8

# です→だよ！ のように天気予報を堅苦しくなく
# 文字列変換し、口調を柔らかくするためのモジュール。

def replace(content)
	content.gsub(/岩手県/, '現在の岩手県滝沢市')
	.gsub(/より、/, 'よって、')
	.gsub(/います/, 'いるよ')
	.gsub(/概ね/, 'おおむね')
	.gsub(/ため/, 'から')
	.gsub(/でしょう/, 'と思います')
end

def get_soft_tone(content)
	return replace(content)
end