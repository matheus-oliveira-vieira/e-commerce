require 'rails_helper'

describe Product do
  context 'associations' do
    it { should have_many(:cart_items) }
    it { should have_many(:carts).through(:cart_items) }
  end

  context 'validations' do
    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:price).with_message('não pode ficar em branco') }
  end

  context 'product_picture' do
    it 'is attached' do
      product = create(:product)
      product.product_picture.attach(
        io: File.open(Rails.root.join("app", "assets", "images", "product.jpeg")),
        filename: 'product.jpeg',
        content_type: "image/jpeg"
      )
      expect(product.product_picture).to be_attached
    end
  end
end
