import React, { useState, useEffect } from "react";
import { Link, useParams } from "react-router-dom";
import { useCart } from "../context/CartContext";

export default function Product() {
  const params = useParams();
  const [product, setProduct] = useState({});
  // const [cart, setCart] = useState(null);
  const { addToCart } = useCart();

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

  const formattedValue = new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(product.price);

  return (
    <>
      <div class="flex items-center justify-center py-2 px-2 flex-col">
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          {product.name}
        </h2>
        <div className="flex flex-row mt-14">
          <img
            src={product.product_picture_url}
            className="w-[300px] h-[300px] rounded-lg shadow-md"
            alt={`${product.name} image`}
          />
          <div className="flex flex-col ml-6">
            <h3 class="text-xl font-extrabold text-gray-900">
              Descrição
            </h3>
            <p>{product.description}</p>

            <h3 class="mt-6 text-xl font-extrabold text-gray-900">
              Valor
            </h3>
            <p>{formattedValue}</p>
            <div className="mt-6">
              <button onClick={() => addToCart(product.id)} className="text-white bg-red-700 font-semibold rounded-lg text-base p-2">Adicionar ao carrinho</button>
            </div>
          </div>
        </div>
      </div>

      <Link to={`/`} className="btn custom-button">voltar a tela inicial</Link>
    </>
  )
};
