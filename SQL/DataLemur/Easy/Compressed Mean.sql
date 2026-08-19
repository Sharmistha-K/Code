"""
Compressed Mean
Alibaba SQL Interview Question
Question
Solution
Discussion
Submissions
You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information on the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).

items_per_order Table:
Column Name	Type
item_count	integer
order_occurrences	integer
items_per_order Example Input:
item_count	order_occurrences
1	500
2	1000
3	800
4	1000
There are a total of 500 orders with one item per order, 1000 orders with two items per order, and 800 orders with three items per order."

Example Output:
mean
2.7
Explanation
Let's calculate the arithmetic average:

Total items = (1*500) + (2*1000) + (3*800) + (4*1000) = 8900

Total orders = 500 + 1000 + 800 + 1000 = 3300

Mean = 8900 / 3300 = 2.7

The dataset you are querying against may have different input & output - this is just an example!
"""
-- This PostgreSQL error occurs because the built-in ROUND() function does not support rounding a double precision (floating-point) value to a specific number of decimal places.  While MySQL allows this implicitly, PostgreSQL requires the first argument to be of type numeric (fixed-point) when a second integer argument for precision is provided. 

--To fix this, you must explicitly cast the value to numeric before applying the function:


SELECT 
ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) AS NUMERIC), 1) AS MEAN
FROM items_per_order;