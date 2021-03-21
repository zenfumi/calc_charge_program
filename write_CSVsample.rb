require "csv"

CSV.open("usage_charge.csv", "wb") do |csv|
  csv << ["kwh", "unit_price"]
  csv << ["140","23.67"]
  csv << ["350","23.88"]
  csv << ["351","26.41"]
end