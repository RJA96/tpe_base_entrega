SELECT *
FROM FN_GR05_pos_ocupadas_cliente(ACA VA INT$$$$id_cliente)


SELECT *
FROM FN_GR05_pos_libres_fecha(ACA VA DATE$$$$)

DROP FUNCTION FN_GR05_funcion_comprobar_peso()
DROP TRIGGER TR_GR05_peso_valido on gr05_mov_entrada

