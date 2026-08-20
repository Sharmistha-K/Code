"""
Tweets' Rolling Averages
Twitter SQL Interview Question
Question
Solution
Discussion
Submissions
This is the same question as problem #10 in the SQL Chapter of Ace the Data Science Interview!

Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

Notes:

A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
In this case, we want to determine how the tweet count for each user changes over a 3-day period.
Effective April 7th, 2023, the problem statement, solution and hints for this question have been revised.

tweets Table:
Column Name	Type
user_id	integer
tweet_date	timestamp
tweet_count	integer
tweets Example Input:
user_id	tweet_date	tweet_count
111	06/01/2022 00:00:00	2
111	06/02/2022 00:00:00	1
111	06/03/2022 00:00:00	3
111	06/04/2022 00:00:00	4
111	06/05/2022 00:00:00	5
Example Output:
user_id	tweet_date	rolling_avg_3d
111	06/01/2022 00:00:00	2.00
111	06/02/2022 00:00:00	1.50
111	06/03/2022 00:00:00	2.00
111	06/04/2022 00:00:00	2.67
111	06/05/2022 00:00:00	4.00
The dataset you are querying against may have different input & output - this is just an example!

Hint #1

Hey there, don't let big words like "rolling averages" intimidate you!

Let's break this question down into bite-sized chunks: First, we want to obtain the average rolling average tweet count for each user. Can you think of a way to whip up that query?

SELECT 
  user_id,
  tweet_date,
  [Rolling average tweet count for each user]
FROM tweets;
Hint #2

Is your code shaping up to look something like this? Just fill in the blanks with the appropriate fields.

SELECT
  user_id,
  tweet_date,
  AVG(tweet_count) OVER (
    PARTITION BY _____
    ORDER BY _____) AS rolling_avg
FROM tweets;
Hint #3

You're getting there, but not quite nailing it yet.

To calculate the rolling averages over a 3-day period, we need to add a nifty expression called ROWS BETWEEN 2 PRECEDING AND CURRENT ROW to the window function.

SELECT    
  user_id,    
  tweet_date,
  tweet_count,
  AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM tweets;
Give it a spin and check out the difference between the results before and after adding the expression. You got this!
"""
SELECT    
  user_id,    
  tweet_date,
  -- tweet_count,
  ROUND(CAST(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)AS NUMERIC),2) AS rolling_avg_3d
FROM tweets
ORDER BY USER_ID,TWEET_DATE ;