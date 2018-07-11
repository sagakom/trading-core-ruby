require 'rspec'
require 'trading_core/calculator'

RSpec.describe TradingCore::Calculator do

  it 'should calculate last member of arithmetic progression' do
    expect(TradingCore::Calculator.ap(7,8,2)).to eq 21
  end

  it 'should calculate sum of arithmetic progression' do
    expect(TradingCore::Calculator.sap(7,8,2)).to eq 112
  end

  it 'should calculate last member of geometric progression' do
    expect(TradingCore::Calculator.gp(1, 8, 2)).to eq 128
  end

  it 'should calculate increasing sum of geometric progression' do
    expect(TradingCore::Calculator.isgp(1, 8, 2)).to eq 255
  end

  it 'should calculate decreasing sum of geometric progression' do
    expect(TradingCore::Calculator.dsgp(255, 8, 0.2).ceil(2)).to eq 318.75
  end

  it 'should calculate compound interest include principal sum' do
    expect(TradingCore::Calculator.cip(1000, 0.12, 12, 5).ceil(2)).to eq 1816.7
  end

  it 'should calculate compound interest' do
    expect(TradingCore::Calculator.ci(1000, 0.12, 12, 5).ceil(2)).to eq 816.7
  end

  it 'should calculate sequence numbers of compound interests include principal' do
    expected = [1126.83, 1269.74, 1430.77, 1612.23, 1816.7]
    seq = TradingCore::Calculator.cins(1000, 0.12, 12, 5) { |p ,r, n, t| TradingCore::Calculator.cip(p, r, n, t) }
    expect(seq).to eq expected
  end

  it 'should calculate  sequence numbers compound interests' do
    expected = [126.83, 269.74, 430.77, 612.23, 816.7]
    seq = TradingCore::Calculator.cins(1000, 0.12, 12, 5) { |p, r, n, t| TradingCore::Calculator.ci(p, r, n, t) }
    expect(seq).to eq expected
  end

end