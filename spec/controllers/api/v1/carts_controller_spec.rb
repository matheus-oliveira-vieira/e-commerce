require 'rails_helper'

describe Api::V1::CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product) }

  before { sign_in user }

  describe 'POST #create' do
    context 'sucessfully' do
      before do
        allow(user).to receive(:cart).and_return(nil)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'create a new cart and return success message' do
        post :create

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Successfully')
      end
    end

    context 'when user already have a cart' do
      before do
        allow(user).to receive(:cart).and_return(cart)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'return status forbidden' do
        post :create

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  # describe 'GET #show' do
  # end

  # describe "POST #add_to_cart" do
  # end

  # describe "PATCH #update_quantity" do
  # end

  # describe "PATCH #downgrade_quantity" do
  # end

  # describe "DELETE #remove_product_from_cart" do
  # end
end
