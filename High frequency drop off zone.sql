Select S1.DOLocationID
FROM (Select Avg(temp.sum1) as mean, STDDEV(temp.sum1) as sd 
	From (select DOLocationID, Sum(passCount) as sum1 
		from nyctaxi.summary 
        Group by DOLocationID) as temp) as ASD, 
    (select DOLocationID, Sum(passCount) as sum2 
    from nyctaxi.summary 
    Group by DOLocationID) as S1
WHERE S1.sum2>4* ASD.mean
Order by S1.sum2; 