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
--Estanteria
INSERT INTO unc_248381.gr05_estanteria (nro_estanteria, nombre_estanteria) VALUES (1, 'Estanteria 1');
INSERT INTO unc_248381.gr05_estanteria (nro_estanteria, nombre_estanteria) VALUES (2, 'Estanteria 2');
INSERT INTO unc_248381.gr05_estanteria (nro_estanteria, nombre_estanteria) VALUES (3, 'Estanteria 3');
INSERT INTO unc_248381.gr05_estanteria (nro_estanteria, nombre_estanteria) VALUES (4, 'Estanteria 4');
INSERT INTO unc_248381.gr05_estanteria (nro_estanteria, nombre_estanteria) VALUES (5, 'Estanteria 5');


--fila
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (1, 1, 'Fila 1', 10000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (1, 2, 'Fila 2', 15000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (1, 3, 'Fila 3', 17000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (2, 3, 'Fila 3', 20000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (2, 2, 'Fila 2', 20000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (2, 1, 'Fila 1', 20000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (3, 1, 'Fila 1', 22000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (3, 2, 'Fila 2', 22000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (3, 3, 'Fila 3', 22000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (4, 1, 'Fila 1', 25000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (4, 2, 'Fila 2', 25000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (4, 3, 'Fila 3', 25000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (5, 1, 'Fila 1', 21000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (5, 2, 'Fila 2', 21000.00);
INSERT INTO unc_248381.gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (5, 3, 'Fila 3', 21000.00);
--posicion
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (1, 2, 1, 'inflamable');
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (2, 1, 3, 'vidrio');
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (1, 1, 3, 'insecticidas');
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (2, 1, 2, 'general');
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (1, 1, 2, 'general');
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (2, 1, 1, 'vidrio');
INSERT INTO unc_248381.gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (1, 1, 1, 'insecticidas');
-- cliente
INSERT INTO unc_248381.gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) VALUES (1, 'Lambregts', 'Gaïa', '2019-06-01');
INSERT INTO unc_248381.gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) VALUES (2, 'Crosby', 'Anaël', '2019-06-01');
INSERT INTO unc_248381.gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) VALUES (3, 'Barter', 'Gwenaëlle', '2019-06-05');
INSERT INTO unc_248381.gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) VALUES (4, 'Gherardesci', 'Anaïs', '2019-06-10');
INSERT INTO unc_248381.gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) VALUES (5, 'Dyson', 'Tán', '2019-07-10');
--alquiler
INSERT INTO unc_248381.gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) VALUES (1, 1, '2019-06-01', '2019-06-08', 100.00);
INSERT INTO unc_248381.gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) VALUES (2, 2, '2019-07-01', '2019-07-08', 100.00);
INSERT INTO unc_248381.gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) VALUES (3, 2, '2019-06-02', '2019-07-01', 500.00);
INSERT INTO unc_248381.gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) VALUES (4, 1, '2019-06-01', '2019-07-05', 300.00);
INSERT INTO unc_248381.gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) VALUES (5, 4, '2020-01-01', '2020-01-21', 250.00);
--alquileres posiciones
INSERT INTO unc_248381.gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, pos_global, estado) VALUES (1, 1, 2, 1,1, true);
INSERT INTO unc_248381.gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, pos_global, estado) VALUES (2, 2, 1, 3,2, true);
INSERT INTO unc_248381.gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, pos_global, estado) VALUES (3, 1, 1, 3,3, false);
INSERT INTO unc_248381.gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, pos_global, estado) VALUES (4, 2, 1, 2,4, false);
INSERT INTO unc_248381.gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, pos_global, estado) VALUES (5, 1, 1, 2,5, false);

--pallet
INSERT INTO unc_248381.gr05_pallet (cod_pallet, descripcion, peso) VALUES ('3', 'Zapatillas', 400.00);
INSERT INTO unc_248381.gr05_pallet (cod_pallet, descripcion, peso) VALUES ('2', 'Gaseosa', 750.00);
INSERT INTO unc_248381.gr05_pallet (cod_pallet, descripcion, peso) VALUES ('1', 'Yerba', 500.00);
INSERT INTO unc_248381.gr05_pallet (cod_pallet, descripcion, peso) VALUES ('5', 'Cigarrillos', 250.00);
INSERT INTO unc_248381.gr05_pallet (cod_pallet, descripcion, peso) VALUES ('4', 'Harina', 100.00);

--movimiento
INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (1, '2019-06-01', 'Taragui', 'E');
INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (2, '2019-06-01 19:09:24.28888', 'Marlboro', 'E');
INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (3, '2019-06-02 19:09:43.067518', 'Coca-Cola', 'E');
INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (4, '2019-06-03 19:09:43.067518', 'Pepsico', 'E');
INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (5, '2019-06-04 19:09:43.067518', 'Logstore', 'E');

--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (6, '2019-06-04 19:09:43.067518', 'Pureza', 'S');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (7, '2019-06-04 19:09:43.067518', 'Pureza', 'S');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (8, '2019-06-04 19:09:43.067518', 'Pureza', 'S');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (9, '2019-06-04 19:09:43.067518', 'Pureza', 'S');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (10, '2019-06-04 19:09:43.067518', 'Pureza', 'S');

--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (8, '2019-06-04 19:09:43.067518', 'Pureza', 'I');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (9, '2019-06-04 19:09:43.067518', 'Pureza', 'I');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (10, '2019-06-04 19:09:43.067518', 'Pureza', 'I');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (11, '2019-06-04 19:09:43.067518', 'Pureza', 'I');
--INSERT INTO unc_248381.gr05_movimiento (id_movimiento, fecha, responsable, tipo) VALUES (12, '2019-06-04 19:09:43.067518', 'Pureza', 'I');



-- Mov entrada
INSERT INTO unc_248381.gr05_mov_entrada (id_movimiento, transporte, guia, cod_pallet, id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila) VALUES (1, 'Camion', 'Torrans', 1, 1, 1, 1, 2,1);
INSERT INTO unc_248381.gr05_mov_entrada (id_movimiento, transporte, guia, cod_pallet, id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila) VALUES (2, 'Camion', 'Yantsev', 2, 2, 2, 2, 1, 3);
INSERT INTO unc_248381.gr05_mov_entrada (id_movimiento, transporte, guia, cod_pallet, id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila) VALUES (3, 'Camioneta', 'Walden', 3, 3, 3, 1, 1, 3);
INSERT INTO unc_248381.gr05_mov_entrada (id_movimiento, transporte, guia, cod_pallet, id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila) VALUES (4, 'Camioneta', 'Walden', 4, 4, 4, 2, 1,2);
INSERT INTO unc_248381.gr05_mov_entrada (id_movimiento, transporte, guia, cod_pallet, id_alquiler, pos_global, nro_posicion, nro_estanteria, nro_fila) VALUES (5, 'Camioneta', 'Walden', 5, 5, 5, 1, 1,2);

--Mov Salida
--insert into GR05_MOV_SALIDA (id_movimiento, transporte, guia,id_movimiento_entrada) values (1, '2019-01-15 03:28:54', 'Buddy Torrans', 24);


--mov_interno;
