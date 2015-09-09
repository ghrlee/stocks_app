class StocksController < ApplicationController

  def index
  end

  def show
  end

  private
 
  def stocks_params
  	params.require[:stock].permit(:company, :symbol)
  end

  def find_stock
  	@stock = Stock.find(params[:id])
  end
end
