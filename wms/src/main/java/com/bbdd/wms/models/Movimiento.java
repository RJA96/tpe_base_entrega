package com.bbdd.wms.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;
import java.util.Objects;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(schema = "unc_248381",name = "gr05_movimiento")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Movimiento {
  @Id
  private long idMovimiento;
  private Date fecha;
  private String responsable;
  private String tipo;

  public void setAll(Movimiento c) {
    this.idMovimiento=c.getIdMovimiento();
    this.fecha=c.getFecha();
    this.responsable=c.getResponsable();
    this.tipo=c.getTipo();
  }
  @Override
  public void finalize(){

  }
}
