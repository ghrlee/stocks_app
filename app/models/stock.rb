class Stock < ActiveRecord::Base

  # attr_accessor :company, :symbol
 
  validates :company, presence: true
  validates :symbol, presence: true


  # @yahoo_client = YahooFinance::Client.new
 
  # It returns the stocks whose company string contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("symbol like ? or company like ?", "%#{query}%", "%#{query}%")
  end

  # method for returning current value by sending the symbol of current stock to YahooFinance
  def get_value(symbol)
  	yahoo_client = YahooFinance::Client.new
  	data = yahoo_client.quotes([symbol], [:ask])
  	data[0].ask
  end

  def get_data(symbol)
  	yahoo_client = YahooFinance::Client.new
  	data_array = []
    data = yahoo_client.historical_quotes(symbol.to_s, 
    			{ start_date: Time::now-(24*60*60*30), 
    			  end_date: Time::now })
    data.each do |get_data|
    	day_price = get_data.close
    	data_array << day_price.to_f
    end
    p data_array
    data_array
  end

  def graph_data(symbol)
  	# Gchart.line(  
  	# 					:size => '300x200', 
   #            :data => self.get_data(symbol),
   #            :axis_with_labels => ['x','y','r']

              # )
    data_great = self.get_data(symbol)

    great_min = data_great.min - 0.5
    great_max = data_great.max + 0.5
    great_avg = (data_great.inject{|sum,x| sum + x })/30
    great_ary = [great_min.round(2), great_avg.round(2), great_max.round(2)]

    
    Gchart.line(:data => data_great, 
    						:min_value => great_min, 
    						:max_value => great_max,
    						:axis_with_labels => ['y','x'],
                :axis_labels => [great_ary,['30 days ago|Today']])

  end
end
