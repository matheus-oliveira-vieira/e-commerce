require 'rails_helper'

describe Api::V1::CartsController, type: :controller do
  # let(:user) { create(:user) }
  # let(:product) { create(:product) }
  # let(:cart) { create(:cart, user: user) }
  # let!(:cart_item) { create(:cart_item, cart: cart, product: product) }

  # before { sign_in user }

  # describe 'POST #create' do
  #   context 'quando o usuário já tem um carrinho' do
  #     before { allow(user).to receive(:cart).and_return(cart) }

  #     it 'retorna status forbidden' do
  #       post :create
  #       expect(response).to have_http_status(:forbidden)
  #     end
  #   end

  #   context 'quando o carrinho é criado com sucesso' do
  #     before { allow(user).to receive(:cart).and_return(nil) }

  #     it 'cria um novo carrinho e retorna mensagem de sucesso' do
  #       expect {
  #         post :create
  #       }.to change(Cart, :count).by(1)

  #       expect(response).to have_http_status(:ok)
  #       expect(JSON.parse(response.body)['message']).to eq('Successfully')
  #     end
  #   end
  # end

  # context "show" do
  # end

  # context "add_to_cart" do
  # end

  # context "update_quantity" do
  # end

  # context "downgrade_quantity" do
  # end

  # context "remove_product_from_cart" do
  # end
end
