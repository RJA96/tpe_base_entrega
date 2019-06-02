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
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (1, 'ultricies');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (2, 'fusce');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (3, 'praesent');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (4, 'sagittis');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (5, 'turpis');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (6, 'elit');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (7, 'et');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (8, 'potenti');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (9, 'eu');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (10, 'sapien');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (11, 'interdum');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (12, 'tortor');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (13, 'rhoncus');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (14, 'integer');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (15, 'suspendisse');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (16, 'lacus');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (17, 'est');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (18, 'nullam');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (19, 'donec');
insert into gr05_estanteria (nro_estanteria, nombre_estanteria) values (20, 'aliquam');

--fila
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (20,1,'Malik',81);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (19,2,'Hop',89);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (8,3,'Alexander',66);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (17,4,'Dorian',76);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (15,5,'Byron',82);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (20,6,'Kasimir',88);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (16,7,'Valentine',77);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (18,8,'Gil',73);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (19,9,'Abel',63);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (2,10,'Ashton',97);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (3,11,'Alexander',50);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (4,12,'Cyrus',80);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (20,13,'Evan',61);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (3,14,'Amos',99);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (15,15,'Yoshio',79);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (19,16,'James',55);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (1,17,'Matthew',93);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (15,18,'Quinlan',51);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (17,19,'Valentine',93);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (9,20,'Thane',51);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (17,21,'Austin',58);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (15,22,'Xavier',58);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (2,23,'Hector',83);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (12,24,'Gannon',91);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (5,25,'Lucas',81);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (7,26,'Brendan',68);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (7,27,'Price',84);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (8,28,'Kasimir',61);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (14,29,'Ralph',80);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (16,30,'Francis',86);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (12,31,'Octavius',87);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (10,32,'Boris',64);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (2,33,'Thomas',63);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (12,34,'Dorian',97);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (4,35,'Ali',65);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (4,36,'Fuller',89);
INSERT INTO gr05_fila (nro_estanteria,nro_fila,nombre_fila,peso_max_kg) VALUES (13,37,'Ralph',66);

--posicion
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (1,20,1,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (2,19,2,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (3,19,2,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (4,8,3,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (5,8,3,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (6,17,4,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (7,17,4,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (8,15,5,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (9,15,5,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (10,20,6,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (11,20,6,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (12,16,7,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (13,16,7,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (14,18,8,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (15,18,8,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (16,18,8,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (17,19,9,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (18,19,9,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (19,19,9,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (20,2,10,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (21,2,10,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (22,2,10,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (23,13,37,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (24,13,37,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (25,13,37,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (26,4,36,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (27,4,36,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (28,4,36,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (29,14,29,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (30,14,29,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (31,7,26,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (32,7,26,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (33,5,25,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (34,5,25,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (35,5,25,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (36,19,16,'general');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (37,19,16,'inflamable');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (38,19,16,'vidrio');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (39,19,16,'insecticidas');
INSERT INTO gr05_posicion (nro_posicion,nro_estanteria,nro_fila,tipo) VALUES (40,3,14,'general');

-- cliente
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3053319, 'Lambregts', 'Gaïa', '2018-12-13 17:58:35');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3685684, 'Crosby', 'Anaël', '2019-02-24 05:56:40');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3686927, 'Barter', 'Gwenaëlle', '2018-07-27 05:34:52');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3293944, 'Gherardesci', 'Anaïs', '2018-12-30 07:26:08');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3595727, 'Dyson', 'Tán', '2019-03-28 14:59:04');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3378595, 'Kolak', 'Josée', '2019-03-06 17:39:38');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3318484, 'Bridle', 'Léane', '2018-07-05 09:24:29');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3296751, 'Tennick', 'Annotés', '2018-12-04 10:39:09');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3734064, 'Roubottom', 'Noëlla', '2018-12-20 07:25:15');
INSERT INTO gr05_cliente (cuit_cuil, apellido, nombre, fecha_alta) values (3964621, 'Clayal', 'Märta', '2018-06-16 12:34:49');

--alquiler
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (14, 3053319, '2019-04-11 10:03:27', '2019-11-20 01:49:52', 30496);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (45, 3685684, '2018-08-10 07:59:30', '2019-11-24 02:41:47', 42972);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (44, 3293944, '2018-12-09 08:48:34', '2020-04-29 17:35:37', 67105);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (97, 3293944, '2018-06-29 05:13:40', '2019-11-10 19:18:35', 22310);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (67, 3595727, '2019-05-24 01:39:20', '2019-07-02 04:08:56', 19083);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (16, 3378595, '2018-09-14 10:36:25', '2019-11-14 02:39:02', 41545);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (90, 3318484, '2018-11-18 21:39:56', '2020-01-05 08:21:03', 29622);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (23, 3296751, '2019-03-18 09:30:34', '2020-03-08 17:26:44', 21024);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (61, 3734064, '2018-07-23 19:20:43', '2019-10-21 10:49:24', 93804);
INSERT INTO gr05_alquiler (id_alquiler, id_cliente, fecha_desde, fecha_hasta, importe_dia) values (53, 3964621, '2019-05-05 15:32:44', '2019-10-03 12:12:14', 46447);

--alquileres posiciones
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (45, 1,20,1, true,6);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (14, 2,19,2, true,8);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (14, 3,19,2, false,9);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (44, 7,17,4, false,11);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (97, 22,2,10, false,26);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (67, 21,2,10, true,25);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (16, 26,4,36, false,30);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (90, 36,19,16, true,40);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (23, 38,19,16, true,42);
INSERT INTO gr05_alquiler_posiciones (id_alquiler, nro_posicion, nro_estanteria, nro_fila, estado,pos_global) values (61, 40,3,14, false,44);

--pallet
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values ( 1, 'Essential fatty acid [EFA] deficiency', 5);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (7, 'Laceration of musc/tend at lower leg level, left leg, subs', 10);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (19, 'Sudden visual loss', 28);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (13, 'Loose body in wrist', 25);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (2, 'Unspecified superficial injury of left ear, subs encntr', 40);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (7, 'Agenesis, aplasia and hypoplasia of pancreas', 50, true);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (19, 'Oth nondisp fx of upr end l humer, subs for fx w routn heal', 42;
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (6, 'Unsp injury of adductor musc/fasc/tend unsp thigh', 39);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (20, 'Sltr-haris Type I physeal fx lower end of unsp femur, init', 21);
INSERT INTO gr05_pallet(cod_pallet, descripcion, peso) values (15, 'Diabetes with prolif diabetic rtnop with trctn dtch n-mcla', 20);

