require 'csv'

desc "Import stocks from csv file"
task :import => [:environment] do

  file = "db/companylist.csv"

  CSV.foreach(file, :headers => true) do |row|
    Stock.create(company: row[1], symbol: row[0])
  end

end