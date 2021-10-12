class Stock < ApplicationRecord
	validates :name, :code, presence: true
  validates :code, uniqueness: true

  has_many :daily_quotes, foreign_key: :code, primary_key: :code, dependent: :destroy
  
  scope :latest_transaction_date, -> (date = nil) do
    date = date ? date.to_date : DailyQuote.latest_transaction_date
    self.joins(:daily_quotes).where(daily_quotes: { transaction_date: date })
  end
end
