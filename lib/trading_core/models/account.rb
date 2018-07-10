require 'active'
require 'order'
require 'trade'
require 'marshal'

module TradingCore
  module Model
    module Account

      attr_reader :key

      # @param key String
      def initialize(key)
        @key = key
        @balance = Balance.new
      end

      # @param active Active
      def add_active(active)
        raise ArgumentError 'Unsupported type' unless active.instance_of? Active
        @balance.add_active active
      end

      # @param order Order
      def add_order(order)
        raise ArgumentError 'Unsupported type' unless order.instance_of? Order
        @balance.add_order order
      end

      # @param trade Trade
      def add_trade(trade)
        raise ArgumentError 'Unsupported type' unless trade.instance_of? Trade
        @balance.add_trade trade
      end

      # @return Balance
      def balance
        Marshal.restore(Marshal.dump(@balance))
      end

    end
  end
end