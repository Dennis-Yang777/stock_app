class StockDownloadController < ApplicationController
	def show
	end

	def create
		require 'csv'
		stocks_list = Twse::StockInfo.new(params[:date])
		
		if stocks_list.data.blank?
			redirect_to root_path, notice: "Today is holyday."
		else
			stocks_list.to_dataframe
			case stocks_list.save_to_db(params[:date])
				when "Save into db."
					redirect_to root_path, notice: "Save into db."
				when "Data already exists"
					redirect_to root_path, notice: "Data already exists."
				else
					redirect_to root_path, notice: "Has error."
			end
		end
	end

	def create_with_mutiple_time
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
		}
		redirect_to root_path, notice: "Done."
	end
end
 