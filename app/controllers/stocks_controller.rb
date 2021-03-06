class StocksController < ApplicationController
	def index
		@pagy, @stock_lists = pagy(Stock.where("length(code) LIKE 4").order(:code), items: 40)
	end

	def show
		@stock = Stock.includes(:daily_quotes).find(params[:id])	
	end

	def search
		@pagy, @stock_lists = pagy(
			Stock.where("code LIKE ? OR name LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(:code), items: 40
		)
		render :index
	end
end
 