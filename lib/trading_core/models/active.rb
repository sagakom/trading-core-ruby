require 'trade'
require 'order'
require 'marshal'

module TradingCore
  module Model
    module Active

      attr_reader :currency, :volume

      private :buy, :sell

      # @param currency Currency
      # @param volume   Float
      def initialize(currency, volume)
        @currency = currency
        @volume = volume
        @trades = []
        @orders = []
      end

      # @param trade Trade
      def add_trade(trade)
        raise ArgumentError 'Unsupported type' unless trade.instance_of? Trade
        raise ArgumentError 'Unsupported trade for this active' unless support_trade? trade
        if trade.buy?
          buy trade
        elsif trade.sell?
          sell trade
        else
          raise RuntimeError 'Trade must be sell or buy type'
        end
        @trades.push trade
      end

      # @param order Order
      def add_order(order)
        raise ArgumentError 'Unsupported type' unless order.instance_of? Order
        raise ArgumentError 'Unsupported active' if order.active != @currency
        @orders.each do |o|
          return false if o == order
        end
        @orders.push order
      end

      # @param order Order
      def remove_order(order)
        @orders.delete(order)
      end

      # @param trade Trade
      def support_trade?(trade)
        raise ArgumentError 'Unsupported type' unless trade.instance_of? Trade
        trade.currency? @currency
      end

      # @param other Active
      def ==(other)
        @currency == other.currency
      end

      # @param trade Trade
      def buy(trade)
        if trade.base_currency? @currency
          increase_volume! trade.volume
          increase_price! trade.total
        else
          decrease_volume! trade.total
        end
      end

      # @param trade Trade
      def sell(trade)
        if trade.base_currency? @currency
          decrease_volume! trade.volume
          decrease_price! trade.total
        else
          increase_volume! trade.volume
        end
      end

      # @return Array<Trade>
      def trades
        Marshal.restore(Marshal.dump(@trades))
      end

      # @return Array<Order>
      def orders
        Marshal.restore(Marshal.dump(@orders))
      end

      # @return Float
      def locked_volume
        volume = 0.0
        @orders.each do |order|
          volume += order.volume if order.ask?
        end
        volume
      end

      # @return Float
      def available_volume
        @volume - locked_volume
      end

      # @return Float
      def total
        value = 0.0
        @trades.each do |trade|
          value = yield(value, trade)
        end
        value
      end

      # @return Float
      def total_volume
        total do |value, trade|
          if trade.buy?
            value += trade.volume
          else
            value -= trade.volume
          end
          value
        end
      end

      # @return Float
      def total_price
        total do |value, trade|
          if trade.buy?
            value += trade.price
          else
            value -= trade.price
          end
          value
        end
      end

      # @return Float
      def weighted_avg_price
        total_price / total_volume
      end

      # @return Float
      def total_buy
        total do |value, trade|
          value += trade.total if trade.buy?
          value
        end
      end

      # @return Float
      def total_sell
        total do |value, trade|
          value += trade.total if trade.sell?
          value
        end
      end

      # @return Hash
      def totals
        [buy: total_buy, sell: total_sell, volume: total_volume, price: total_price]
      end

    end
  end
end