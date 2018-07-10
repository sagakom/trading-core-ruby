module TradingCore
  module Model
    module Rate

      attr_reader :price, :volume

      # @param price  Float
      # @param volume Float
      def initialize(price, volume)
        @price = price
        @volume = volume
      end

      # @return Float
      def total
        @price * @volume
      end

      # @param other Rate
      def ==(other)
        return total == other.total if other.instance_of? Rate
        raise ArgumentError, 'Unsupported argument'
      end

      # @param value Float
      def increase_price!(value)
        @price += value
      end

      # @param value Float
      def decrease_price!(value)
        @price -= value
      end

      # @param value Float
      def increase_volume!(value)
        @volume += value
      end

      # @param value Float
      def decrease_volume!(value)
        @volume -= value
      end

    end
  end
end