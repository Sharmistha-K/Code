"""
Sending vs. Opening Snaps
Snapchat SQL Interview Question
Question
Solution
Discussion
Submissions
This is the same question as problem #25 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.
Effective April 15th, 2023, the solution has been updated and optimised.

activities Table
Column Name	Type
activity_id	integer
user_id	integer
activity_type	string ('send', 'open', 'chat')
time_spent	float
activity_date	datetime
activities Example Input
activity_id	user_id	activity_type	time_spent	activity_date
7274	123	open	4.50	06/22/2022 12:00:00
2425	123	send	3.50	06/22/2022 12:00:00
1413	456	send	5.67	06/23/2022 12:00:00
1414	789	chat	11.00	06/25/2022 12:00:00
2536	456	open	3.00	06/25/2022 12:00:00
age_breakdown Table
Column Name	Type
user_id	integer
age_bucket	string ('21-25', '26-30', '31-25')
age_breakdown Example Input
user_id	age_bucket
123	31-35
456	26-30
789	21-25
Example Output
age_bucket	send_perc	open_perc
26-30	65.40	34.60
31-35	43.75	56.25
Explanation
Using the age bucket 26-30 as example, the time spent sending snaps was 5.67 and the time spent opening snaps was 3.

To calculate the percentage of time spent sending snaps, we divide the time spent sending snaps by the total time spent on sending and opening snaps, which is 5.67 + 3 = 8.67.

So, the percentage of time spent sending snaps is 5.67 / (5.67 + 3) = 65.4%, and the percentage of time spent opening snaps is 3 / (5.67 + 3) = 34.6%.

The dataset you are querying against may have different input & output - this is just an example!

user_id	age_bucket	activity_type	time_spent
789	21-25	chat	11.00
789	21-25	open	5.25
789	21-25	send	6.24
456	26-30	open	3.00
456	26-30	send	5.67
456	26-30	send	8.24
123	31-35	chat	3.15
123	31-35	open	1.25
123	31-35	open	4.50
123	31-35	send	3.50

"""

WITH ACT_OP AS(
SELECT A1.USER_ID,A1.AGE_BUCKET, SUM(A2.TIME_SPENT) AS TOP
FROM age_breakdown AS A1
LEFT JOIN ACTIVITIES AS A2 ON A1.USER_ID=A2.USER_ID AND A2.ACTIVITY_TYPE='open'
GROUP BY 1,2),

ACT_TP AS (
SELECT A1.USER_ID,A1.AGE_BUCKET, SUM(A2.TIME_SPENT) AS TSD
FROM age_breakdown AS A1
LEFT JOIN ACTIVITIES AS A2 ON A1.USER_ID=A2.USER_ID AND A2.ACTIVITY_TYPE='send'
GROUP BY 1,2)

SELECT A1.AGE_BUCKET,
ROUND(CAST(100.00*A2.TSD/(A2.TSD+A1.TOP)AS NUMERIC),2) AS SEND_PERC,
ROUND(CAST(100.00*A1.TOP/(A1.TOP+A2.TSD)AS NUMERIC),2) AS OPEN_PERC

FROM ACT_OP AS A1 
INNER JOIN ACT_TP AS A2 ON A1.USER_ID=A2.USER_ID

ORDER BY A1.AGE_BUCKET;