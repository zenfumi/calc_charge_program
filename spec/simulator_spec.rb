require_relative '../lib/simulator.rb'

RSpec.describe Simulator do
  describe "プラン名とそのプラン料金を配列で返す" do
    subject {simulator.simulate}
    context "有効なシミュレーション" do
      it "10Aの場合は2つの電力会社のプランを返す" do
        simulator = Simulator.new(10, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"2395"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"}
        )
      end
    end
  end
end