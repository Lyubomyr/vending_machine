class Product
  attr_reader :title, :amount, :price, :price_in_cents
  def initialize(title:, amount:, price:, price_in_cents:)
    @title, @amount, @price, @price_in_cents = title, amount, price, price_in_cents
  end

  def decrease!
    @amount -= 1 if @amount > 0
    self
  end
end
