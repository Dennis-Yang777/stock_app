class CreateDailyQuotes < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_quotes do |t|
      t.string  :code, null: false
      t.date    :transaction_date, null: false 
      t.bigint  :trade_volume                  
      t.bigint  :number_of_transactions        
      t.bigint  :trade_price                   
      t.float   :opening_price                 
      t.float   :highest_price                 
      t.float   :lowest_price                  
      t.float   :closing_price                 
      t.string  :ups_and_downs                 
      t.float   :price_difference              
      t.float   :last_best_bid_price           
      t.bigint  :last_best_bid_volume          
      t.float   :last_best_ask_price           
      t.bigint  :last_best_ask_volume          
      t.float   :price_earning_ratio           

      t.timestamps
    end

    add_index :daily_quotes, %i[code transaction_date], unique: true
  end
end
