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
@Table(schema = "unc_248381",name = "gr05_posicion")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Posicion {
  @Id
  private long posGlobal;
  private long nroPosicion;
  private long nroEstanteria;
  private long nroFila;
  private String tipo;


}
