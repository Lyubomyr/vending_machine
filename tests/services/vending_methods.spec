require_relative '../../services/parse_data.rb'
require_relative '../../services/vending_methods.rb'
require_relative '../../models/change.rb'
include ParseData

RSpec.describe VendingMethods do
  subject { Class.new { extend VendingMethods } }
  let(:products) { parse_products }
  let(:product) { products[0] }

  context '.choose_product' do
    let(:product_index) { subject.choose_product(products) }

    before do
      allow(subject).to receive(:read_input).and_return(1)
    end

    it "returns proper index of the product" do
      expect(product_index).to eq(0)
    end
  end

  context '.put_coins' do
    let(:cents) { subject.put_coins(product) }

    before do
      allow(subject).to receive(:read_input).and_return(3)
    end

    it "returns proper amount of change after enough deposit was made" do
      expect(cents).to eq(200)
    end
  end

  context '.calculate_change' do
    let(:change) { subject.calculate_change(110) }

    it "returns proper Change object" do
      expect(change).to be_instance_of(Change)
    end

    it "returns proper amount of change" do
      expect(change.coins[0].title).to eq('1$')
    end

    it "there are no errors" do
      expect(change.errors.length).to eq(0)
    end
  end

  context '.decrease_product' do
    it "returns new array of products with decreased amount" do
      expect { subject.decrease_product(products, 0) }.to change {products[0].amount}.from(1).to(0)
    end
  end
end
