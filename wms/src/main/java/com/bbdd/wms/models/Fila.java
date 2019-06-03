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
@Table(schema = "unc_248381",name = "gr05_fila")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Fila {

  @Id
  private long nroEstanteria;
  private long nroFila;
  private String nombreFila;
  private String pesoMaxKg;

    public void setAll(Fila c) {
      this.nroEstanteria= c.getNroEstanteria();
      this.nroFila=c.getNroFila();
      this.nombreFila=c.getNombreFila();
      this.pesoMaxKg=c.getPesoMaxKg();
    }
}
