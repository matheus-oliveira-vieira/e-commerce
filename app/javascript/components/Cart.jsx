import React from "react";
import { useCart } from "../context/CartContext";

export default function Cart(){
  const { cart, updateQuantity, removeFromCart } = useCart();

  if (!cart) return <p>Carregando carrinho...</p>;

  return (
    <div className="cart">
      <h2>Meu Carrinho</h2>
      {cart.cart_items.length === 0 ? (
        <p>O carrinho está vazio.</p>
      ) : (
        <ul>
          {cart.cart_items.map((item) => (
            <li key={item.id} className="cart-item">
              <img src={item.product.image} alt={item.product.name} width="50" />
              <div>
                <h4>{item.product.name}</h4>
                <p>Preço: R$ {item.product.price}</p>
                <div className="quantity-controls">
                  <button onClick={() => updateQuantity(item.id, item.quantity - 1)}>-</button>
                  <span>{item.quantity}</span>
                  <button onClick={() => updateQuantity(item.id, item.quantity + 1)}>+</button>
                </div>
                <button onClick={() => removeFromCart(item.id)}>Remover</button>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};
