class StocksController < ApplicationController
	def index
		@pagy, @stock_lists = pagy(Stock.all, items: 50)
	end
end
 