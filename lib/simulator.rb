require "pry"
require_relative "plan"

class Simulator

  def initialize(amp,usage_per_week)
    @amp = amp
    @usage_per_week = usage_per_week
  end

  def simulate
    # プロバイダと料金プランのCSVデータをインポート
    plans = Plan.import(path: "plans.csv")
    # 該当プランに計算結果(メソッドの返り値)のハッシュを追加
    plans.each do |plan|
      case
      when plan[:provider_name] == "東京電力エナジーパートナー" then plan[:price]= "#{self.calc_planA(@amp,@usage_per_week)}"
      when plan[:provider_name] == "Looopでんき" then plan[:price]= "#{self.calc_planB(@amp,@usage_per_week)}"
      when plan[:provider_name] == "東京ガス" && [30,40,50,60].include?(@amp) then plan[:price] = "#{self.calc_planC(@amp,@usage_per_week)}"
      end
    end
    puts plans

    #以下の方法だとプランが追加されると対応できず、面倒な追記となる。
    # if @amp >= 30
    # output_params = [
    #   {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{self.calc_planA(@amp,@usage_per_week)}"},
    #   {provider_name: " Looopでんき", plan_name: "おうちプラン", price: "#{self.calc_planB(@amp,@usage_per_week)}"},
    #   {provider_name: " 東京ガス", plan_name: "ずっとも電気１", price: "#{self.calc_planC(@amp,@usage_per_week)}"}
    #   ]

    # ## 東京ガスのずっとも電気は30Aからのプランである為、30A未満は表示させない。
    # else
    # output_params = [
    #   {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{self.calc_planA(@amp,@usage_per_week)}"},
    #   {provider_name: " Looopでんき", plan_name: "おうちプラン", price: "#{self.calc_planB(@amp,@usage_per_week)}"}
    #   ]
    # end

    # puts output_params
  end

  private
  #各プランを各メソッドで計算する

  #東京電力エナジーパートナーの従量電灯Bの計算メソッド
  def calc_planA(amp,usage_per_week)
    basic_charge =
      case amp
      when 10
        286
      when 15
        286
      when 20
        572
      when 30
        858
      when 40
        1144
      when 50
        1430
      when 60
        1716
      end

    usage_charge =
      if usage_per_week <= 120 then 19.88*usage_per_week
      elsif usage_per_week <= 300 then 19.88*120 + 26.48*(usage_per_week-120)
      elsif usage_per_week > 300 then 19.88*120 + 26.48*180 + 30.57*(usage_per_week-300)
      else '???'
      end

    ## 最後の評価式
    total_charge = (basic_charge + usage_charge).floor
  end

  # Looopでんきのおうちプランの計算メソッド
  def calc_planB(amp,usage_per_week)
    basic_charge = 0

    usage_charge = usage_per_week*26.4

  # 最後の評価式
    total_charge = (basic_charge + usage_charge).floor
  end

  # 東京ガスのずっとも電気１の計算メソッド
  def calc_planC(amp,usage_per_week)
    basic_charge =
    if amp == 10 then 858
    elsif amp == 15 then 858
    elsif amp == 20 then 858
    elsif amp == 30 then 858
    elsif amp == 40 then 1144
    elsif amp == 50 then 1430
    elsif amp == 60 then 1716
    else '???'
    end

    usage_charge =
    if usage_per_week <= 140 then 23.67*usage_per_week
    elsif usage_per_week <= 350 then 23.67*140 + 23.88*(usage_per_week-140)
    elsif usage_per_week > 350 then 23.67*140 + 23.88*210 + 26.41*(usage_per_week-350)
    else '???'
    end

    # 最後の評価式
    total_charge = (basic_charge + usage_charge).floor
  end
end


# ****************実行部分***************************************************************

## 契約アンペアを入力
while true
print "契約アンペアを入力して下さい > "
  amp = gets.to_i
  break if [10,15,20,30,40,50,60].include?(amp)
    puts "10,15,20,30,40,50,60のいずれかを入力して下さい"
end

## 1ヶ月あたりの使用量を入力させる
while true
print "1ヶ月あたりの使用量を入力して下さい > "
  usage_per_week = gets.to_i
  break if usage_per_week >= 0
    puts "0以上の値を入力して下さい"
end

# シミュレーターの生成(Simulatorクラスのインスタンスを生成)
simulator = Simulator.new(amp,usage_per_week)
# 生成されたインスタンスに対してsimulateメソッドを実行して出力結果を表示
simulator.simulate