class StockDownloadsController < ApplicationController
	def index

	end

	def create
		require 'csv'

		stocks_list = Twse::StockInfo.new(params[:date])
		stocks_list.to_dataframe
		dataframe = Daru::DataFrame.new(CSV.parse(stocks_list.data))
		dataframe.delete_vectors(0)
		
		dataframe.map_vectors{ |row| 
			stock = Stock.new(
				code: row[0],
				name: row[1]
			)
			stock.save
			daily_quotes = stock.daily_quotes.new(
				transaction_date: params[:date],
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
			daily_quotes.save
		}

		render html: 'success'
	end
end
 