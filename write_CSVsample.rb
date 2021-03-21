require "csv"

CSV.open("usage_charge.csv", "wb") do |csv|
  csv << ["kwh", "unit_price"]
  csv << ["0","26.4"]
end