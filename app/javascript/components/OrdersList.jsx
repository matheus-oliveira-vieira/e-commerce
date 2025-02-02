import React, { useEffect, useState } from "react";
import { useCart } from "../context/CartContext";
import { Link } from "react-router-dom";

export default function OrdersList(){
  const { getUserOrders } = useCart()
  const [orders, setOrders] = useState([])

  useEffect(() => {
    getUserOrders().then(setOrders);
  }, [])

  const formattedValue = (value) => new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL'}).format(value)

  return (
    <>
      <div className="flex items-center justify-center py-2 px-2 flex-col">
        <div className="max-w-5xl w-full space-y-8">
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            Meus pedidos
          </h2>
          {orders.length === 0 ? (
            <p className="mt-2 text-base text-center text-gray-800">
              O carrinho está vazio
            </p>
          ) : (
            <div className="mt-14">
              {orders.map((order, index, array) => (
                <>
                  <hr className={`border-b-1 border-border-gray mt-6 mb-6`} />
                  <div key={order.id} className="flex flex-row items-center justify-center">
                    <h2 className="text-2xl font-bold text-gray-900">
                      Pedido #{order.id}
                    </h2>
                    <h2 className="text-2xl font-bold text-gray-900 ml-8">
                      Valor do pedido: {formattedValue(order.total_price)}
                    </h2>
                    <h2 className="text-2xl font-bold text-gray-900 ml-8">
                      Itens do pedido
                    </h2>
                    <div className="flex flex-col ml-8">
                      {order.order_items.map((order_item) => (
                        <p className="mt-2 text-base text-gray-800">{order_item.product.name}: {order_item.quantity} {order_item.quantity > 1 ? "itens" : "item"}</p>
                      ))}
                    </div>
                  </div>
                  {index === array.length-1 && (<hr className={`border-b-1 border-gray mt-6 mb-6`} />)}
                </>
              ))}
            </div>
          )}
        </div>
        <Link to={`/`} className="text-white bg-blue-700 font-semibold rounded-lg text-base px-5 py-2.5 me-2 mb-2 mt-3">Voltar para a tela inicial</Link>
      </div>
    </>
  );
};
