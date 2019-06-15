package com.bbdd.wms.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(schema = "unc_248381",name = "gr05_alquiler")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Alquiler implements Serializable {
  @Id
  private long idAlquiler;

  @JoinColumn(table = "gr05_cliente", name = "id_cliente")
  private long idCliente;

  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date fechaDesde;
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date fechaHasta;
  private double importeDia;

  public void setAll(Alquiler a) {
      this.idAlquiler=a.getIdAlquiler();
      this.idCliente=a.getIdCliente();
      this.fechaDesde=a.getFechaDesde();
      this.fechaHasta=a.getFechaHasta();
      this.importeDia=a.getImporteDia();
  }
}
