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
@Table(schema = "unc_248381",name = "gr05_estanteria")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Estanteria {

  @Id
  private long nroEstanteria;
  private String nombreEstanteria;

  public void setAll(Estanteria c) {
    this.nroEstanteria=c.getNroEstanteria();
    this.nombreEstanteria=c.getNombreEstanteria();
  }
}
