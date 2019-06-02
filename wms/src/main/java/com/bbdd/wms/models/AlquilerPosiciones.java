package com.bbdd.wms.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
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
  private long posGlobal;
  private long nroPosicion;
  private long nroEstanteria;
  private long nroFila;
}
