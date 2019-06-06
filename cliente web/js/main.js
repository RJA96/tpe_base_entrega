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
              load();
              document.querySelector(".create").addEventListener("click", create);
              document.querySelector(".delete").addEventListener("click", delate);
              document.querySelector(".edit").addEventListener("click", edit);
              
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
    let container = document.querySelector(".alquiler")
    fetch('http://localhost:8080/api/v1/alquiler')
              .then(r => r.json())
              .then(json =>  mostraralquiler(json, container))
              .catch(error => container.innerHTML= "error");
  }

  function mostraralquiler(json, container){
    let div = container;
    div.innerHTML = '';
    
    
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_alquiler = document.createElement("td");
      let td_idCliente = document.createElement("td");
      let td_fechaDesde = document.createElement("td");
      let td_fechaHasta = document.createElement("td");
      let td_importeDia = document.createElement("td");
      let idAlquiler = document.createTextNode(json[i].idAlquiler);
      let idCliente = document.createTextNode(json[i].idCliente);
      let fechaDesde = document.createTextNode(json[i].fechaDesde);
      let fechaHasta = document.createTextNode(json[i].fechaHasta);
      let importeDia = document.createTextNode(json[i].importeDia);
      node.appendChild(td_alquiler);
      td_alquiler.appendChild(idAlquiler);
      node.appendChild(td_idCliente);
      td_idCliente.appendChild(idCliente);
      node.appendChild(td_fechaDesde );
      td_fechaDesde.appendChild(fechaDesde);
      node.appendChild(td_fechaHasta);
      td_fechaHasta.appendChild(fechaHasta);
      node.appendChild(td_importeDia);
      div.appendChild(node);
      td_importeDia.appendChild(importeDia);
      
      }
  }