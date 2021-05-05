require_relative './parse_data.rb'
require_relative './print_messages.rb'
require_relative '../models/coin.rb'
require_relative '../models/change.rb'
include ParseData
include PrintMessages

module VendingMethods
  COINS = parse_coins.freeze

  def choose_product(products)
    product = nil
    product_i = 0

    until product
      print_message :choose_product

      products.each_with_index do |product, i|
        params = {i: i+1, title: product.title, price: product.price, amount: product.amount}
        print_message :product_info, params: params
      end

      product_i = read_input.to_i
      product = products[product_i-1] if product_i > 0
      product = nil if product && product.amount == 0

      puts print_error :product_not_available unless product
    end

    product_i-1
  end

  def put_coins(product)
    coins = COINS.map.with_index {|coin, i| "#{i+1} - #{coin.title}"}.join(', ')
    print_message :put_coins, params: {product_title: product.title, coins: coins}

    deposit_cents = 0
    while deposit_cents < product.price_in_cents do
      print_message :more_coins, params: {amount: product.price_in_cents - deposit_cents}

      coin_i = read_input.to_i
      deposit_cents += COINS[coin_i-1].cents if coin_i.between?(1, COINS.count)
    end
    deposit_cents
  end

  def calculate_change(change_cents)
    errors = []
    coin_cents = COINS.map{|coin| coin.cents <= change_cents ? coin.cents : nil}.compact.reverse

    coins = coin_cents.map do |coin|
      coin_change_times = change_cents / coin
      change_cents = change_cents % coin

      coin = COINS.find{|coin_obj| coin_obj.cents == coin}
      coin.decrease!(coin_change_times)
      errors = errors && coin.errors

      coin_change_times > 0 && coin.errors.empty? ? Coin.new({title: coin.title, times: coin_change_times}) : nil
    end.compact

    errors << :too_small_change if change_cents > 0 && coins.empty?

    Change.new({coins: coins, errors: errors})
  end

  def decrease_product(products, product_i)
    products.map.with_index {|product, i| i == product_i ? product.decrease! : product}
  end

private

  def read_input
    STDIN.gets
  end
end
