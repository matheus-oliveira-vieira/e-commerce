require 'rails_helper'

describe Api::V1::CartItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:product) { create(:product) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product) }

  describe 'POST #create' do
    context 'com um usuário logado' do
      before { sign_in user }
      context 'quando o produto existe' do
        it 'adiciona um item ao carrinho' do
          expect {
            post :create, params: { product_id: product.id }, format: :json
          }.to change(CartItem, :count).by(1)

          expect(response).to have_http_status(:success)
          json_response = JSON.parse(response.body)
          expect(json_response['cart_items'].first['product']['id']).to eq(product.id)
        end
      end

      context 'quando o produto não existe' do
        it 'retorna um erro' do
          post :create, params: { product_id: 9999 }, format: :json
          expect(response).to have_http_status(:not_found)
          json_response = JSON.parse(response.body)
          expect(json_response['error']).to eq('Recurso não encontrado')
        end
      end
    end

    context 'sem um usuário logado' do
      context 'quando o produto existe' do
        it 'retorna erro' do
          post :create, params: { product_id: product.id }, format: :json

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'com um usuário logado' do
      before { sign_in user }
      context 'quando a atualização é válida' do
        it 'atualiza a quantidade do item' do
          patch :update, params: { id: cart_item.id, quantity: 3 }, format: :json
          expect(response).to have_http_status(:success)
          json_response = JSON.parse(response.body)
          expect(json_response['cart_items'].first['quantity']).to eq(3)
        end
      end

      context 'quando o item não existe' do
        it 'retorna um erro' do
          patch :update, params: { id: 9999, quantity: 3 }, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'sem um usuário logado' do
      context 'quando o produto existe' do
        it 'retorna erro' do
          patch :update, params: { id: cart_item.id, quantity: 3 }, format: :json

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'com um usuário logado' do
      before do
        user.cart&.destroy
        user.update(cart: cart)
        sign_in user
      end
      context 'quando o item existe' do
        it 'remove o item do carrinho' do
          cart_item
          expect {
            delete :destroy, params: { id: cart_item.id }, format: :json
          }.to change(CartItem, :count).by(-1)

          expect(response).to have_http_status(:ok)
        end
      end

      context 'quando o item não existe' do
        it 'retorna um erro' do
          delete :destroy, params: { id: 9999 }, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'sem um usuário logado' do
      context 'quando o item existe' do
        it 'remove o item do carrinho' do
          cart_item
          delete :destroy, params: { id: cart_item.id }, format: :json

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
