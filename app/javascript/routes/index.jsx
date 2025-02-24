import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Products from "../components/Products";
import Product from "../components/Product";
import { CartProvider } from "../context/CartContext"
import Cart from "../components/Cart";
import OrdersList from "../components/OrdersList";

export default (
  <CartProvider>
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/products" element={<Products />} />
        <Route path="/products/:id" element={<Product />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/orders" element={<OrdersList />} />
      </Routes>
    </Router>
  </CartProvider>
)