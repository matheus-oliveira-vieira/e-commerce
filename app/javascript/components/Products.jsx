import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

export default function Products() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchProducts = async () => {
      const response = await fetch('/api/v1/products/index', {
        headers: { 'Accept': 'application/json' },
      });
      const data = await response.json();
      console.log("data", data)
      setProducts(data);
    };
    fetchProducts()
  }, []);

  return (
    <>
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">Produtos</h1>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="row">
            {products.map((product, index) => (
              <div key={index} className="col-md-6 col-lg-4">
                <div className="card mb-4">
                  <img
                    src={product.product_picture_url}
                    className="card-img-top"
                    alt={`${product.name} image`}
                  />
                  <div className="card-body">
                    <h5 className="card-title">{product.name}</h5>
                    <Link to={`/product/${product.id}`} className="btn custom-button">
                      Ver Produto
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </main>
      </div>
    </>
  );
};
