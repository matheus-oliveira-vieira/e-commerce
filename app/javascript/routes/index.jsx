import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Products from "../components/Products";
import Product from "../components/Product";
import Cart from "../components/Cart";

export default (
  <Router>
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/products" element={<Products />} />
      <Route path="/products/:id" element={<Product />} />
      <Route path="/carts/:product_id" element={<Cart />} />
    </Routes>
  </Router>
);