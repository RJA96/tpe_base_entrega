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
@Table(schema = "unc_248381",name = "gr05_mov_salida")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class MovSalida {
  @Id
  private long idMovimiento;
  private String transporte;
  private String guia;
  private long idMovimientoEntrada;


  public long getIdMovimiento() {
    return idMovimiento;
  }

  public void setIdMovimiento(long idMovimiento) {
    this.idMovimiento = idMovimiento;
  }


  public String getTransporte() {
    return transporte;
  }

  public void setTransporte(String transporte) {
    this.transporte = transporte;
  }


  public String getGuia() {
    return guia;
  }

  public void setGuia(String guia) {
    this.guia = guia;
  }


  public long getIdMovimientoEntrada() {
    return idMovimientoEntrada;
  }

  public void setIdMovimientoEntrada(long idMovimientoEntrada) {
    this.idMovimientoEntrada = idMovimientoEntrada;
  }

}
