require_relative '../lib/simulator.rb'

RSpec.describe Simulator do
  describe "料金計算シミュレーション" do
    context "有効なシミュレーション" do
      it "10Aの場合は2つの電力会社のプランを返す" do
        simulator = Simulator.new(10, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"2671"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"}
        )
      end
      it "30Aの場合は3つの電力会社のプランを返す" do
        simulator = Simulator.new(30, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3243"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"3698"}
        )
      end
    end
  end
end