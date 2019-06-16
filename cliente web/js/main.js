document.querySelector('.Clientes').addEventListener("click", function () {
  mostrarpag("div/Clientes.html")
});
document.querySelector('.Alquileres').addEventListener("click", function () {
  mostrarpag("div/Alquileres.html")
});
document.querySelector('.Posiciones').addEventListener("click", function () {
  mostrarpag("div/Posiciones.html")
});
document.querySelector('.Filas-Estanterias').addEventListener("click", function () {
  mostrarpag("div/Filas-Estanterias.html")
});
document.querySelector('.Pallets').addEventListener("click", function () {
  mostrarpag("div/Pallets.html")
});
document.querySelector('.Movimientos').addEventListener("click", function () {
  mostrarpag("div/Movimientos.html")
});
document.querySelector('.Movinternos').addEventListener("click", function () {
  mostrarpag("div/Mov_interno.html")
});
document.querySelector('.Home').addEventListener("click", function () {
  mostrarpag("div/home.html")
});
document.querySelector('.pos-libres').addEventListener("click", function () {
  load('PosLibres_fecha')
})
document.querySelector('.cliente-pos').addEventListener("click", function () {
  load('Pos_clientes')
})

function mostrarpag(url) {
  let container = document.querySelector(".use-ajax");
  fetch(url)
    .then(response => {
      response.text().then(t => {
          container.innerHTML = t;
          if (url == 'div/home.html') {
            document.querySelector('.pos-libres').addEventListener("click", function () {
              load('PosLibres_fecha')
            })
            document.querySelector('.cliente-pos').addEventListener("click", function () {
              load('Pos_clientes')
            })
          }
          if (url === "div/Clientes.html") {
            load('cliente');
            document.querySelector(".create").addEventListener("click", create);
            document.querySelector(".delete").addEventListener("click", delate);
            document.querySelector(".edit").addEventListener("click", edit);
          }
          if (url === "div/Alquileres.html") {
            load('alquiler');
            document.querySelector(".create").addEventListener("click", create);
            document.querySelector(".delete").addEventListener("click", delate);
            document.querySelector(".edit").addEventListener("click", edit);

          }
          if (url === "div/Posiciones.html") {
            load('posicion');
            document.querySelector(".create").addEventListener("click", create);
            document.querySelector(".delete").addEventListener("click", delate);
            document.querySelector(".edit").addEventListener("click", edit);
          }
          if (url === "div/Filas-Estanterias.html") {
            load('filas')
            document.querySelector(".create_fila").addEventListener("click", create);
            document.querySelector(".delete_fila").addEventListener("click", delate);
            document.querySelector(".edit_fila").addEventListener("click", edit);
            document.querySelector(".create_estanteria").addEventListener("click", create);
            document.querySelector(".delete_estanteria").addEventListener("click", delate);
            document.querySelector(".edit_estanteria").addEventListener("click", edit);
          }
          if (url === "div/Pallets.html") {
            load('pallet');
          }
          if (url == "div/Movimientos.html") {
            load('movimientos')
          }
          if (url === "div/Mov_internos.html") {}
        })

        .catch(error => console.log(error))
    });
}

function load(pag) {
  if (pag == 'alquiler') {
    let container = document.querySelector(".alquiler")
    fetch('http://localhost:8080/api/v1/alquiler')
      .then(r => r.json())
      .then(json => mostrar(json, container, 'alquiler'))
      .catch(error => container.innerHTML = "error");
  }
  if (pag == 'cliente') {
    let container = document.querySelector(".tbodycliente")
    fetch('http://localhost:8080/api/v1/cliente')
      .then(r => r.json())
      .then(json => mostrar(json, container, 'cliente'))
      .catch(error => container.innerHTML = "error");
  }
  if (pag == 'posicion') {
    let container = document.querySelector(".tbodypos")
    fetch('http://localhost:8080/api/v1/posicion')
      .then(r => r.json())
      .then(json => mostrar(json, container, 'posicion'))
      .catch(error => container.innerHTML = "error");
  }
  if (pag == 'filas') {
    let containerE = document.querySelector(".tbodyestanteria");
    let containerF = document.querySelector(".tbodyfila");
    fetch('http://localhost:8080/api/v1/estanteria')
      .then(r => r.json())
      .then(json => mostrar(json, containerE, 'estanteria'))
      .then(function () {
        fetch('http://localhost:8080/api/v1/fila')
          .then(r => r.json())
          .then(json => mostrar(json, containerF, 'fila'))
          .catch(error => containerF.innerHTML = "error");
      })
      .catch(error => containerE.innerHTML = "error");
  }
  if (pag == 'pallet') {
    let container = document.querySelector(".tbodypallet")
    fetch('http://localhost:8080/api/v1/pallet')
      .then(r => r.json())
      .then(json => mostrar(json, container, 'pallet'))
      .catch(error => container.innerHTML = "error");
  }
  if (pag == 'movimientos') {
    let container = document.querySelector(".tbodymovimiento")
    fetch('http://localhost:8080/api/v1/movimiento')
      .then(r => r.json())
      //.then(json => console.log(json))
      .then(json => mostrar(json, container, 'movimientos'))
      .catch(error => container.innerHTML = "error");
  }
  if (pag == 'PosLibres_fecha') {
    let container = document.querySelector(".tbodypos-libres")
    let fecha = document.querySelector(".dia").value;
    fetch('http://localhost:8080/api/v1/posicion/pos-libres/{date}?date=' + fecha)
      .then(r => r.json())
      .then(json => mostrar(json, container, 'PosLibres_fecha'))
      .catch(error => container.innerHTML = "error");
  }
  if (pag == 'Pos_clientes') {
    let container = document.querySelector(".containercliente");
    let cliente = document.querySelector(".id_cliente").value
    fetch('http://localhost:8080/api/v1/posicion/pos-ocupadas/' + cliente)
      .then(r => r.json())
      .then(json => mostrar(json, container, 'Pos_clientes'))
      .catch(error => container.innerHTML = "error");
  }
}

function mostrar(json, container, pag) {
  if (pag == 'alquiler') {
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
      node.appendChild(td_fechaDesde);
      td_fechaDesde.appendChild(fechaDesde);
      node.appendChild(td_fechaHasta);
      td_fechaHasta.appendChild(fechaHasta);
      node.appendChild(td_importeDia);
      td_importeDia.appendChild(importeDia);
      div.appendChild(node);
    }
  }
  if (pag == 'cliente') {
    let div = container;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_cuitCuil = document.createElement("td");
      let td_apellido = document.createElement("td");
      let td_nombre = document.createElement("td");
      let td_fechaAlta = document.createElement("td");
      let cuitCuil = document.createTextNode(json[i].cuitCuil);
      let apellido = document.createTextNode(json[i].apellido);
      let nombre = document.createTextNode(json[i].nombre);
      let fechaAlta = document.createTextNode(json[i].fechaAlta);
      node.appendChild(td_cuitCuil);
      td_cuitCuil.appendChild(cuitCuil);
      node.appendChild(td_apellido);
      td_apellido.appendChild(apellido);
      node.appendChild(td_nombre);
      td_nombre.appendChild(nombre);
      node.appendChild(td_fechaAlta);
      td_fechaAlta.appendChild(fechaAlta);
      div.appendChild(node);
    }
  }
  if (pag == 'posicion') {
    let div = container;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_posGlobal = document.createElement("td");
      let td_nroPosicion = document.createElement("td");
      let td_nroEstanteria = document.createElement("td");
      let td_nroFila = document.createElement("td");
      let td_tipo = document.createElement("td");
      let posGlobal = document.createTextNode(json[i].posGlobal);
      let nroPosicion = document.createTextNode(json[i].nroPosicion);
      let nroEstanteria = document.createTextNode(json[i].nroEstanteria);
      let nroFila = document.createTextNode(json[i].nroFila);
      let tipo = document.createTextNode(json[i].tipo);
      node.appendChild(td_posGlobal);
      td_posGlobal.appendChild(posGlobal);
      node.appendChild(td_nroPosicion);
      td_nroPosicion.appendChild(nroPosicion);
      node.appendChild(td_nroEstanteria);
      td_nroEstanteria.appendChild(nroEstanteria);
      node.appendChild(td_nroFila);
      td_nroFila.appendChild(nroFila);
      node.appendChild(td_tipo);
      td_tipo.appendChild(tipo);
      div.appendChild(node);
    }
  }
  if (pag == 'estanteria') {
    let div = container;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_nombreEstanteria = document.createElement("td");
      let td_nroEstanteria = document.createElement("td");
      let nombreEstanteria = document.createTextNode(json[i].nombreEstanteria);
      let nroEstanteria = document.createTextNode(json[i].nroEstanteria);
      node.appendChild(td_nombreEstanteria);
      td_nombreEstanteria.appendChild(nombreEstanteria);
      node.appendChild(td_nroEstanteria);
      td_nroEstanteria.appendChild(nroEstanteria);
      div.appendChild(node);
    }
  }
  if (pag == 'fila') {
    let div = container;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_nroEstanteria = document.createElement("td");
      let td_nroFila = document.createElement("td");
      let td_nombreFila = document.createElement("td");
      let td_pesoMaxKg = document.createElement("td");
      let nroEstanteria = document.createTextNode(json[i].nroEstanteria);
      let nroFila = document.createTextNode(json[i].nroFila);
      let nombreFila = document.createTextNode(json[i].nombreFila);
      let pesoMaxKg = document.createTextNode(json[i].pesoMaxKg);
      node.appendChild(td_nroEstanteria);
      td_nroEstanteria.appendChild(nroEstanteria);
      node.appendChild(td_nroFila);
      td_nroFila.appendChild(nroFila);
      node.appendChild(td_nombreFila);
      td_nombreFila.appendChild(nombreFila);
      node.appendChild(td_pesoMaxKg);
      td_pesoMaxKg.appendChild(pesoMaxKg);
      div.appendChild(node);
    }
  }
  if (pag == 'pallet') {
    let div = container;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_codPallet = document.createElement("td");
      let td_descripcion = document.createElement("td");
      let td_peso = document.createElement("td");
      let codPallet = document.createTextNode(json[i].codPallet);
      let descripcion = document.createTextNode(json[i].descripcion);
      let peso = document.createTextNode(json[i].peso);
      node.appendChild(td_codPallet);
      td_codPallet.appendChild(codPallet);
      node.appendChild(td_descripcion);
      td_descripcion.appendChild(descripcion);
      node.appendChild(td_peso);
      td_peso.appendChild(peso);
      div.appendChild(node);
    }
  }
  if (pag == 'movimientos') {
    let div = container;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_idMovimiento = document.createElement("td");
      let td_fecha = document.createElement("td");
      let td_responsable = document.createElement("td");
      let td_tipo = document.createElement("td");
      let idMovimiento = document.createTextNode(json[i].idMovimiento);
      let fecha = document.createTextNode(json[i].fecha);
      let responsable = document.createTextNode(json[i].responsable);
      let tipo = document.createTextNode(json[i].tipo);
      node.appendChild(td_idMovimiento);
      td_idMovimiento.appendChild(idMovimiento);
      node.appendChild(td_fecha);
      td_fecha.appendChild(fecha);
      node.appendChild(td_responsable);
      td_responsable.appendChild(responsable);
      node.appendChild(td_tipo);
      td_tipo.appendChild(tipo);
      div.appendChild(node);
    }
  }
  if (pag == 'PosLibres_fecha') {
    let div = container;
    document.querySelector(".table-posicioneslibrefecha").hidden = false;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_estanteria = document.createElement("td");
      let td_fila = document.createElement("td");
      let td_posicion = document.createElement("td");
      let fila = document.createTextNode(json[i].nro_fila);
      let estanteria = document.createTextNode(json[i].nro_estanteria);
      let posicion = document.createTextNode(json[i].nro_posicion);
      node.appendChild(td_fila);
      td_fila.appendChild(fila);
      node.appendChild(td_estanteria);
      td_estanteria.appendChild(estanteria);
      node.appendChild(td_posicion);
      td_posicion.appendChild(posicion);
      div.appendChild(node)
    }
  }
  if (pag == 'Pos_clientes') {
    let div = container;
    document.querySelector(".table-posicionesporcliente").hidden = false;
    div.innerHTML = '';
    for (let i = 0; i < json.length; i++) {
      let node = document.createElement("tr");
      let td_estanteria = document.createElement("td");
      let td_fila = document.createElement("td");
      let td_posicion = document.createElement("td");
      let estanteria = document.createTextNode(json[i].nro_estanteria);
      let fila = document.createTextNode(json[i].nro_fila);
      let posicion = document.createTextNode(json[i].nro_posicion);
      node.appendChild(td_estanteria);
      td_estanteria.appendChild(estanteria);
      node.appendChild(td_fila);
      td_fila.appendChild(fila);
      node.appendChild(td_posicion);
      td_posicion.appendChild(posicion);
      div.appendChild(node)
    }
  }
}