import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Products = () => {
  const navigate = useNavigate();
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const url = "/api/v1/products/index";
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => setProducts(res))
      .catch(() => navigate("/"));
  }, []);

  const allProducts = products.map((product, index) => (
    <div key={index} className="col-md-6 col-lg-4">
      <div className="card mb-4">
        <img
          src={product.product_picture}
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
  ));
  const noProduct = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        Sem produtos cadastrados. Você pode <Link to="/new_product">criar um</Link>
      </h4>
    </div>
  );

  return (
    <>
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">Produtos</h1>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="text-end mb-3">
            <Link to="/product" className="btn custom-button">
              Criar novo produto
            </Link>
          </div>
          <div className="row">
            {products.length > 0 ? allProducts : noProduct}
          </div>
          <Link to="/" className="btn btn-link">
            Home
          </Link>
        </main>
      </div>
    </>
  );
};

export default Products;