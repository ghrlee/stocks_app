class Stock < ActiveRecord::Base

  # attr_accessor :company, :symbol
 
  validates :company, presence: true
  validates :symbol, presence: true


  # @yahoo_client = YahooFinance::Client.new
 
  # It returns the stocks whose company string contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("company like ?", "%#{query}%") 
  end

  # method for returning current value by sending the symbol of current stock to YahooFinance
  def get_value(symbol)
  	yahoo_client = YahooFinance::Client.new
  	data = yahoo_client.quotes([symbol], [:ask])
  	data[0].ask
  end

  def get_data
  	yahoo_client = YahooFinance::Client.new
  	data_array = []
    data = yahoo_client.historical_quotes("FLWS", { start_date: Time::now-(24*60*60*30), end_date: Time::now }) # 10 days worth of data
    data.each do |get_data|
    	day_price = get_data.close
    	data_array << day_price.to_f
    end
    data_array
  end

  def graph_data
  	Gchart.line(  
  						:size => '300x200', 
              :data => self.get_data,
              :axis_range => [nil, [50,125,5]],
              )
  end
end
