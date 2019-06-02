package com.bbdd.wms.models;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(schema = "unc_248381",name = "gr05_cliente")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Cliente implements Serializable {
  @Id
  private long cuitCuil;
  private String apellido;
  private String nombre;
  private Date fechaAlta;

  public void setAll(Cliente c) {
    this.cuitCuil=c.getCuitCuil();
    this.apellido=c.getApellido();
    this.nombre=c.getNombre();
    this.fechaAlta=c.getFechaAlta();
  }
}
