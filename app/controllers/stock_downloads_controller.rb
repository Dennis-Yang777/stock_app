class StockDownloadsController < ApplicationController
	def index

	end

	def create
		require 'time'
		time = Time.parse(params[:date])
		if time.saturday? || time.sunday?
			redirect_to root_path, notice: "Today is holyday"
		else
			require 'csv'

			stocks_list = Twse::StockInfo.new(params[:date])
			stocks_list.to_dataframe
			case stocks_list.save_to_db(params[:date])
				when "Save into db."
					redirect_to root_path, notice: "Save into db"
				when "Data already exists"
					redirect_to root_path, notice: "Data already exists"
				else
					redirect_to root_path, notice: "Has error"
			end
		end
	end
end
 