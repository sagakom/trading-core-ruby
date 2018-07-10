require 'rate'

module TradingPair
  module Model
    module CurrencyPair

      attr_reader :base, :quote

      # @param base  Currency
      # @param quote Currency
      def initialize(base, quote)
        @base = base
        @quote = quote
      end

      # @param currency Currency
      def base?(currency)
        @base == currency
      end

      # @param currency Currency
      def quote?(currency)
        @quote == currency
      end

      # @return String
      def base_symbol
        @base.symbol
      end

      # @return String
      def quote_symbol
        @quote.symbol
      end

      # @return String
      def symbol
        @quote.symbol + @base.symbol
      end

      # @param symbol String
      def symbol?(symbol)
        self.symbol == symbol
      end

      # @param symbol String
      def currency_symbol?(symbol)
        @base.symbol == symbol || @quote.symbol == symbol
      end

      def valid?
        @base.instance_of?('Currency') && @quote.instance_of?('Currency')
      end

      # @return Array<String>
      def symbols
        [@base.symbol, @quote.symbol]
      end

      # @return Array<Currency>
      def currencies
        [@base, @quote]
      end

      # @param currency Currency
      def currency?(currency)
        @base == currency || @quote == currency
      end

      # @param other CurrencyPair
      def ==(other)
        raise ArgumentError 'Unsupported type' unless other.instance_of? Rate
        @base == other.base && @quote == other.quote
      end

    end
  end
end
