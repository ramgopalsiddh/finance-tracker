require 'httparty'
 
class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    response = HTTParty.get("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{ticker_symbol}&apikey=#{Rails.application.credentials.alphavantage[:api_key]}")
    if response.code == 200 && response.parsed_response['Global Quote']
      last_price = response.parsed_response['Global Quote']['05. price']
      company_name = response.parsed_response['Global Quote']['01. symbol']
      new(ticker: ticker_symbol, name: company_name, last_price: last_price)
    else
      nil
    end
  end
end