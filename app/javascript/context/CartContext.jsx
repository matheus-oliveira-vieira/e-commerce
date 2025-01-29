import React, { createContext, useContext, useEffect, useState } from "react";

const CartContext = createContext();

export const CartProvider = ({ children }) => {
  const [cart, setCart] = useState(null);

  // Carregar carrinho do backend
  useEffect(() => {
    fetch("/api/v1/cart")
      .then((res) => res.json())
      .then((data) => setCart(data))
      .catch((err) => console.error("Erro ao carregar carrinho:", err));
  }, []);

  // Adicionar produto ao carrinho
  const addToCart = (productId) => {
    fetch("/api/v1/cart/cart_items", {
      method: "POST",
      credentials: "include", // Importante para enviar cookies de sessão
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.cookie
          .split("; ")
          .find((row) => row.startsWith("CSRF-TOKEN="))
          ?.split("=")[1],
      },
      body: JSON.stringify({ product_id: productId }),
    })
      .then((res) => res.json())
      .then((data) => setCart(data))
      .catch((err) => console.error("Erro ao adicionar produto:", err));
  };

  // Atualizar quantidade do item
  const updateQuantity = (itemId, quantity) => {
    fetch(`/api/v1/cart/cart_items/${itemId}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ quantity }),
    })
      .then((res) => res.json())
      .then((data) => setCart(data))
      .catch((err) => console.error("Erro ao atualizar quantidade:", err));
  };

  // Remover item do carrinho
  const removeFromCart = (itemId) => {
    fetch(`/api/v1/cart/cart_items/${itemId}`, { method: "DELETE" })
      .then((res) => res.json())
      .then((data) => setCart(data))
      .catch((err) => console.error("Erro ao remover item:", err));
  };

  return (
    <CartContext.Provider value={{ cart, addToCart, updateQuantity, removeFromCart }}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => useContext(CartContext);
