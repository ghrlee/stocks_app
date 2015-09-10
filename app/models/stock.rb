class Stock < ActiveRecord::Base

  # attr_accessor :company, :symbol
 
  validates :company, presence: true
  validates :symbol, presence: true
 
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
end
