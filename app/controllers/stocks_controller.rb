class StocksController < ApplicationController

  def index
  	@stocks = Stock.all
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
