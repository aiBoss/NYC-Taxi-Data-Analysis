Select L.Zone
FROM (Select Avg(temp.sum1) as mean, STDDEV(temp.sum1) as sd 
	From (select DOLocationID, Sum(passCount) as sum1 
		from nyctaxi.summaryIndex
        where dow = 5 and part_of_day = 3
        Group by DOLocationID) as temp) as ASD, 
    (select DOLocationID, Sum(passCount) as sum2 
    from nyctaxi.summaryIndex 
    where dow = 5 and part_of_day = 3
    Group by DOLocationID) as S1, nyctaxi.location L
WHERE S1.sum2>6* ASD.mean and S1.DOLocationID = L.LocationID
Order by S1.sum2 desc;

