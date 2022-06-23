/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT
       firstname,
       color
   FROM 
       u 
   WHERE 
      color REGEXP '^[^b]';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
p = LOAD 'data.csv' USING PigStorage(',')
        AS (
                numero:int,
                nombre:chararray,
                apellido:chararray,
                fecha:chararray,
                color:chararray,
                numero2:chararray
        );

p1 = FOREACH p GENERATE nombre,color;
p2 = FILTER p1 BY NOT(color matches 'b.*');

DUMP p2;

--STORE p2 INTO 'output/' USING PigStorage(',');

