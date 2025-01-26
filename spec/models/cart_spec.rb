require 'rails_helper'

describe Cart do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:cart_items).class_name("CartItem").dependent(:destroy) }
    it { should have_many(:products).through(:cart_items).dependent(:destroy) }
  end
end
