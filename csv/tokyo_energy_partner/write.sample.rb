require "csv"

CSV.open("basic_charge.csv", "wb") do |csv|
  csv << ["amp", "basic_charge"]
  csv << ["10","286"]
  csv << ["15","429"]
  csv << ["20","572"]
  csv << ["30","858"]
  csv << ["40","1144"]
  csv << ["50","1430"]
  csv << ["60","1716"]
  csv << ["10","286"]
  csv << ["10","286"]
end