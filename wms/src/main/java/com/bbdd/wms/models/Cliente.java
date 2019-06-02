package com.bbdd.wms.models;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(schema = "unc_248381",name = "gr05_cliente")
public class Cliente implements Serializable {
  @Id
  private long cuitCuil;
  private String apellido;
  private String nombre;
  private java.sql.Date fechaAlta;

}
