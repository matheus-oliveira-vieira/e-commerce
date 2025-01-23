import React, {useEffect, useState} from "react";
import { Link } from "react-router-dom";
import axios from 'axios';
import Products from "./Products";


export default function Home () {
  const [currentUser, setCurrentUser] = useState(null);

  const handleLogin = () => {
    window.location.href = "/users/sign_in";
  };

  useEffect(() => {
    axios.get("/api/v1/current_user")
      .then(response => {
        setCurrentUser(response.data);
      })
      .catch(error => {
        console.error("Erro ao buscar o usuário atual:", error);
      });
  }, []);

  const handleLogout = () => {
    axios
      .delete("/users/sign_out", {
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
      })
      .then((response) => {
        window.location.href = "/";
      })
      .catch((error) => {
        console.error("Erro ao deslogar:", error);
      });
  };

  if (!currentUser) {
    return <div>Carregando...</div>;
  }

  return (
    <>
      {currentUser.email && (
        <>
          <p>email: {currentUser.email}</p>

          <button onClick={handleLogout} className="logout-button">
            Sair
          </button>
        </>
      )}

      {!currentUser.email && (
        <button onClick={handleLogin} className="login-button">
          Entrar
        </button>
      )}

      <p className="text-3xl font-bold">
        Bluesoft E-commerce
      </p>

      <p className="text-xl">
        Desafio técnico para vaga de desenvolvedor Ruby na Bluesoft
      </p>

      <Products />
    </>
  )
}
