Select L.Zone
FROM (
	Select Avg(temp.sum1) as mean, STDDEV(temp.sum1) as sd 
		From(select PULocationID, Sum(tripCount) as sum1 
			from nyctaxi.summaryIndex 
            Where part_of_day = 2 and dow = 2
            Group by PULocationID) as temp )as ASD,
	(select PULocationID, Sum(tripCount) as sum2 
	from nyctaxi.summaryIndex
    where part_of_day = 2 and dow = 2
	Group by PULocationID) as S1, nyctaxi.location L
WHERE S1.sum2>4* ASD.mean and L.LocationID = S1.PULocationID
Order by S1.sum2 desc; 

