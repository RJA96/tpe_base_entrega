--Practico especial

--B)a.
Alter table Gr05_Alquiler
ADD CONSTRAINT fecha_valida
CHECK (fecha_desde < fecha_hasta);
--b.
--rise exception y se puede usar else
CREATE TRIGGER peso_valido
	AFTER INSERT ON gr05_pallet
	FOR EACH ROW
	EXECUTE PROCEDURE funcion_comprobar_peso();

CREATE FUNCTION funcion_comprobar_peso()
RETURNS trigger AS $body$
BEGIN
	if TG_OP = 'INSERT' THEN
		if (EXISTS(select 1
				from gr05_fila f inner join gr05_posicion p on f.nro_estanteria=p.nro_estanteria and f.nro_fila = p.nro_fila
							inner join gr05_alquier_posiciones ap on ap.nro_estanteria=p.nro_estanteria and ap.nro_fila = p.nro_fila
							inner join gr05_mov_entrada me on ap.nro_estanteria=me.nro_estanteria and ap.nro_fila = me.nro_fila
							inner join gr05_pallet p on me.cod_pallet=p.cod_pallet
				where f.nro_estanteria = (select me.nro_estanteria
											from gr05_mov_entrada me
											where me.cod_pallet= new.cod_pallet)
				AND f.nro_fila=(select me.nro_fila
									from gr_05mov_entrada me
									where me.cod_pallet= new.cod_pallet)
				group by f.nro_fila, f.nro_estanteria
				HAVING SUM(p.peso)< new.peso
				)) THEN
			RAISE exception  'el peso maximo es superado';
		END IF;
	END IF;
END;
$body$
LANGUAGE 'plpgsql';
--drops
DROP FUNCTION funcion_comprobar_peso();
DROP TRIGGER peso_valido on pallet

--c
ALTER TABLE posicion
ADD CONSTRAINT tipo_posicion_valida
CHECK (tipo like 'general' or tipo like 'vidrio' or tipo like 'insecticidas' or tipo like 'inflamable')
--C)

--1
Create FUNCTION pos_libres (fechaingresada date)
RETURNS table (nro_estanteria int, nro_fila int, nro_posicion int) AS $$body
declare var_r record;
BEGIN
	for var_r IN(
		Select p.nro_estanteria, p.nro_fila, p.nro_posicion
		from gr05_posicion p full join gr05_alquiler_posiciones ap on p.nro_estanteria = ap.nro_estanteria and p.nro_fila = ap.nro_fila
		full join  gr05_alquiler a on a.id_alquiler=ap.id_alquiler
		where fechaingresada >= a.fecha_hasta and ap.estado = false or ap.id_alquiler is null
	)
	LOOP
		nro_estanteria := var_r.nro_estanteria;
		nro_fila := var_r.nro_fila;
		nro_posicion := var_r.nro_posicion; 
	    RETURN Next;
	END LOOP;
END; $$body
	LANGUAGE plpgsql;

--2
Create FUNCTION traer_clientes(dia int)
RETURNS table (id_cliente int, dia_vencimiento date) AS $$
declare var_r record
BEGIN
	for var_r IN(
		Select id_cliente, fecha_hasta
		from alquiler
		where todate()fecha_hasta
	)


--D)
--1
Create VIEW pos_libres AS
	Select p.nro_posicion, case ap.estado when true then 'ocupado' when false then 'libre' when  null then 'libre'END,
       CASE ap.estado when true then ap.nro_fila END,  CASE ap.estado when true then ap.nro_estanteria END
	FROM gr05_posicion p FULL JOIN gr05_alquiler_posiciones ap
	ON p.nro_posicion = ap.nro_posicion and p.nro_estanteria = ap.nro_estanteria and p.nro_fila = ap.nro_fila
	inner join gr05_alquiler a on a.id_alquiler = ap.id_alquiler
--2
Create VIEW dinero_invertido AS
	select a.id_cliente, SUM(importe_dia)
	from cliente c inner join alquiler a on c.cuit_cuil=a.id_cliente
	where (year(getdate()) -1)<a.fecha_desde AND (year(getdate()))>a.fecha_desde
	group by a.id_cliente, importe_dia
	order by 2 asc
	limit 10