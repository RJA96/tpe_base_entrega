package com.bbdd.wms.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(schema = "unc_248381",name = "gr05_posicion")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Posicion implements Serializable {
  @Id
  private long posGlobal;

  private long nroPosicion;
  private long nroEstanteria;
  private long nroFila;
  private String tipo;


  public void setAll(Posicion c) {
    this.posGlobal=c.getPosGlobal();
    this.nroPosicion=c.getNroPosicion();
    this.nroEstanteria=c.getNroEstanteria();
    this.nroFila=c.getNroFila();
    this.tipo=c.getTipo();
  }
}
