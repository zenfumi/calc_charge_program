require "csv"

CSV.open("usage_charge.csv", "wb") do |csv|
  csv << ["kwh", "unit_price"]
  csv << ["120","19.88"]
  csv << ["300","26.48"]
end