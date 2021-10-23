class StockDownloadsController < ApplicationController
	def index
	end

	def create
		require 'csv'

		stocks_list = Twse::StockInfo.new(params[:date])
		if stocks_list.data.blank?
			require 'time'
			time = Time.parse(params[:date])
			if time > Time.now
				redirect_to root_path, notice: "Your selected date is over today."
			else
				redirect_to root_path, notice: "Today is holyday."
			end
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
		render html: params
	end
end
 