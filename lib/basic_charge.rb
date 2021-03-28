require "csv"
require "pry"

class Basic_charge
  def self.import(path)
    if path[:path].include?("tokyo_energy_partner")
    CSV.read("csv/tokyo_energy_partner/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end

    elsif path[:path].include?("loop")
    CSV.read("csv/loop/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end

    elsif path[:path].include?("tokyogas")
    CSV.read("csv/tokyogas/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end

    elsif path[:path].include?("jxtg")
    CSV.read("csv/jxtg/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end
  end
end
end