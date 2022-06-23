/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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

maps = FOREACH letras GENERATE FLATTEN(caracteres) AS CHAR;

maps2 = FOREACH maps GENERATE (chararray)CHAR as maps2;

maps3 = GROUP maps2 BY maps2;

maps4 = FOREACH maps3 GENERATE group, COUNT(maps2);

DUMP maps4;