-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-06-02 13:42:34.11

-- tables
-- Table: GR05_ALQUILER
CREATE TABLE GR05_ALQUILER (
    id_alquiler int  NOT NULL,
    id_cliente int  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NULL,
    importe_dia decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR05_ALQUILER PRIMARY KEY (id_alquiler)
);

-- Table: GR05_ALQUILER_POSICIONES
CREATE TABLE GR05_ALQUILER_POSICIONES (
    id_alquiler int  NOT NULL,
    estado boolean  NOT NULL,
    pos_global int  NOT NULL,
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    CONSTRAINT PK_GR05_ALQUILER_POSICIONES PRIMARY KEY (id_alquiler,pos_global,nro_posicion,nro_estanteria,nro_fila)
);

-- Table: GR05_CLIENTE
CREATE TABLE GR05_CLIENTE (
    cuit_cuil int  NOT NULL,
    apellido varchar(60)  NOT NULL,
    nombre varchar(40)  NOT NULL,
    fecha_alta date  NOT NULL,
    CONSTRAINT PK_GR05_CLIENTE PRIMARY KEY (cuit_cuil)
);

-- Table: GR05_ESTANTERIA
CREATE TABLE GR05_ESTANTERIA (
    nro_estanteria int  NOT NULL,
    nombre_estanteria varchar(80)  NOT NULL,
    CONSTRAINT PK_GR05_ESTANTERIA PRIMARY KEY (nro_estanteria)
);

-- Table: GR05_FILA
CREATE TABLE GR05_FILA (
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    nombre_fila varchar(80)  NOT NULL,
    peso_max_kg decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR05_FILA PRIMARY KEY (nro_estanteria,nro_fila)
);

-- Table: GR05_MOVIMIENTO
CREATE TABLE GR05_MOVIMIENTO (
    id_movimiento int  NOT NULL,
    fecha timestamp  NOT NULL,
    responsable varchar(80)  NOT NULL,
    tipo char(1)  NOT NULL,
    CONSTRAINT PK_GR05_MOVIMIENTO PRIMARY KEY (id_movimiento)
);

-- Table: GR05_MOV_ENTRADA
CREATE TABLE GR05_MOV_ENTRADA (
    id_movimiento int  NOT NULL,
    transporte varchar(80)  NOT NULL,
    guia varchar(80)  NOT NULL,
    cod_pallet int  NOT NULL,
    id_alquiler int  NOT NULL,
    pos_global int  NOT NULL,
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    CONSTRAINT PK_GR05_MOV_ENTRADA PRIMARY KEY (id_movimiento)
);

-- Table: GR05_MOV_INTERNO
CREATE TABLE GR05_MOV_INTERNO (
    id_movimiento int  NOT NULL,
    razon varchar(200)  NULL,
    id_movimiento_entrada int  NOT NULL,
    id_movimiento_interno int  NULL,
    pos_global int  NOT NULL,
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    CONSTRAINT PK_GR05_MOV_INTERNO PRIMARY KEY (id_movimiento)
);

-- Table: GR05_MOV_SALIDA
CREATE TABLE GR05_MOV_SALIDA (
    id_movimiento int  NOT NULL,
    transporte varchar(80)  NOT NULL,
    guia varchar(80)  NOT NULL,
    id_movimiento_entrada int  NOT NULL,
    CONSTRAINT PK_GR05_MOV_SALIDA PRIMARY KEY (id_movimiento)
);

-- Table: GR05_PALLET
CREATE TABLE GR05_PALLET (
    cod_pallet int  NOT NULL,
    descripcion varchar(200)  NOT NULL,
    peso decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR05_PALLET PRIMARY KEY (cod_pallet)
);

-- Table: GR05_POSICION
CREATE TABLE GR05_POSICION (
    pos_global serial  NOT NULL,
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    tipo varchar(40)  NOT NULL,
    CONSTRAINT PK_GR05_POSICION PRIMARY KEY (pos_global,nro_posicion,nro_estanteria,nro_fila)
);

-- foreign keys
-- Reference: FK_FILA_ESTANTERIA (table: GR05_FILA)
ALTER TABLE GR05_FILA ADD CONSTRAINT FK_FILA_ESTANTERIA
    FOREIGN KEY (nro_estanteria)
    REFERENCES GR05_ESTANTERIA (nro_estanteria)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05MOV_INTERNO_MOV_INTERNO (table: GR05_MOV_INTERNO)
ALTER TABLE GR05_MOV_INTERNO ADD CONSTRAINT FK_GR05MOV_INTERNO_MOV_INTERNO
    FOREIGN KEY (id_movimiento_interno)
    REFERENCES GR05_MOV_INTERNO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_ALQUILER_CLIENTE (table: GR05_ALQUILER)
ALTER TABLE GR05_ALQUILER ADD CONSTRAINT FK_GR05_ALQUILER_CLIENTE
    FOREIGN KEY (id_cliente)
    REFERENCES GR05_CLIENTE (cuit_cuil)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_ALQUILER_POSICIONES_ALQUILER (table: GR05_ALQUILER_POSICIONES)
ALTER TABLE GR05_ALQUILER_POSICIONES ADD CONSTRAINT FK_GR05_ALQUILER_POSICIONES_ALQUILER
    FOREIGN KEY (id_alquiler)
    REFERENCES GR05_ALQUILER (id_alquiler)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_ALQUILER_POSICIONES_POSICION (table: GR05_ALQUILER_POSICIONES)
ALTER TABLE GR05_ALQUILER_POSICIONES ADD CONSTRAINT FK_GR05_ALQUILER_POSICIONES_POSICION
    FOREIGN KEY (pos_global, nro_posicion, nro_estanteria, nro_fila)
    REFERENCES GR05_POSICION (pos_global, nro_posicion, nro_estanteria, nro_fila)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_ENTRADA_ALQUILER_POSICIONES (table: GR05_MOV_ENTRADA)
ALTER TABLE GR05_MOV_ENTRADA ADD CONSTRAINT FK_GR05_MOV_ENTRADA_ALQUILER_POSICIONES
    FOREIGN KEY (id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila)
    REFERENCES GR05_ALQUILER_POSICIONES (id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_ENTRADA_PALLET (table: GR05_MOV_ENTRADA)
ALTER TABLE GR05_MOV_ENTRADA ADD CONSTRAINT FK_GR05_MOV_ENTRADA_PALLET
    FOREIGN KEY (cod_pallet)
    REFERENCES GR05_PALLET (cod_pallet)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_INTERNO_MOVIMIENTO (table: GR05_MOV_INTERNO)
ALTER TABLE GR05_MOV_INTERNO ADD CONSTRAINT FK_GR05_MOV_INTERNO_MOVIMIENTO
    FOREIGN KEY (id_movimiento)
    REFERENCES GR05_MOVIMIENTO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_INTERNO_MOV_ENTRADA (table: GR05_MOV_INTERNO)
ALTER TABLE GR05_MOV_INTERNO ADD CONSTRAINT FK_GR05_MOV_INTERNO_MOV_ENTRADA
    FOREIGN KEY (id_movimiento_entrada)
    REFERENCES GR05_MOV_ENTRADA (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_INTERNO_POSICION (table: GR05_MOV_INTERNO)
ALTER TABLE GR05_MOV_INTERNO ADD CONSTRAINT FK_GR05_MOV_INTERNO_POSICION
    FOREIGN KEY (pos_global, nro_posicion, nro_estanteria, nro_fila)
    REFERENCES GR05_POSICION (pos_global, nro_posicion, nro_estanteria, nro_fila)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_SALIDA_MOVIMIENTO (table: GR05_MOV_SALIDA)
ALTER TABLE GR05_MOV_SALIDA ADD CONSTRAINT FK_GR05_MOV_SALIDA_MOVIMIENTO
    FOREIGN KEY (id_movimiento)
    REFERENCES GR05_MOVIMIENTO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_MOV_SALIDA_MOV_ENTRADA (table: GR05_MOV_SALIDA)
ALTER TABLE GR05_MOV_SALIDA ADD CONSTRAINT FK_GR05_MOV_SALIDA_MOV_ENTRADA
    FOREIGN KEY (id_movimiento_entrada)
    REFERENCES GR05_MOV_ENTRADA (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR05_POSICION_FILA (table: GR05_POSICION)
ALTER TABLE GR05_POSICION ADD CONSTRAINT FK_GR05_POSICION_FILA
    FOREIGN KEY (nro_estanteria, nro_fila)
    REFERENCES GR05_FILA (nro_estanteria, nro_fila)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_MOV_ENTRADA_MOVIMIENTO (table: GR05_MOV_ENTRADA)
ALTER TABLE GR05_MOV_ENTRADA ADD CONSTRAINT FK_MOV_ENTRADA_MOVIMIENTO
    FOREIGN KEY (id_movimiento)
    REFERENCES GR05_MOVIMIENTO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
-- End of file of creation.
-- Start inputs


