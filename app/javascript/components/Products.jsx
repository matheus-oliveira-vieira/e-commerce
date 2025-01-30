import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

export default function Products({ currentUser }) {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchProducts = async () => {
      const response = await fetch('/api/v1/products', {
        headers: { 'Accept': 'application/json' },
      });
      const data = await response.json();
      setProducts(data);
    };
    fetchProducts()
  }, []);

  return (
    <>
      <div className="flex items-center justify-center m-3">

        <h2 className="text-2xl font-bold text-gray-900">
          Produtos disponíveis
        </h2>
      </div>

      <div className="grid grid-cols-3 place-items-center">
        {products.map((product, index) => (
          <div key={index} className="mb-4">
            <img
              src={product.product_picture_url}
              className="w-[300px] h-[300px] rounded-lg shadow-md"
              alt={`${product.name} image`}
            />
            <div className="flex m-3 items-center justify-center">
              <p className="mt-2 text-base text-gray-800">{product.name}</p>
              <Link to={`/products/${product.id}`} state={{ currentUser: currentUser }} className="text-white bg-green-700 font-semibold rounded-lg text-base p-2 ml-2.5">
                Ver detalhes
              </Link>
            </div>
          </div>
        ))}
      </div>
    </>
  );
};
