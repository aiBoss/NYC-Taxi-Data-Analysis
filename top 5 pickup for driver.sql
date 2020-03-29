SELECT L.Zone
from (
	SELECT PULocationID, sum(tripCount) as su 
		from nyctaxi.summaryIndex 
		 where dow = 4 and DOLocationID = 4 AND part_of_day = 2 
        Group by PULocationID) as temp1, nyctaxi.location L
        where temp1.PULocationID = L.LocationID
order by su desc LIMIT 5;


