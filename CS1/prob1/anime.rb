# anime.rb
# Author: Kazuki Asakura

# 予約用の行
$reserveLines = []
# 表示用の行
$displayLines = Array.new(10)
# 車表示用のレイヤーデータ
$carLines = [
    0,
    0,
    0,
    0,
    0,
    1000000000000000000,
    111110000000000000000,
    100010000000000000000,
    100010000000000000000,
    0
]

# 表示する行を追加
def addDisplayLine(newLine)
    $displayLines.pop              # 最後の要素を削除
    $displayLines.unshift(newLine) # 新しい要素を先頭に追加
end

# displayLinesの内容を表示
def printLines
    puts "\e[H\e[2J" # clear
    for i in 0..9
        puts $displayLines[i] + $carLines[i] # 道路レイヤーに車を合成
    end
    sleep(0.3)
end

# 道路を作成、予約
def createRoad(length)
    for i in 0..length
        if i % 5 <= 1
            $reserveLines.unshift(1000000000000000000000001)
        else
            $reserveLines.unshift(1000000000001000000000001)
        end
    end
end

# init
createRoad(100)
for i in 0..9
    $displayLines.unshift($reserveLines.pop)
end
# reserveLinesが空になるまでコマ送り
while ! $reserveLines.empty? do
    addDisplayLine($reserveLines.pop)
    printLines()
end
