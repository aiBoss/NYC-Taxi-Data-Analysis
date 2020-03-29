import pandas as pd
import numpy as np

 

path ="//Users//mkr4014//Desktop//DB Project//yellow_tripdata_2019-01.csv"
df = pd.read_csv(path)

#Delete if only one distance or fare is zero 
df=df.drop(df[((df.trip_distance==0 )&( df.fare_amount!=0))|((df.trip_distance!=0) & (df.fare_amount==0))].index)

#Remove Negatives
df[['fare_amount','extra', 'mta_tax','tip_amount','tolls_amount','improvement_surcharge','total_amount']]=df[['fare_amount','extra', 'mta_tax','tip_amount','tolls_amount','improvement_surcharge','total_amount']].abs()

#Convert to datetime format
df['tpep_pickup_datetime']=pd.to_datetime(df['tpep_pickup_datetime'])
df['tpep_dropoff_datetime']=pd.to_datetime(df['tpep_dropoff_datetime'])

#Delete if the trip is not within the timeline of Analysis and separate dates and times
df = df.drop(df[(((df.tpep_pickup_datetime <pd.to_datetime('01/01/19 00:00:00')) & (df.tpep_dropoff_datetime <pd.to_datetime('01/01/19 00:00:00'))) |(df.tpep_pickup_datetime >pd.to_datetime('01/31/19 23:59:59')))].index)
df=df.drop(df[(df.tpep_pickup_datetime >= df.tpep_dropoff_datetime)].index)
df['tpep_pickup_new_date']=[d.date() for d in df['tpep_pickup_datetime']]
df['tpep_pickup_new_time']=[d.time() for d in df['tpep_pickup_datetime']]
df['tpep_dropoff_new_date']=[d.date() for d in df['tpep_dropoff_datetime']]
df['tpep_dropoff_new_time']=[d.time() for d in df['tpep_dropoff_datetime']]

ind=df['tpep_pickup_datetime']
df=df.set_index(ind)

#Assign part of day category based on trip time
df['part_of_day']=np.where((df['tpep_pickup_new_time']>=pd.to_datetime('06:00:00').time() )& (df['tpep_pickup_new_time']<pd.to_datetime('10:00:00').time()), 1,\
                           np.where((df['tpep_pickup_new_time']>=pd.to_datetime('16:00:00').time() )& (df['tpep_pickup_new_time']<pd.to_datetime('20:00:00').time()),2,\
                                    np.where((df['tpep_pickup_new_time']>=pd.to_datetime('10:00:00').time() )& (df['tpep_pickup_new_time']<pd.to_datetime('16:00:00').time()),3,\
                                             np.where((df['tpep_pickup_new_time']>=pd.to_datetime('20:00:00').time() )& (df['tpep_pickup_new_time']<pd.to_datetime('23:59:00').time()),4,5))))

#Drop irrelevant columns
df = df.drop(columns = ['tpep_pickup_datetime','tpep_dropoff_datetime','congestion_surcharge'])

df.to_csv(r'//Users//mkr4014//Desktop//DB Project//Clean2.csv', index=False)
