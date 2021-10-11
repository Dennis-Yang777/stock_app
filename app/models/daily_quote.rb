class DailyQuote < ApplicationRecord
	acts_as_paranoid

  validates :code, :transaction_date, presence: true
  validates :code, uniqueness: { scope: :transaction_date,
    message: "該收盤日期已有紀錄" }

  belongs_to :stock, foreign_key: :code, primary_key: :code

  scope :latest_transaction_date, -> { maximum(:transaction_date) }
end
