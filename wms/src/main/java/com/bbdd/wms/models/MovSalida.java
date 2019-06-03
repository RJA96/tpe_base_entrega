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

    public void setAll(MovSalida c) {
      this.idMovimiento=c.getIdMovimiento();
      this.transporte=c.getTransporte();
      this.guia=c.getGuia();
      this.idMovimientoEntrada=c.getIdMovimientoEntrada();
    }
}
