--Total Revenue
--Average ticket price
--price summation for every station
--Number of tickets sold by ticket type
--Number of journy per day
--Delay Analysis: Number of delayed flights, average delay duration, and major causes of delay.
--Station analysis: departure and arrival
--top reason for delay
--cancellation rate
--Refund Request: rate/number
--On-time arrival accuracy rate
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Revenues
---------Total Revenue
select SUM(Price) from clean_railway

---------Average ticket price
select AVG(Price) from clean_railway


---------price summation for every station
select Departure_Station , SUM(price)
from clean_railway
group by Departure_Station


select Arrival_Destination , SUM(price) as sum_of_Arrival_Destination
from clean_railway
group by Arrival_Destination



---------Number of tickets sold by ticket type
------------Advance ticket
select COUNT(Ticket_Type) as num_of_Advance_ticket 
from clean_railway 
where Ticket_Type='Advance' 

select (COUNT(CASE WHEN Ticket_Type='Advance' THEN 1 END) * 100.0 / COUNT(*)) as num_of_Anytime_ticket 
from clean_railway 


------------Off-Peak ticket
select COUNT(Ticket_Type) as num_of_Off_Peak_ticket 
from clean_railway 
where Ticket_Type='Off-Peak' 

select (COUNT(CASE WHEN Ticket_Type='Off-Peak' THEN 1 END) * 100.0 / COUNT(*)) as perc_of_Anytime_ticket 
from clean_railway 
 
------------Anytime
select COUNT(Ticket_Type) as num_of_Off_Peak_ticket 
from clean_railway 
where Ticket_Type='Anytime' 

select (COUNT(CASE WHEN Ticket_Type='Anytime' THEN 1 END) * 100.0 / COUNT(*)) as perc_of_Anytime_ticket 
from clean_railway 

--Number of journy per day
select Date_of_Journey , count(Date_of_Journey) as num_of_journeies
from clean_railway
group by Date_of_Journey
order by num_of_journeies Desc


--Delay Analysis:
-------- Number of delayed journey
select COUNT(Journey_Status) as num_of_delayed_journey 
from clean_railway 
where Journey_Status='Delayed' 

select (COUNT(CASE WHEN Journey_Status='Delayed' THEN 1 END) * 100.0 / COUNT(*)) as perc_of_delayed_journey 
from clean_railway 

--------average delay duration
SELECT  AVG(DATEDIFF(MINUTE, Arrival_Time, Actual_Arrival_Time)) AS Avg_Arrival_Delay
FROM clean_railway
WHERE Journey_Status = 'Delayed';

SELECT Departure_Station, AVG(DATEDIFF(MINUTE, Arrival_Time, Actual_Arrival_Time)) AS Avg_Arrival_Delay
FROM clean_railway
WHERE Journey_Status = 'Delayed'
group by Departure_Station;

SELECT Departure_Station,Arrival_Destination, AVG(DATEDIFF(MINUTE, Arrival_Time, Actual_Arrival_Time)) AS Avg_Arrival_Delay
FROM clean_railway
WHERE Journey_Status = 'Delayed'
group by Departure_Station , Arrival_Destination 
order by Avg_Arrival_Delay DESC;


--Station analysis:
---------departure-------
SELECT top 5 Departure_Station, COUNT(Departure_Station) AS frequency
FROM clean_railway
GROUP BY Departure_Station
ORDER BY frequency DESC
;
---------arrival----------
SELECT top 5 Arrival_Destination, COUNT(Arrival_Destination) AS frequency
FROM clean_railway
GROUP BY Arrival_Destination
ORDER BY frequency DESC
;

--top reason for delay
select top 3 Reason_for_Delay ,COUNT(Reason_for_Delay) as frequency
from clean_railway
where Journey_Status='Delayed'
group by Reason_for_Delay
order by frequency DESC

---cancellation rate
select Departure_Station,Arrival_Destination, count(case when  Journey_Status='Cancelled' then 1 end)*100/count(*) as perc_of_canceletion
from clean_railway
group by Departure_Station,Arrival_Destination
order by perc_of_canceletion DESC
--Refund Request:
------number of Refund Request
select Refund_Request , COUNT(Refund_Request) as frequency
from clean_railway
group by Refund_Request

-------Refund_Request rate
select count(case when Refund_Request=1 then 1 end)*100/count(*) as Refund_Request_rate
from clean_railway

--On-time arrival accuracy rate
select COUNT(case when Journey_Status='On Time' then 1 end)*100/COUNT(*) as On_time_arrival_accuracy_rate
from clean_railway





