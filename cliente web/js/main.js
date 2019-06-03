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
              document.querySelector(".create").addEventListener("click", create);
              document.querySelector(".delete").addEventListener("click", delate);
              document.querySelector(".edit").addEventListener("click", edit);
            }
            if (url==="div/Alquileres.html"){
            //  document.querySelector(".create").addEventListener("click", create);
        //      document.querySelector(".delete").addEventListener("click", delate);
          //    document.querySelector(".edit").addEventListener("click", edit);
              load();
            }
            if (url==="div/Posiciones.html"){
                document.querySelector(".create").addEventListener("click", create);
                document.querySelector(".delete").addEventListener("click", delate);
                document.querySelector(".edit").addEventListener("click", edit);
            }
            if (url==="div/Filas-Estanterias.html"){
                document.querySelector(".create_fila").addEventListener("click", create);
                document.querySelector(".delete_fila").addEventListener("click", delate);
                document.querySelector(".edit_fila").addEventListener("click", edit);
                document.querySelector(".create_estanteria").addEventListener("click", create);
                document.querySelector(".delete_estanteria").addEventListener("click", delate);
                document.querySelector(".edit_estanteria").addEventListener("click", edit);
            }
            if (url==="div/Pallets.html"){
            }
            if (url==="div/Movimientos.html"){
            }
          })
  
        .catch(error => console.log(error))
      });
  }

  function load(){
    fetch('http://localhost:8080/api/v1/Alquiler')
              .then(r => r.json())
              .then(json =>  console.log(json))
              .catch(error => container.innerHTML= "error");
  }

  function mostraralquiler(json){
      
  }