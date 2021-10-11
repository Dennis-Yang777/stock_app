class StockDownloadsController < ApplicationController
	def index

	end

	def create
		require 'csv'

		stocks = Twse::StockInfo.new(params[:date])
		stocks.to_dataframe

		# df = Daru::DataFrame.new()
		render html: stocks.data
	end
end
 