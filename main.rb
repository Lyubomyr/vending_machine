#!/usr/bin/env ruby

require_relative './services/parse_data.rb'
require_relative './services/vending_methods.rb'
require_relative './services/print_messages.rb'

include ParseData
include VendingMethods
include PrintMessages

products = parse_products

while true
  print_message(:greeting)
  exit if gets.to_i != 1

  product_index = choose_product(products)
  product = products[product_index]

  deposit_cents = put_coins(product)
  products = decrease_product(products, product_index)

  change_amount = deposit_cents - product.price_in_cents
  change = calculate_change(change_amount)

  print_result(product, change)
end
