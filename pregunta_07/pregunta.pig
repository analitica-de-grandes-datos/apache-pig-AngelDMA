/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

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

l2 = FOREACH letras GENERATE letra, SIZE(letras2) as letras2, SIZE(caracteres) as caracteres;
l3 = ORDER l2 BY letra, letras2, caracteres;

--DUMP l3;

STORE l3 INTO 'output/' USING PigStorage(',');