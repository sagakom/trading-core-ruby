module TradingCore
  module Model
    module Currency

      attr_reader :origin_id, :symbol, :name

      # @param origin_id Integer
      # @param symbol    String
      # @param name      String
      def initialize(origin_id, symbol, name)
        @origin_id = origin_id
        @symbol = symbol
        @name = name
      end

      # @param other Currency
      def ==(other)
        @symbol == other.symbol
      end

    end
  end
end
