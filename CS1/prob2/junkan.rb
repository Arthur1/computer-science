# junkan.rb
# 配列の使い方の練習（循環小数を循環するまで求める）
# 入力: d
# 出力: 1/d の各桁を循環するまで求める

puts("分母 d を下さい")
d = gets().to_i
print("1 / ", d, " を求めます\n")

leng = 0; x = 1
rList = Array.new(d) # 余りの整数を格納する配列
qList = Array.new(d) # 除の位の値を格納する配列

# 1の例外処理
if d == 1
    print('1')
    exit
end

while true
    x = x * 10
    q = x / d
    r = x % d

    # 出力
    print(leng + 1, ':', q, "\n")
    sleep(0.5)
    qList[leng] = q
    rList[leng] = r

    # 割り切れるなら終了
    if r == 0
        print('Answer: 0.', qList[leng], "\n")
        break
    end

    for i in 0..(leng - 1)
        # 余りと除の位の値それぞれが等しい組み合わせがあったとき
        if r == rList[i] and q == qList[i]
            repeatBeginKey = i
            # 循環していない部分を表示
            print('Answer: 0.')
            for j in 0..(repeatBeginKey - 1)
                print(qList[j])
            end
            # 循環節を表示
            repeatEndKey = leng - 1
            print('(')
            for j in repeatBeginKey..repeatEndKey
                print(qList[j])
            end
            print(')')
            print("\n")
            exit
        end
    end

    # 次のループの準備
    leng = leng + 1
    x = r
end