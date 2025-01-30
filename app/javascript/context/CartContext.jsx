import React, { createContext, useContext, useEffect, useState } from "react";

const CartContext = createContext();

export const CartProvider = ({ children }) => {
  const [cart, setCart] = useState(null)

  useEffect(() => {
    fetch("/api/v1/cart")
      .then((res) => res.json())
      .then((data) => setCart(data))
      .catch((err) => console.error("Erro ao carregar carrinho:", err))
  }, [])

  const addToCart = (productId) => {
    fetch("/api/v1/cart/cart_items", {
      method: "POST",
      credentials: "include",
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
      .catch((err) => console.error("Erro ao adicionar produto:", err))
  }

  const updateQuantity = (itemId, newQuantity) => {
    fetch(`/api/v1/cart/cart_items/${itemId}`, {
      method: "PATCH",
      credentials: "include",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.cookie
          .split("; ")
          .find((row) => row.startsWith("CSRF-TOKEN="))
          ?.split("=")[1],
      },
      body: JSON.stringify({ quantity: newQuantity }),
    })
      .then((res) => res.json())
      .then((updatedCart) => setCart(updatedCart))
      .catch((err) => console.error("Erro ao atualizar quantidade:", err));
  }

  const removeFromCart = (itemId) => {
    fetch(`/api/v1/cart/cart_items/${itemId}`, {
      method: "DELETE",
      credentials: "include",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.cookie
          .split("; ")
          .find((row) => row.startsWith("CSRF-TOKEN="))
          ?.split("=")[1],
      },
    })
      .then((res) => res.json())
      .then((data) => setCart(data))
      .catch((err) => console.error("Erro ao remover item:", err));
  }

  return (
    <CartContext.Provider value={{ cart, addToCart, updateQuantity, removeFromCart }}>
      {children}
    </CartContext.Provider>
  )
}

export const useCart = () => useContext(CartContext)
