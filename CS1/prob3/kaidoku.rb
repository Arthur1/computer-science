# kaidoku.rb
# 解読プログラム
# 入力: 暗号文の文字列
# 出力: 復号した平文

# 平文を暗号化するサブルーチン
# dec(秘密鍵 k, 暗号文 c) = 平文 m
def dec(k, c)
    code_a = 97                # 文字 a の文字コード
    kosu = 26                  # 英字アルファベットの数
  
    leng = c.length            # 文字列の長さ
    a = c.unpack("C*")         # 文字列から文字コードの配列へ変換
    b = Array.new(leng)        # 暗号文（のコード）格納用配列
  
    for i in 0..leng-1
        code = a[i]                 # i 文字目のコードを得る
        sa = code - code_a          # 文字 a からの差分
        if 0 <= sa and sa < kosu    # 小文字ならば文字をkの数分だけずらす
            sa = (sa - k) % kosu
        end
        b[i] = sa + code_a
    end
    m = b.pack("C*")              # コードの配列を文字列に直す
    return(m)
end
# サブルーチン dec （終）

##### プログラム本文 #####
# 入力と準備
code_a = 97                # 文字 a の文字コード
kosu = 26                  # 英字アルファベットの数
angobun = gets.chomp       # 暗号文を入力（注：入力文字列から改行を除去）
leng = angobun.length      # 暗号文の長さを leng に格納
a = angobun.unpack("C*")   # 文字列から文字コードの配列へ変換
hindo = Array.new(kosu, 0) # 頻度配列の準備
  
# 頻度配列の作成
for i in 0..leng-1
    code = a[i]                       # i 文字目のコードを得る
    sa = code - code_a                # 文字 a からの差分
    if 0 <= sa and sa < kosu          # 小文字なら
        hindo[sa] = hindo[sa] + 1         # 頻度配列の該当する要素をインクリメント
    end
end
puts(hindo)  ## 確認用
  
# 最頻文字の位置（差分）の確定
max = 0
maxj = -1
    for j in 0..(kosu-1)
        if hindo[j] > max
            max = hindo[j]
            maxj = j
        end
    end
puts(max, maxj)  ## 確認用
  
k = (maxj + 1 - 5) % kosu      # maxj から暗号鍵を求める
hirabun = dec(k, angobun)  # この暗号鍵で平文に変換
puts(hirabun)              # 解読平文を出力
