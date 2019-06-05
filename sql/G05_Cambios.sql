--Practico especial

--B)a.
Alter table Gr05_Alquiler
ADD CONSTRAINT UQ_GR05_alquiler_fecha_valida
CHECK (fecha_desde < fecha_hasta);
--b.
--rise exception y se puede usar else
CREATE TRIGGER TR_GR05_peso_valido
	AFTER INSERT ON gr05_mov_entrada
	FOR EACH ROW
	EXECUTE PROCEDURE funcion_comprobar_peso();

CREATE FUNCTION FN_GR05_funcion_comprobar_peso()
RETURNS trigger AS $body$
BEGIN
	if TG_OP = 'INSERT' THEN
		if (EXISTS(select 1
				from gr05_fila f inner join gr05_posicion p on f.nro_estanteria=p.nro_estanteria and f.nro_fila = p.nro_fila
							inner join gr05_alquier_posiciones ap on ap.nro_estanteria=p.nro_estanteria and ap.nro_fila = p.nro_fila
							inner join gr05_mov_entrada me on ap.nro_estanteria=me.nro_estanteria and ap.nro_fila = me.nro_fila
							inner join gr05_pallet p on me.cod_pallet=p.cod_pallet
				where new.nro_estanteria AND new.nro_fila
				group by me.nro_fila, me.nro_estanteria
				HAVING SUM(f.peso)< (SELECT peso
									FROM pallet p
									where cod_pallet=new.cod.pallet)
				)) THEN
			RAISE exception  'el peso maximo es superado';
		END IF;
	END IF;
END;
$body$
LANGUAGE 'plpgsql';
--drops
DROP FUNCTION FN_GR05_funcion_comprobar_peso()
DROP TRIGGER TR_GR05_peso_valido on gr05_mov_entrada

--c
ALTER TABLE gr_05posicion
ADD CONSTRAINT UQ_GR05_posicion_tipo_posicion_valida
CHECK (tipo like 'general' or tipo like 'vidrio' or tipo like 'insecticidas' or tipo like 'inflamable')
--C)

--1
Create FUNCTION FN_GR05_pos_libres (fechaingresada date)
RETURNS table (nro_estanteria int, nro_fila int, nro_posicion int) AS $$
BEGIN
	RETURN QUERY
		SELECT  p.nro_estanteria, p.nro_fila, p.nro_posicion
		FROM gr05_posicion p full join gr05_alquiler_posiciones g05ap on p.pos_global = g05ap.pos_global and p.nro_posicion = g05ap.nro_posicion and p.nro_estanteria = g05ap.nro_estanteria and p.nro_fila = g05ap.nro_fila
		full join gr05_alquiler g05a on g05ap.id_alquiler = g05a.id_alquiler
		WHERE g05a = fechaingresada and g05ap.id_alquiler is null;
END; $$
LANGUAGE plpgsql;

--2
Create FUNCTION FN_GR05_vencimiento_alquiler (dias_ingresados int)
RETURNS table (id_cliente int, dias_restantes int) AS $$
BEGIN
	RETURN QUERY
		SELECT id_cliente, fecha_hasta - current_date
		FROM gr05_cliente join gr05_alquiler g05a on gr05_cliente.cuit_cuil = g05a.id_cliente
		WHERE fecha_hasta - current_date = dias_ingresados;
END; $$
LANGUAGE plpgsql;
--D)
--1
Create VIEW GR05_pos_libres AS
	Select p.nro_posicion, case when ap.id_alquiler is not null then  (ap.nro_fila, ap.nro_estanteria,(SELECT fecha_hasta-current_date
                                                                       FROM gr05_alquiler a1 JOIN gr05_alquiler_posiciones ap1 ON a1.id_alquiler = ap1.id_alquiler
                                                                       WHERE ap1.estado = true AND a.id_alquiler = a1.id_alquiler) )END
	FROM gr05_posicion p FULL JOIN gr05_alquiler_posiciones ap
	ON p.nro_posicion = ap.nro_posicion and p.nro_estanteria = ap.nro_estanteria and p.nro_fila = ap.nro_fila
	full join gr05_alquiler a on a.id_alquiler = ap.id_alquiler;
--2
Create VIEW GR05_dinero_invertido AS
	select a.id_cliente, SUM(importe_dia*(fecha_hasta-fecha_desde))
	from gr05_cliente c inner join gr05_alquiler a on c.cuit_cuil=a.id_cliente
	where  EXTRACT(YEAR FROM CAST(current_date AS date))-1< EXTRACT(YEAR FROM a.fecha_desde) AND  EXTRACT(YEAR FROM CAST(current_date as date))> EXTRACT(YEAR FROM a.fecha_desde)
	group by a.id_cliente
	order by 2 desc
	limit 10
--E)
--
Create FUNCTION FN_GR05_pos_libres_fecha (fecha date)
RETURNS table (nro_posicion int) AS $$
BEGIN
	RETURN QUERY
		SELECT p.nro_posicion
		FROM gr05_posicion p full join gr05_alquiler_posiciones g05ap on p.pos_global = g05ap.pos_global and p.nro_posicion = g05ap.nro_posicion and p.nro_estanteria = g05ap.nro_estanteria and p.nro_fila = g05ap.nro_fila
		full join gr05_alquiler g05a on g05ap.id_alquiler = g05a.id_alquiler
		WHERE ((fecha > g05a.fecha_hasta) or (g05ap.id_alquiler is null)) and p.nro_posicion is not null;
END; $$
LANGUAGE plpgsql;

SELECT *
FROM FN_GR05_pos_libres_fecha(ACA VA DATE$$$$)

Create FUNCTION FN_GR05_pos_ocupadas_cliente (cliente_ingresado int)
RETURNS table (nro_posicion int) AS $$
BEGIN
	RETURN QUERY
		SELECT p.nro_posicion
		FROM gr05_posicion p INNER join gr05_alquiler_posiciones g05ap on p.pos_global = g05ap.pos_global and p.nro_posicion = g05ap.nro_posicion and p.nro_estanteria = g05ap.nro_estanteria and p.nro_fila = g05ap.nro_fila
		INNER join gr05_alquiler g05a on g05ap.id_alquiler = g05a.id_alquiler
		WHERE ((current_date > g05a.fecha_hasta) or (g05ap.id_alquiler is null)) and g05a.id_cliente=cliente_ingresado;
END; $$
LANGUAGE plpgsql;

SELECT *
FROM FN_GR05_pos_ocupadas_cliente(ACA VA INT$$$$id_cliente)