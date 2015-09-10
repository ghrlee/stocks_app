class StocksController < ApplicationController

  def index
    if params[:search]
      @stocks = Stock.search(params[:search]).order("created_at DESC")
    else
      @stocks = Stock.order("created_at DESC")
    end
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private
 
  def stocks_params
  	params.require[:stock].permit(:company, :symbol)
  end

  def find_stock
  	@stock = Stock.find(params[:id])
  end
end
