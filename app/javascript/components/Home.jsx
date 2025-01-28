import React, {useEffect, useState} from "react";
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
      <div className="flex m-3">
        {currentUser.email && (
          <>
            <p className="mt-2 text-base text-gray-800">
              Logado como: {currentUser.email}
            </p>

            <button type="button" onClick={handleLogout} className="text-white bg-red-700 font-semibold rounded-lg text-base p-2 ml-2.5">
              Sair
            </button>
          </>
        )}

        {!currentUser.email && (
          <button type="button" onClick={handleLogin} className="text-white bg-blue-700 font-semibold rounded-lg text-base px-5 py-2.5 me-2 mb-2">
            Entrar
          </button>
        )}
      </div>

      <div className="flex items-center justify-center py-2 px-2">
        <div className="max-w-md w-full space-y-8">
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            Bluesoft E-commerce
          </h2>

          <p className="mt-2 text-center text-sm text-gray-600">
            Desafio técnico para vaga de desenvolvedor Ruby na Bluesoft
          </p>
        </div>
      </div>

      <Products />
    </>
  )
}
