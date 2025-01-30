import React from "react";
import { useLocation, Link } from "react-router-dom";
import { useCart } from "../context/CartContext";

export default function Cart(){
  const { cart, updateQuantity, removeFromCart } = useCart();
  const location = useLocation()
  const { currentUser } = location.state

  if (!cart) return <p>Carregando carrinho...</p>;

  const formattedValue = (value) => new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL'}).format(value);

  return (
    <>
      {console.log("Cart data:", cart)}
      <div className="flex items-center justify-center py-2 px-2 flex-col">
        <div className="max-w-md w-full space-y-8">
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            Meu Carrinho
          </h2>
          {cart.cart_items.length === 0 ? (
            <p className="mt-2 text-base text-center text-gray-800">
              O carrinho está vazio
            </p>
          ) : (
            <div className="flex flex-col mt-14">
              {cart.cart_items.map((item) => (
                <div key={item.id} className="mb-4">
                  {console.log("Product data:", item.product)}
                  <img
                    src={item.product.product_picture_url}
                    className="w-[100px] h-[100px] rounded-lg shadow-md"
                    alt={`${item.product.name} image cart`}
                  />
                  <div className="flex items-center justify-center w-fit">
                    <h3 className="text-xl font-bold text-gray-900">
                      {item.product.name}
                    </h3>
                    <div className="flex flex-row ml-6">
                      <p className="text-xl font-normal text-gray-900">
                        Quantidade
                      </p>
                      <button onClick={() => updateQuantity(item.id, Math.max(1, item.quantity - 1))} className="text-white bg-red-700 font-semibold rounded-full w-5 h-5 m-[7px] text-base">-</button>
                      <span className="text-center text-2xl font-bold text-gray-900">{item.quantity}</span>
                      <button onClick={() => updateQuantity(item.id, item.quantity + 1)} className="text-white bg-green-700 font-semibold rounded-full w-5 h-5 m-[7px] text-base">+</button>
                    </div>
                    <p className="text-xl font-normal text-gray-900">
                      Preço unitário
                    </p>
                    <p>{formattedValue(item.product.price)}</p>
                    <button onClick={() => removeFromCart(item.id)} className="text-white bg-red-700 font-semibold rounded-full text-base">Remover produto</button>
                  </div>
                </div>
              ))}
              <div className="flex items-center justify-center w-fit">
                <h3 className="text-xl font-bold text-gray-900">Valor total</h3>
                <p className="text-xl font-normal text-gray-900">{formattedValue(cart.price)}</p>
              </div>
            </div>
          )}
        </div>
        <Link to={`/`} className="text-white bg-blue-700 font-semibold rounded-lg text-base px-5 py-2.5 me-2 mb-2 mt-3">Voltar para a tela inicial</Link>
      </div>
    </>
  );
};
