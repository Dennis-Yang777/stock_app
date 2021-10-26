class Api::V1::DownloadStocksController < ApplicationController
	def show
		@downloaded_dates = DailyQuote.select(:transaction_date).distinct
	end

	def create
		require 'csv'
		notice_arr = []
		date_start = params[:start_on]
		date_end = params[:end_on]

	  (date_start..date_end).each{ |date|
			stocks_list = Twse::StockInfo.new(date)
			if stocks_list.data.blank?
				notice_arr << "#{date} 是假日"
			else
				stocks_list.to_dataframe
				case stocks_list.save_to_db(date)
					when "Data were saved into db"
						notice_arr << "#{date} 資料已存入資料庫"
					when "Data already exists"
						notice_arr << "#{date} 資料已經存在"
					else
						notice_arr << "發生錯誤，請稍等五分鐘後再試"
				end
			end
			sleep 3
		}
		redirect_to root_path, notice: notice_arr
	end
end
