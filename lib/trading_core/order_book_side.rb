require 'marshal'
require 'models/rate'

module TradingCore
  class OrderBookSide

    private :sort!

    # @param sorter Proc
    def initialize(sorter)
      @rates = []
      @sorter = sorter
    end

    # @return Array<Rate>
    def rates
      Marshal.restore(Marshal.dump(@rates))
    end

    # @return nil|Rate
    def lowest
      return nil if @rates.empty?
      lowest = @rates.first
      @rates.each do |rate|
        lowest = rate if rate.price < lowest.price
      end
      Marshal.restore(Marshal.dump(lowest))
    end

    # @return nil|Rate
    def highest
      return nil if @rates.empty?
      highest = @rates.first
      @rates.each do |rate|
        highest = rate if rate.price > highest.price
      end
      Marshal.restore(Marshal.dump(lowest))
    end

    # @param rate Rate
    def add!(rate)
      @rates.each do |exist|
        if exist.price == rate.price
          exist.increase_volume! rate.volume
        else
          @rates.push rate
          sort!
        end
      end
    end

    # @param rate Rate
    # @return boolean
    def modify!(rate)
      @rates.each do |exist|
        if exist.price == rate.price
          exist.volume rate.volume
          return true
        end
      end
      false
    end

    # @param price float
    # @return boolean
    def remove!(price)
      @rates.each do |rate|
        if rate.price == price
          @rates.delete rate
          return true
        end
      end
      false
    end

    def clear!
      @rates = []
    end

    # Method for calculating simple average price.
    # @param limit integer
    # @return float
    def sap(limit = 30)
      total = 0.0
      count = 1
      @rates.each_with_index do |rate, index|
        break if index >= limit
        total += rate.price
        count += 1
      end
      total / count
    end

    # Method for calculating weighted average price.
    # @param limit float
    # @return float
    def wap(limit = 30)
      total_price = 0.0
      total_volume = 0.0
      @rates.each_with_index do |rate, index|
        break if index >= limit
        total_price += rate.total
        total_volume += rate.volume
      end
      total_price / total_volume
    end

    # Method for sorting.
    def sort!
      @rates.sort_by! { |a, b| @sorter.call a, b }
    end

  end
end