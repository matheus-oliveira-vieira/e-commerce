require 'rails_helper'

describe CartItem do
  context 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end
end
