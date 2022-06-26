/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

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

p0 = FOREACH p GENERATE GetYear(ToDate(fecha, 'yyyy-MM-dd')) as fecha;
p1 = GROUP p0 BY fecha;
p2 = FOREACH p1 GENERATE group, COUNT(p0);

--DUMP p2;

STORE p2 INTO 'output/' USING PigStorage(',');
