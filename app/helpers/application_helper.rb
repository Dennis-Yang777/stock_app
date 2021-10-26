module ApplicationHelper
	include Pagy::Frontend
	def price_max(stock)
		(stock.daily_quotes.average(:closing_price) * 1.3).round
	end

	def price_min(stock)
		(stock.daily_quotes.average(:closing_price) * 0.7).round
	end
end
