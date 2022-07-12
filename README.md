# Module_7_Challenge
Homework 6

In this homework assignment,  the task is to detect credit car frauds using the python and sql skills. The task is divided into two parts:

Part 1 :
Use SQL skills to analyze historical credit card transactions and consumption patterns in order to identify possible fraudulent transactions.
The task has 3 main tasks: Data modelling, Data Engineering and Data Analysis.
The Sql queries are attached as queries file in the github link and below are the some of analysis and answers:

-- Que. How can you isolate (or group) the transactions of each cardholder?
-- Ans. By creating view from tables card_holder and transaction and counting total no of transactions per cardholder

-- Que. Count the transactions that are less than $2.00 per cardholder.
-- Ans. Create a view by joining all the 5 tables and counting transactions less than $2

-- Que. Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

-- Ans. The above query from the view suggests that the transactions done at restaurant, bars and pubs might be fraudlent 
-- The transaction of $2 at a coffee shop might be not fraudlent as a cup of coffee would cost less than $2.

-- Que. What are the top 100 highest transactions made between 7:00 am and 9:00 am?
-- Ans. Create a view from the table transaction to list the top 100 transactions beween 7 am and 9 am

-- Que. Do you see any anomalous transactions that could be fraudulent?
-- Ans: The first 9 transactions seems to be fraudlent as the amount seems to be large and outliers when compared to the remaining smaller amounts.

-- Que. Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
-- Ans. There seems to be more fraudlent trnasaction in the rest of the day compared to the time frame between 7 and 9 am.

-- Que. If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
-- Ans. No

-- What are the top 5 merchants prone to being hacked using small transactions?
-- Ans: Please refer the results from query.

Part2:
Connect the postgres database to Jupyetr Notebook and query the database and generate visualizations that supply the requested information as follows. Use visualizations and observations to answer the below questions.
The Markdown report are attached as Module7_Visual&Challenge file in the github link.

-- Visual

-- Que.What difference do you observe between the consumption patterns? 
-- Ans. Cardholer 2 consumption pattern suggests that they consume small amounts on a regular basis, highest amount being $20
-- and lowest being less than $2. As the pattern seems very volatile, there is a possibility of regular frauds of smaller amounts.
-- However the Cardholder 18 consumption pattern is bit volatile as he spends higher amounts in the range of $500 - $2000 in
-- few instances but then spends very small amounts in the remaining time period.


-- Que.Does the difference suggest a fraudulent transaction? 
-- Ans. Yes Cardholder 18 transactions seems to be fraudlent as the transaction pattern is not consistent. It has lots of small
-- transactions (less than $2) with occasional higher purchases. Contrary to Cardholder 18, Cardholder 2 activities seems to be 
-- fraudlent too as they make smaller transactions on a regular basis.

-- Que.  Are there any outliers for cardholder ID 25? How many outliers are there per month?
-- Ans. Yes there are few outliers for Cardholder 25. There are 1 outlier in the month of Jnauary for $1177, 1 outlier in March for $1334, 3 outliers in the month of April for $100, $269 and $1063.
-- 1 outliers in the month of May for $1046 and 3 outliers in the month of June for $749, $1162 and $1813.

-- Que. Do you notice any anomalies? Describe your observations and conclusions.
-- Ans. As per the box plot, the month of June seems to have more outliers (in higher amounts) compared to other months. 
-- Also as CEO suspected there are bills related to restaraunts and pub in the month of June.
-- Moreover there is a bill of $1046 in food truck catgeory which seems to be suspicious.

-- Challenge

-- Please refer to the Module 7_Visual&Cjhallenge Markdown file.