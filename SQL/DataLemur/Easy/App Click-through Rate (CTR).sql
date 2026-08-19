"""
App Click-through Rate (CTR)
Facebook SQL Interview Question
Question
Solution
Discussion
Submissions
This is the same question as problem #1 in the SQL Chapter of Ace the Data Science Interview!

Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

Definition and note:

Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
To avoid integer division, multiply the CTR by 100.0, not 100.
events Table:
Column Name	Type
app_id	integer
event_type	string
timestamp	datetime
events Example Input:
app_id	event_type	timestamp
123	impression	07/18/2022 11:36:12
123	impression	07/18/2022 11:37:12
123	click	07/18/2022 11:37:42
234	impression	07/18/2022 14:15:12
234	click	07/18/2022 14:16:12
Example Output:
app_id	ctr
123	50.00
234	100.00
Explanation
Let's consider an example of App 123. This app has a click-through rate (CTR) of 50.00% because out of the 2 impressions it received, it got 1 click.

To calculate the CTR, we divide the number of clicks by the number of impressions, and then multiply the result by 100.0 to express it as a percentage. In this case, 1 divided by 2 equals 0.5, and when multiplied by 100.0, it becomes 50.00%. So, the CTR of App 123 is 50.00%.

The dataset you are querying against may have different input & output - this is just an example!
"""
WITH IMP AS (
SELECT APP_ID, COUNT(*) AS ICT FROM EVENTS 
WHERE EVENT_TYPE='impression' AND EXTRACT(YEAR FROM TIMESTAMP)='2022'
GROUP BY 1),
CL as (
SELECT APP_ID, COUNT(*) AS CLCT FROM EVENTS 
WHERE EVENT_TYPE='click' AND EXTRACT(YEAR FROM TIMESTAMP)='2022'
GROUP BY 1)

SELECT DISTINCT e1.app_id ,ROUND(100.00* CL.CLCT/IMP.ICT , 2) AS ctr
FROM events as E1
LEFT JOIN IMP ON E1.APP_ID=IMP.APP_ID
LEFT JOIN CL ON E1.APP_ID=CL.APP_ID
ORDER BY 2,1;