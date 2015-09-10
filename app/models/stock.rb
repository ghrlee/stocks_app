class Stock < ActiveRecord::Base

  # attr_accessor :company, :symbol
 
  validates :company, presence: true
  validates :symbol, presence: true
 
  # It returns the stocks whose company string contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("company like ?", "%#{query}%") 
  end
  
end
