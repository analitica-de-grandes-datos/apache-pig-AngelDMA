/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname, 
       LOCATE('ia', firstname) 
   FROM 
       u;

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

p1 = FOREACH p GENERATE INDEXOF(nombre, 'ia',0);

--DUMP p1;

STORE p1 INTO 'output/' USING PigStorage(',');