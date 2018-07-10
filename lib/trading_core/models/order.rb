require 'rate'

module TradingCore
  module Model
    module Order

      include Rate

      attr_reader :origin_id, :side, :active, :quote, :status, :created_at

      SIDE_ASK = :ask
      SIDE_BID = :bid

      # @param origin_id  Integer
      # @param side       Symbol
      # @param active     Active
      # @param quote      Float
      # @param price      Float
      # @param volume     Float
      # @param status     String
      # @param created_at Time
      def initialize(origin_id, side, active, quote, price, volume, status, created_at)
        @origin_id = origin_id
        @side = side
        @active = active
        @quote = quote
        @price = price
        @volume = volume
        @status = status
        @created_at = created_at
      end

      # @return Array
      def supported_sides
        [SIDE_ASK, SIDE_BID]
      end

      # @param side Symbol
      def support_side?(side)
        supported_sides.index(side)
      end

      def ask?
        @side == SIDE_ASK
      end

      def bid?
        @side == SIDE_BID
      end

      # @param other Order
      def ==(other)
        @origin_id == other.origin_id
      end

    end
  end
end