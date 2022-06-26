/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

letras = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letra:chararray,
                letras2:BAG{t: TUPLE(p:chararray)},
                caracteres: map []
        );

l1 = FOREACH letras GENERATE FLATTEN(letras2) AS letras, FLATTEN(caracteres) AS caracteres;
l2 = FOREACH l1 GENERATE letras, (chararray)caracteres AS caracteres;
l3 = FOREACH l2 GENERATE TOTUPLE(letras, caracteres) AS grupo;
l4 = GROUP l3 BY grupo;
l5 = FOREACH l4 GENERATE group, COUNT(l3);

--DUMP l5;

STORE l5 INTO 'output/' USING PigStorage(',');