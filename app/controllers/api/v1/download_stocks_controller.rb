class Api::V1::DownloadStocksController < ApplicationController
	def show
		@downloaded_dates = DailyQuote.select(:transaction_date).distinct
	end

	def create
		require 'csv'
		date_start = params[:start_on]
		date_end = params[:end_on]
	  (date_start..date_end).each{ |date|
			stocks_list = Twse::StockInfo.new(date)
			if stocks_list.data.blank?
				puts "Today is holyday."
			else
				stocks_list.to_dataframe
				case stocks_list.save_to_db(date)
					when "Save into db."
						puts "Save into db."
					when "Data already exists"
						puts "Data already exists."
					else
						puts "Has error."
				end
			end
			sleep 5
		}
		redirect_to root_path, notice: "Done."
	end
end
