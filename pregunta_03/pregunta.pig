/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letra:chararray,
                fecha:chararray,
                cantidad:int
        );

cantidad_ordenada = ORDER lines BY cantidad ASC;

cantidad_top_5 = LIMIT cantidad_ordenada 5;

solo_cantidad = FOREACH cantidad_top_5  GENERATE cantidad;

STORE solo_cantidad INTO 'output/' USING PigStorage(',');
