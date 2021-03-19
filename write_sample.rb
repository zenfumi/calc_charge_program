require "csv"

CSV.open("basic_charges.csv", "wb") do |csv|
  csv << ["amp", "basic_charge"]
  csv << ["10","858"]
  csv << ["15","858"]
  csv << ["20","858"]
  csv << ["30","858"]
  csv << ["40","1144"]
  csv << ["50","1430"]
  csv << ["60","1716"]
end