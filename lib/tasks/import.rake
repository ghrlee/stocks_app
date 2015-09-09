require 'csv'

desc "Import stocks from csv file"
task :import => [:environment] do

  file = "db/companylist.csv"

  CSV.foreach(file, :headers => true) do |row|
    Team.create {
      :company => row[2],
      :symbol => row[1]
    }
  end

end