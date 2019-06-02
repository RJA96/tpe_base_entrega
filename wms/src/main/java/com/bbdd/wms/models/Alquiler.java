package com.bbdd.wms.models;

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
@Table(schema = "unc_248381",name = "gr05_alquiler")
public class Alquiler {
  @Id
  private long idAlquiler;
  private long idCliente;
  private java.sql.Date fechaDesde;
  private java.sql.Date fechaHasta;
  private String importeDia;

}
