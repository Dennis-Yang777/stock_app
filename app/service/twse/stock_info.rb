module Twse
	class StockInfo
		attr_accessor :data

		def initialize(date)
			require "down"

			date_string = date.delete("-")
			file_path = Down.download("http://www.twse.com.tw/exchangeReport/MI_INDEX?response=csv&date=#{date_string}&type=ALLBUT0999").path
			@data = File.open(file_path, "r:BIG5").read
		end

		def to_dataframe
			rows = @data.gsub("=", '').split(' ')
			@data = rows.map{ |row| 
				row if row.split('",').length == 16 
			}.compact.join("\n")
		end
	end
end