CREATE TABLE nyctaxi.summaryIndex as 
(Select dayofweek(tpep_pickup_new_date) as dow,
 PULocationID, DOLocationID, part_of_day, 
 count(*) as tripCount, sum(passenger_count) as passCount
from nyctaxi.jan_2019 GROUP By dow, PULocationID, DOLocationID, part_of_day);

CREATE INDEX podIndex using hash ON nyctaxi.summaryIndex(part_of_day);

CREATE INDEX dowIndex using hash ON nyctaxi.summaryIndex(dow);
 
CREATE INDEX DOLIndex using hash ON nyctaxi.summaryIndex(DOLocationID);

