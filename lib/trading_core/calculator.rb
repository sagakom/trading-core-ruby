module TradingCore
  module Calculator

    # Method for calculating Increasing Arithmetic Progression.
    # @param a Float
    # @param n Integer
    # @param d Float
    # @return  Float
    def ap(a, n, d)
      a + d * (n - 1)
    end

    # Method for calculating Geometric Progression.
    # @param a Float
    # @param n Integer
    # @param d Float
    # @return  Float
    def gp(a, n, d)
      a * (d**(n - 1))
    end

    # Method for calculating Compound Interest.
    # @param a Float
    # @param n Integer
    # @param p Float
    # @return  Float
    def ci(a, n, p)
      a * ((1 + p / 100)**n)
    end

    # Method for generating Arithmetic Sequence of Number.
    # @param a Float
    # @param n Integer
    # @param d Float
    # @return  Array<Float>
    def ans(a, n, d)
      seq = []
      (1..n).each { |i| seq.push(yield(a, i, d)) }
      seq
    end

    # Method for generating Compound Interests Sequence of Number.
    # @param a Float
    # @param n Integer
    # @param p Float
    # @return  Array<Float>
    def cins(a, n, p)
      seq = []
      (0..n).each { |i| seq.push(ci(a, i, p)) }
      seq
    end

  end
end
