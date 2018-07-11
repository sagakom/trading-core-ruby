module TradingCore
  module Calculator

    # Method for calculating last number of arithmetic progression.
    # @param a1 Float   First member of arithmetic progression.
    # @param n  Integer Position of calculating number.
    # @param d  Float   The difference of a given arithmetic progression.
    # @return   Float
    def self.ap(a1, n, d)
      a1 + d * (n - 1)
    end

    # Method for calculating sum of arithmetic progression.
    # @param a1 Float   First member of arithmetic progression.
    # @param n  Integer Position of calculating number.
    # @param d  Float   The difference of a given arithmetic progression.
    # @return   Float
    def self.sap(a1, n, d)
      (a1 + ap(a1, n, d)) * n / 2
    end

    # Method for calculating last number of geometric progression.
    # @param a1 Float   First member of geometric progression.
    # @param n  Integer Position of calculating number.
    # @param q  Float   The denominator of progression.
    # @return   Float
    def self.gp(a1, n, q)
      a1 * q**(n - 1)
    end

    # Method for calculating increasing sum of geometric progression.
    # @param a1 Float   First member of geometric progression.
    # @param n  Integer Position of calculating number.
    # @param q  Float   The denominator of progression.
    # @return   Float
    def self.isgp(a1, n, q)
      return n * a1 if q == 1
      (gp(a1, n, q) * q - a1) / (q - 1)
    end

    # Method for calculating decreasing sum of geometric progression.
    # @param a1 Float   First member of geometric progression.
    # @param n  Integer Position of calculating number.
    # @param q  Float   The denominator of progression.
    # @return   Float
    def self.dsgp(a1, n, q)
      return n * a1 if q == 1
      (a1 - gp(a1, n, q) * q) / (1 - q)
    end

    # Method for calculating compound interest with principal investment amount.
    # @param p  Float    The principal investment amount.
    # @param r  Float    The annual interest rate.
    # @param n  Integer  The number of times that interest is compounded per year.
    # @param t  Integer  The number of years the money is invested or borrowed for.
    # @return  Float
    def self.cip(p, r, n, t)
      p * (1 + r / n)**(n * t)
    end

    # Method for calculating compound interest without principal investment amount.
    # @param p  Float    The principal investment amount.
    # @param r  Float    The annual interest rate.
    # @param n  Integer  The number of times that interest is compounded per year.
    # @param t  Integer  The number of years the money is invested or borrowed for.
    # @return  Float
    def self.ci(p, r, n, t)
      cip(p, r, n, t) - p
    end

    # Method for generating arithmetic sequence of numbers.
    # @param a Float
    # @param n Integer
    # @param d Float
    # @return  Array<Float>
    def self.ans(a, n, d)
      seq = []
      (1..n).each { |i| seq.push(yield(a, i, d)) }
      seq
    end

    # Method for generating compound interests with principal sequence of number.
    # @param p  Float   The principal investment amount.
    # @param r  Float   The annual interest rate.
    # @param n  Integer The number of times that interest is compounded per year.
    # @param t  Integer The number of years the money is invested or borrowed for.
    # @param nd Integer The number of digits after dot in result.
    # @param s  Integer The start member.
    # @return  Array<Float>
    def self.cins(p, r, n, t, nd = 2, s = 1)
      seq = []
      (s..t).each { |i| seq.push(yield(p, r, n, i).ceil(nd)) }
      seq
    end
  end
end
