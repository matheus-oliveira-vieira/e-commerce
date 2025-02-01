require 'rails_helper'

describe Cart do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:cart_items).class_name("CartItem").dependent(:destroy) }
  end
end
