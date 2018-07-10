module TradingCore
  module Model
    module Tick

      attr_reader :currency_pair, :last, :low_ask, :high_bid, :base_volume, :quote_volume, :change

      # @param currency_pair CurrencyPair
      # @param last          Float
      # @param low_ask       Float
      # @param high_bid      Float
      # @param base_volume   Float
      # @param quote_volume  Float
      # @param change        Float
      def initialize(currency_pair, last, low_ask, high_bid, base_volume, quote_volume, change)
        @currency_pair = currency_pair
        @last = last
        @low_ask = low_ask
        @high_bid = high_bid
        @base_volume = base_volume
        @quote_volume = quote_volume
        @change = change
      end

    end
  end
end