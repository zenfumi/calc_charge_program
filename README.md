### 電気料金計算プログラム
- ユーザーが１ヶ月の使用量（kWh）を入力すると各プラン名およびそのプランの電気料金を返すSimulatorクラスを実装(小数点切り捨て)
- Simulatorクラスの利用例

### 動作確認方法
- git clone 後、以下のコマンドを実行してください。

```
simulator = Simulator.new(40, 280)
simulator.simulate
#=> [{ provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: '1234' }, …]
```

### プログラムの条件
- Simulatorクラスのインスタンス生成時の第一引数に契約アンペア、第二引数に１ヶ月の使用量（kWh）を与える。
- Simulatorクラスのインスタンスメソッドであるsimulatorメソッドを実行することでプラン名およびそのプランの電気料金が配列で出力されるようにする。同等の結果が得られるならば、引数や返り値を拡張しても可。
- 電気料金の計算方法
  - 電気料金 = ①基本料金 + ②従量料金 + ③そのほか(③は考慮しなくてOK)
- ①②③詳細
  - ①基本料金 契約アンペア数によって、料金が異なります。
  - ②従量料金（電力量料金） 電気使用量（kWh）に対する料金です。
  - ③そのほか 燃料費調整額や再エネ発電賦課金などが含まれます。
- 計算対象のプランは、東京電力エナジーパートナー 従量電灯B、Looopでんき おうちプラン、東京ガス ずっともでんき１の３つのプランとしています。それぞれの料金表はHPを参照
  - [東京電力エナジーパートナー 従量電灯B](http://www.tepco.co.jp/ep/private/plan/old01.html)
  - [Looopでんき おうちプラン](https://looop-denki.com/low-v/plan/)
  - [東京ガス ずっとも電気１](https://home.tokyo-gas.co.jp/power/ryokin/menu_waribiki/menu1.html)
  - [JXTGでんき 従量電灯Bたっぷりプラン](https://mydenki.jp/files/plan_tappuri.pdf) 
- 契約アンペアの範囲は、10A、15A、20A、30A、40A、50A、60Aの範囲とする。
  - ただし同様の料金体系のプランが追加されてもロジックを追加せずに済むようにする。

### 実装や設計の理由(オブジェクト指向、汎用化、品質担保、アプローチ方法の観点から)

- 登場人物ごとにクラス・情報・役割を意識しました(誰が何をする)

  - Simulator クラス → 情報：料金プラン、計算対象データ 役割：料金プランの計算及び計算結果の表示
  - Plan クラス → 役割: プロバイダと料金プラン名の取得
  - Basic_charge クラス → 役割：基本料金計算に使用するデータの取得
  - Usage_charge クラス → 役割：電気量料金計算に使用するデータの取得

- CSV にデータ関連を切り出す

  - 計算メソッド内での数字のベタ書きを避ける
  - データ保持の役割を Simulator クラスから外す
  - CSV データの変更に対応させる為
  - 可読性が良くなる(計算対象データが計算メソッド内にあると処理が増えるにつれ、処理が見づらくなる)

- RSpec 実装(配列数と計算結果を対象にテスト)
  - 20A,30A,40A を対象。
  - 120/121kwh,140/141kwh,300/301kwh,350/351kwh,600/601kwh を対象

### 悩んだこと
- 料金体系のプランが追加されてもロジックは追加せずに済むようにする部分
  - 当初、各プランごとにメソッドを設定していたが、メソッドを共通化させた。

### 今後、修正を考えている点、課題

- 料金体系プランが追加されてもロジックを追加しないようにする(現状、CSVのインポートの追加が必要)
- マジックナンバーを避ける(CSV データの変更に対応できるように)
- 入力値(A,kwh)のテスト
- Rubocop の導入
- 使用量 0kwh や基本料金半額のプランの対応
- クラスの責任・役割の整理を行い、再利用可能にする
- simulator メソッド内のインポート部分の記述を切り出す
- シーケンス図導入
- Plan をオブジェクト化した形で情報を持たせる。
- CSV から欲しい情報を検索する為のクラスを作る(見通しがよくなる)

### 勉強になった点

- 相対パスについて
- self の使い方(メソッドの中でメソッドを呼び出す)
- テストを書く目的について
  - リファクタリングしても壊れていないことを証明する役割、コードが要件を満たしているか等
  - ここが壊れたら致命的という要件からテストを固める(今回でいうと正しく計算できること)
  - テストを通じて期待する値にならずに、間違いに気づくことができました。
- RSpec の知識
  - to contain_exactly

### 参考書籍
- 参考書籍 プロを目指す人のためのRuby入門、オブジェクト指向設計実践ガイド、オブジェクト指向でなぜつくるのか
- schoo内のオブジェクト指向に関する動画、Qiitaの関連記事
















