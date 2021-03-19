require "csv"
require "pry"

class Basic_charge
  def self.import(path)
    #全てを読込、配列を作成
    CSV.read("csv/tokyo_energy_partner/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end
  end
end