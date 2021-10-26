module Twse
	class StockInfo
		attr_accessor :data, :dataframe

		def initialize(date)
			require "down"

			date_string = date.delete("-")
			file_path = Down.download("http://www.twse.com.tw/exchangeReport/MI_INDEX?response=csv&date=#{date_string}&type=ALLBUT0999").path
			@data = File.open(file_path, "r:BIG5").read
			@dataframe = ''
		end

		def to_dataframe
			rows = @data.gsub("=", '').split(' ')
			@data = rows.map{ |row| 
				row if row.split('",').length == 16 
			}.compact.join("\n")
		end

		def save_to_db(date)
			if !DailyQuote.exists?(transaction_date: date)
				require 'csv'

				@dataframe = Daru::DataFrame.new(CSV.parse(@data))
				@dataframe.delete_vectors(0)

				ActiveRecord::Base.transaction do
					stocks = []
					daily_quotes = []
					@dataframe.map_vectors do |row|
						stocks << Stock.new(code: row[0], name: row[1]) if !Stock.exists?(code: row[0])
						daily_quotes << DailyQuote.new(
							code: row[0],
							transaction_date: date,
							trade_volume: row[2],
							number_of_transactions: row[3],
							trade_price: row[4],
							opening_price: row[5],
							highest_price: row[6],
							lowest_price: row[7],
							closing_price: row[8],
							ups_and_downs: row[9],
							price_difference: row[10],
							last_best_bid_price: row[11],
							last_best_bid_volume: row[12],
							last_best_ask_price: row[13],
							last_best_ask_volume: row[14],
							price_earning_ratio: row[15]
						)
					end
					Stock.import(stocks)
					DailyQuote.import(daily_quotes)
				end
				"Data were saved into db"
			else
				"Data already exists"
			end
		end	
	end
end