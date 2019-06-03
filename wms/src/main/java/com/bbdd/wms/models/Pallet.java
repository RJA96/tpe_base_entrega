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
@Table(schema = "unc_248381",name = "gr05_pallet")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Pallet {
  @Id
  private long codPallet;
  private String descripcion;
  private String peso;


  public long getCodPallet() {
    return codPallet;
  }

  public void setCodPallet(long codPallet) {
    this.codPallet = codPallet;
  }


  public String getDescripcion() {
    return descripcion;
  }

  public void setDescripcion(String descripcion) {
    this.descripcion = descripcion;
  }


  public String getPeso() {
    return peso;
  }

  public void setPeso(String peso) {
    this.peso = peso;
  }

}
