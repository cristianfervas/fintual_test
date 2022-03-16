require 'time'
require 'date'

class Stock 
  def initialize(id)
    @id = id
  end
  def price(date)
    date_to_timestamp = date.to_time.to_i + (@id * 100)
    timestamp_to_price = (date_to_timestamp % (10000000.0)).round(2)
  end
end

class Portfolio
  def initialize(stocks)
    @stocks = stocks
  end

  def profit(start_date, end_date)
    start_value = 0
    end_value = 0
    @stocks.each do |stock| 
      start_value += stock.price(start_date) 
    end
    @stocks.each do |stock| 
      end_value += stock.price(end_date) 
    end
    (end_value - start_value) / abs(start_value)
  end

  def annualized_return(start_date, end_date)
    days_between_dates = (end_date - start_date).round
    initial_value = 0
    final_value = 0
    @stocks.each do |stock| 
      initial_value += stock.price(start_date)
    end
    @stocks.each do |stock| 
      final_value += stock.price(end_date) 
    end
    annualized_return = (((final_value / initial_value) ** (365.0/days_between_dates)) - 1)
    return (annualized_return * 100).to_s + "%"
  end
end


portfolio = Portfolio.new([Stock.new(1), Stock.new(2)])
from_date = DateTime.parse("01/01/2020")
to_date = DateTime.parse("31/12/2020")
puts portfolio.annualized_return(from_date, to_date)