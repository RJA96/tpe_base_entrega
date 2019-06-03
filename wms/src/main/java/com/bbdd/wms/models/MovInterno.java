package com.bbdd.wms.models;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(schema = "unc_248381",name = "gr05_mov_interno")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class MovInterno {
  @Id
  private long idMovimiento;
  private String razon;
  private long idMovimientoEntrada;
  private long idMovimientoInterno;
  private long posGlobal;
  private long nroPosicion;
  private long nroEstanteria;
  private long nroFila;

}
