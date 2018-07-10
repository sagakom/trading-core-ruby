require 'order_book_side'
require 'models/currency_pair'
require 'models/rate'
require 'models/order'

module TradingCore
  class OrderBook

    private :determine_side

    # @param currency_pair CurrencyPair
    # @param ask_sorter    Proc
    # @param bid_sorter    Proc
    def initialize(currency_pair, ask_sorter, bid_sorter)
      @currency_pair = currency_pair
      @asks = OrderBookSide.new(ask_sorter)
      @bids = OrderBookSide.new(bid_sorter)
    end

    # Method for adding rate into side.
    # @param side          Symbol
    # @param currency_pair CurrencyPair
    # @param rate          Rate
    def add!(side, currency_pair, rate)
      raise ArgumentError 'Unsupported currency pair.' unless @currency_pair == currency_pair
      determine_side(side).add!(rate)
    end

    # Method for modify rate in side.
    # @param side          Symbol
    # @param currency_pair CurrencyPair
    # @param rate          Rate
    def modify!(side, currency_pair, rate)
      raise ArgumentError 'Unsupported currency pair.' unless @currency_pair == currency_pair
      determine_side(side).modify!(rate)
    end

    # Method for removing rate from side.
    # @param side          Symbol
    # @param currency_pair CurrencyPair
    # @param price         float
    def remove!(side, currency_pair, price)
      raise ArgumentError 'Unsupported currency pair' unless @currency_pair == currency_pair
      determine_side(side).remove!(price)
    end

    # Method for clearing sides.
    def clear!
      @asks = []
      @bids = []
    end

    # @return Rate
    def highest_bid
      @bids.highest
    end

    # @return Rate
    def lowest_bid
      @bids.lowest
    end

    # @return Rate
    def highest_ask
      @asks.highest
    end

    # @return Rate
    def lowest_ask
      @asks.lowest
    end

    # @return Array<Rate>
    def bids
      @bids.rates
    end

    # @return Array<Rate>
    def asks
      @asks.rates
    end

    # Method for determine order book side.
    # @param side Symbol
    def determine_side(side)
      if side == Order::SIDE_ASK
        return @asks
      elsif side == Order::SIDE_BID
        return @bids
      end
      raise ArgumentError 'Unexpected side'
    end

  end
end
