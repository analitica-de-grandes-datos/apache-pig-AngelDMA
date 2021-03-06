/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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

p0 = FOREACH p GENERATE ToDate(fecha, 'yyyy-MM-dd') as fecha, fecha as fecha1;

p1 = FOREACH p0 GENERATE fecha1,
        REGEX_EXTRACT(fecha1,'.*-([0-9][0-9])',1),
        (int)REGEX_EXTRACT(fecha1,'.*-([0-9][0-9])',1),
        (CASE ToString(fecha,'EEE')
                WHEN 'Mon' THEN 'lun'
                WHEN 'Tue' THEN 'mar'
                WHEN 'Wed' THEN 'mie'
                WHEN 'Thu' THEN 'jue'
                WHEN 'Fri' THEN 'vie'
                WHEN 'Sat' THEN 'sab'
                WHEN 'Sun' THEN 'dom'
        END
        ),
        (CASE ToString(fecha,'EEE')
                WHEN 'Mon' THEN 'lunes'
                WHEN 'Tue' THEN 'martes'
                WHEN 'Wed' THEN 'miercoles'
                WHEN 'Thu' THEN 'jueves'
                WHEN 'Fri' THEN 'viernes'
                WHEN 'Sat' THEN 'sabado'
                WHEN 'Sun' THEN 'domingo'
        END
        );

--DUMP p1;

STORE p1 INTO 'output/' USING PigStorage(',');

