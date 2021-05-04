class Coin
  attr_reader :title, :amount, :cents, :times, :errors

  def initialize(title:, amount: 0, cents: 0, times: 0)
    @title, @amount, @cents, @times = title, amount, cents, times
    @errors = []
  end

  def decrease!(amount = 1)
    if @amount >= amount
      @amount -= amount
    else
      @amount = 0
      @errors = [:insufficient_coins]
    end
    self
  end
end
