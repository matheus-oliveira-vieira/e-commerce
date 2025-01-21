import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Product = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [product, setProduct] = useState({ name: "" });

  useEffect(() => {
    const url = `/api/v1/show/${params.id}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => setProduct(response))
      .catch(() => navigate("/products"));
  }, [params.id]);
};

export default Recipe;