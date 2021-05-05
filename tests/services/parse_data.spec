require_relative '../../services/parse_data.rb'
require_relative '../../models/coin.rb'
require_relative '../../models/product.rb'
include ParseData

RSpec.describe ParseData do
  context '.parse_coins' do
    let(:coins) { parse_coins }

    it "returns array of proper length" do
      expect(coins).to be_instance_of(Array)
      expect(coins.length).to eq(6)
    end

    it "returns array of objects with proper fields and values" do
      coin = coins[0]
      expect(coin).to be_instance_of(Coin)
      expect(coin.cents).to eq(25)
      expect(coin.amount).to eq(30)
    end
  end

  context '.parse_products' do
    let(:products) { parse_products }

    it "returns array of proper length" do
      expect(products).to be_instance_of(Array)
      expect(products.length).to eq(3)
    end

    it "returns array of objects with proper fields and values" do
      product = products[0]
      expect(product).to be_instance_of(Product)
      expect(product.title).to eq('Coca-Cola')
      expect(product.price).to eq('1.30$')
      expect(product.price_in_cents).to eq(130)
      expect(product.amount).to eq(1)
    end
  end
end
