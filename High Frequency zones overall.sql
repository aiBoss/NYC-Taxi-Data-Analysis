Select L.Zone
FROM (
	Select Avg(temp.sum1) as mean, STDDEV(temp.sum1) as sd
		From(select PULocationID, Sum(tripCount) as sum1 
			from nyctaxi.summary
            Group by PULocationID) as temp )as ASD,
	(select PULocationID, Sum(tripCount) as sum2 
	from nyctaxi.summary 
	Group by PULocationID) as S1, nyctaxi.location L
WHERE S1.sum2>4* ASD.mean And S1.PULocationID = L.LocationID
Order by S1.sum2 desc; 