/*
Pregunta
===========================================================================

El archivo `data.csv` tiene la siguiente estructura:

  driverId       INT
  truckId        INT
  eventTime      STRING
  eventType      STRING
  longitude      DOUBLE
  latitude       DOUBLE
  eventKey       STRING
  correlationId  STRING
  driverName     STRING
  routeId        BIGINT
  routeName      STRING
  eventDate      STRING

Escriba un script en Pig que carge los datos y obtenga los primeros 10 
registros del archivo para las primeras tres columnas, y luego, ordenados 
por driverId, truckId, y eventTime. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<<
*/
drivers = LOAD 'data.csv' USING PigStorage(',')
        AS (
                driverId:int,
                truckId:int,
                eventTime:chararray,
                eventType:chararray,
                longitude:float,
                latitude:float,
                eventKey:chararray,
                correlationId:chararray,
                driverName:chararray,
                routeId:int,
                routeName:chararray,
                eventDate:chararray
        );

drivers_l = FOREACH drivers GENERATE driverId, truckId, eventTime;

drivers_l2 = LIMIT drivers_l 10;

drivers_l2_ordered = ORDER drivers_l2 by driverId, truckId, eventTime;

--DUMP drivers_l2_ordered;

STORE drivers_l2_ordered INTO 'output/' USING PigStorage(',');
