document.querySelector('.Clientes').addEventListener("click", function(){mostrarpag("div/Clientes.html")});
document.querySelector('.Alquileres').addEventListener("click", function(){mostrarpag("div/Alquileres.html")});
document.querySelector('.Posiciones').addEventListener("click", function(){mostrarpag("div/Posiciones.html")});
document.querySelector('.Filas-Estanterias').addEventListener("click", function(){mostrarpag("div/Filas-Estanterias.html")});
document.querySelector('.Pallets').addEventListener("click", function(){mostrarpag("div/Pallets.html")});
document.querySelector('.Movimientos').addEventListener("click", function(){mostrarpag("div/Movimientos.html")});

function mostrarpag(url) {
    let container = document.querySelector(".use-ajax");
      fetch(url)
        .then(response => {
          response.text().then(t=> {
            container.innerHTML = t;
  
            if (url==="div/Cliente.html"){
              document.querySelector('.registrarse').addEventListener("click", function(){mostrarpag("server/registrar.html")});
            }
            if (url==="div/Alquileres.html"){
              document.querySelector(".upload").addEventListener("click", create);
              document.querySelector(".delete").addEventListener("click", delate);
              document.querySelector(".edit").addEventListener("click", edit);
            }
            if (url==="div/Posiciones.html"){
                document.querySelector('.registrarse').addEventListener("click", function(){mostrarpag("server/registrar.html")});
            }
            if (url==="div/Filas-Estanterias.html"){
                document.querySelector('.registrarse').addEventListener("click", function(){mostrarpag("server/registrar.html")});
            }
            if (url==="div/Pallets.html"){
                document.querySelector('.registrarse').addEventListener("click", function(){mostrarpag("server/registrar.html")});
            }
            if (url==="div/Movimientos.html"){
                document.querySelector('.registrarse').addEventListener("click", function(){mostrarpag("server/registrar.html")});
            }
          })
  
        .catch(error => console.log(error))
      });
  }