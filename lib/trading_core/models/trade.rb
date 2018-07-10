require 'rate'

module TradingCore
  module Model
    module Trade

      include Rate

      attr_reader :origin_id, :currency_pair, :type, :created_at

      TYPE_SELL = :sell
      TYPE_BUY = :buy

      # @param origin_id     Integer
      # @param currency_pair CurrencyPair
      # @param type          Symbol
      # @param price         Float
      # @param volume        Float
      # @param created_at    Time
      def initialize(origin_id, currency_pair, type, price, volume, created_at)
        @origin_id = origin_id
        @currency_pair = currency_pair
        @type = type
        @price = price
        @volume = volume
        @created_at = created_at
      end

      # @return String
      def base_symbol
        @currency_pair.base_symbol
      end

      # @return String
      def quote_sumbol
        @currency_pair.quote_symbol
      end

      # @param other Trade
      def ==(other)
        return @origin_id == other.origin_id if other.instance_of? Trade
        raise AttributeError 'Unsupported type'
      end

      # @param symbol String
      def symbol?(symbol)
        @currency_pair.symbol? symbol
      end

      # @param type Symbol
      def type?(type)
        @type == type
      end

      def buy?
        @type == TYPE_BUY
      end

      def sell?
        @type == TYPE_SELL
      end

      # @return Array
      def supported_types
        [TYPE_SELL, TYPE_BUY]
      end

      # @param type Symbol
      def support_type?(type)
        supported_types.index(type)
      end

      # @param currency Currency
      def base_currency?(currency)
        @currency_pair.base? currency
      end

      # @param currency Currency
      def quote_currency?(currency)
        @currency_pair.quote? currency
      end

      # @param currency Currency
      def currency?(currency)
        @currency_pair.currency? currency
      end

    end
  end
end