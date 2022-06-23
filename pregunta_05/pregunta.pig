/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
letras = LOAD 'data.tsv' USING PigStorage('\t')
        AS (
                letra:chararray,
                letras2:BAG{t: TUPLE(p:chararray)},
                caracteres:chararray
        );

letras_2 = FOREACH letras GENERATE FLATTEN(letras2) AS letra;
letras_3 = GROUP letras_2 BY letra;
letras_4 = FOREACH letras_3 GENERATE group, COUNT(letras_2);

--DUMP letras_4;
STORE letras_4 INTO 'output/' USING PigStorage(',');