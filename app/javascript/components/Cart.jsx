import React from "react";
import { Link, useNavigate } from "react-router-dom";
import { useCart } from "../context/CartContext";

export default function Cart(){
  const { cart, updateQuantity, removeFromCart, createOrder } = useCart()
  const navigate = useNavigate()

  if (!cart) return <p>Carregando carrinho...</p>

  const formattedValue = (value) => new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL'}).format(value)

  return (
    <>
      <div className="flex items-center justify-center py-2 px-2 flex-col">
        <div className="max-w-5xl w-full space-y-8">
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            Meu Carrinho
          </h2>
          {cart.cart_items.length === 0 ? (
            <p className="mt-2 text-base text-center text-gray-800">
              O carrinho está vazio
            </p>
          ) : (
            <div className="mt-14">
              {cart.cart_items.map((item, index, array) => (
                <>
                  <hr className={`border-b-1 border-border-gray mt-6 mb-6`} />
                  <div key={item.id} className="flex flex-row items-center justify-center">
                    <img
                      src={item.product.product_picture_url}
                      className="w-[100px] h-[100px] rounded-lg shadow-md mr-3"
                      alt={`${item.product.name} image cart`}
                    />
                    <div className="flex items-center justify-center">
                      <h3 className="text-xl font-bold text-gray-900">
                        {item.product.name}
                      </h3>
                      <div className="flex flex-col ml-6">
                        <p className="text-xl font-normal text-gray-900">
                          Quantidade
                        </p>
                        <div>
                          <button onClick={() => updateQuantity(item.id, Math.max(1, item.quantity - 1))} className="text-white bg-red-700 font-semibold rounded-full w-5 h-5 m-[7px] text-base">-</button>
                          <span className="text-center text-2xl font-bold text-gray-900">{item.quantity}</span>
                          <button onClick={() => updateQuantity(item.id, item.quantity + 1)} className="text-white bg-green-700 font-semibold rounded-full w-5 h-5 m-[7px] text-base">+</button>
                        </div>
                        <p className="text-xl font-normal text-gray-900">
                          Preço unitário
                        </p>
                        <p>{formattedValue(item.product.price)}</p>
                      </div>
                      <button onClick={() => removeFromCart(item.id)} className="text-white bg-red-700 font-semibold rounded-lg text-base px-5 py-2.5 me-2 ml-8">Remover produto</button>
                    </div>
                  </div>
                  {index === array.length-1 && (<hr className={`border-b-1 border-gray mt-6 mb-6`} />)}
                </>
              ))}
              <div className="flex items-center justify-center gap-x-2">
                <p className="text-xl font-bold text-gray-900">{"Valor total: "}</p>
                <p className="text-xl font-normal text-gray-900">{formattedValue(cart.total_price)}</p>
              </div>
            </div>
          )}
        </div>
        {cart.cart_items.length !== 0 && (<button onClick={() => createOrder(navigate)} className="text-white bg-red-700 font-semibold rounded-lg text-base px-5 py-2.5">Criar pedido</button>)}
        <Link to={`/`} className="text-white bg-blue-700 font-semibold rounded-lg text-base px-5 py-2.5 me-2 mb-2 mt-3">Voltar para a tela inicial</Link>
      </div>
    </>
  )
}
