require "csv"
require "pry"

class Usage_charge
  def self.import(path)
    #全てを読込、配列を作成
    CSV.read("csv/tokyo_energy_partner/usage_charge.csv", headers: true).map do |row|
      {
        kwh: row["kwh"],
        unit_price: row["unit_price"]
      }
    end
  end
end