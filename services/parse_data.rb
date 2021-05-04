require_relative '../models/product.rb'
require_relative '../models/coin.rb'

module ParseData
  COINS_PATH = File.join(File.dirname(__FILE__), '../data/coins.json').freeze
  PRODUCTS_PATH = File.join(File.dirname(__FILE__), '../data/products.json').freeze

  def parse_coins
    coins_path = File.open COINS_PATH
    coins_json = JSON.parse(File.read(coins_path), symbolize_names: true).freeze
    coins_path.close
    coins_json

    coins_json.map{|coin_json| Coin.new(coin_json)}
  end

  def parse_products
    products_path = File.open PRODUCTS_PATH
    products_json = JSON.parse(File.read(products_path), symbolize_names: true)
    products_path.close

    products_json.map{|product_json| Product.new(product_json)}
  end
end
