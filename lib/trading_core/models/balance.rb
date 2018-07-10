require 'order'
require 'active'
require 'marshal'

module TradingCore
  module Model
    module Balance

      attr_reader :loaded

      def initialize
        @actives = []
        @loaded = false
      end

      # @return Array
      def actives
        Marshal.load(Marshal.dump(@actives));
      end

      # @param active Active
      # @return TrueClass|FalseClass
      def add_active(active)
        raise ArgumentError 'Unsupported type' unless active.instance_of? Active
        return false if loaded?
        @actives.each { |a| return false if a == active }
        @actives.push active
        return true
      end

      # @param order Order
      def add_order(order)
        raise ArgumentError 'Unsupported type' unless order.instance_of? Order
        @actives.each do |active|
          if active == order.active
            @active.add_order order
            return true
          end
        end
        return false
      end

      # @param trade Trade
      def add_trade(trade)
        result = false
        for i in [0, 1]
          break unless @actives.at i
          active = @actives[i]
          if trade.currency? active.currency
            active.add_trade trade
            result = true
          end
        end
        result
      end

      # @param order Order
      def remove_order(order)
        raise ArgumentError 'Unsupported type' unless order.instance_of? Order
        @actives.each do |active|
          if active == order.active
            active.remove_order order
            return true
          end
        end
        return false
      end

      def loaded?
        return @loaded
      end

      def clear
        @actives = []
      end

    end
  end
end