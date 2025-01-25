import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Product = () => {
  const params = useParams();
  const [product, setProduct] = useState({});
  const [cart, setCart] = useState(null);

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
      {console.log(product)}
      {console.log(cart)}
      {product.name}
      {product.description}
      {product.price}

      <Link to={`/`} className="btn custom-button">voltar a tela inicial</Link>
    </>
  )
};

export default Product;