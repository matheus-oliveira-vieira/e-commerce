import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Product = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [product, setProduct] = useState({});

  useEffect(() => {
    const fetchProduct = async (id) => {
      try {
        const response = await fetch(`/api/v1/products/${id}`);
        if (!response.ok) {
          throw new Error("Erro ao buscar produto");
        }
        const data = await response.json();
        setProduct(data)
      } catch (error) {
        console.error(error);
      }
    };
    fetchProduct(params.id)
  }, [params.id]);

  return (
    <>
      {product.name}
      {product.description}
      {product.price}
      {product.stock_quantity}

      <Link to={`/add_to_cart/${product.id}`} className="btn custom-button">adicionar ao carrinho</Link>
      <Link to={`/`} className="btn custom-button">voltar a tela inicial</Link>
    </>
  )
};

export default Product;