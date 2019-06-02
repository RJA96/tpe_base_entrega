package com.bbdd.wms.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(schema = "unc_248381",name = "gr05_alquiler_posiciones")
public class AlquilerPosiciones {

  @Id
  private long idAlquiler;
  private String estado;

  @JoinColumn(table = "posicion", name = "pos_global")
  private long posGlobal;
  private long nroPosicion;
  private long nroEstanteria;
  private long nroFila;

  public void setAll(AlquilerPosiciones c) {
      this.idAlquiler=c.getIdAlquiler();
      this.estado=c.getEstado();
      this.posGlobal=c.getPosGlobal();
      this.nroPosicion=c.getNroPosicion();
      this.nroEstanteria=c.getNroEstanteria();
      this.nroFila=c.getNroFila();
  }
}
