-- Create table card_holder
CREATE TABLE card_holder (
  id INTEGER PRIMARY KEY,
  name VARCHAR NOT NULL
);

--Create table credit_card (cardholder_id is foreign key which references to id in card_holder table)
CREATE TABLE credit_card (
  card VARCHAR PRIMARY KEY,
  cardholder_id INT NOT NULL,
  FOREIGN KEY (cardholder_id) REFERENCES card_holder(id)
);

-- Create table merchant_category
CREATE TABLE merchant_category (
  id INTEGER PRIMARY KEY,
  name VARCHAR NOT NULL
);

--Create table merchant (id_merchant_category is foreign key which references to id in merchant_category table)
CREATE TABLE merchant (
  id INTEGER PRIMARY KEY,
  name VARCHAR NOT NULL,
  id_merchant_category INT NOT NULL,
  FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

--Create table transaction (card is foreign key which references to card in credit_card table and id_merchant is foreign key which references to id in merchant table)
CREATE TABLE transaction (
  id INTEGER PRIMARY KEY,
  date timestamp without time zone NOT NULL,
  amount decimal NOT NULL,
  card VARCHAR NOT NULL,
  FOREIGN KEY (card) REFERENCES credit_card(card),
  id_merchant INTEGER NOT NULL,
  FOREIGN KEY (id_merchant) REFERENCES merchant(id)
);

-- Queries to verify data load from csv files

Select * from card_holder;
Select * from credit_card;
Select * from merchant;
Select * from merchant_category;
Select * from transaction;

-- Que. How can you isolate (or group) the transactions of each cardholder?

-- Ans. By creating view from tables card_holder and transaction and counting total no of transactions per cardholder

CREATE VIEW cardholder_transaction AS
Select a.name, count(amount) as num_transactions, sum(amount)as total_amount
from card_holder a
INNER JOIN credit_card b ON a.id = b.cardholder_id
INNER JOIN transaction c ON b.card = c.card
group by a.name
order by a.name;

-- Query cardholder_transaction view
SELECT *
FROM cardholder_transaction

-- Que. Count the transactions that are less than $2.00 per cardholder.

-- Ans. Create a view by joining all the 5 tables and counting transactions less than $2

CREATE VIEW fraudlent_transactions AS
Select a.name as cardholder_name, b.card, c.amount, d.name as merchant_name, e.name as merchant_category, count(c.amount) as num_transactions
from card_holder a
INNER JOIN credit_card b ON a.id = b.cardholder_id
INNER JOIN transaction c ON b.card = c.card
INNER JOIN merchant d ON c.id_merchant = d.id
INNER JOIN merchant_category e ON d.id_merchant_category = e.id
group by a.name, b.card, c.amount, d.name, e.name
having c.amount < 2
order by a.name;

-- Query fraudlent_transactions view to count the suspicious transactions by merchant_category

select * from fraudlent_transactions

SELECT cardholder_name, merchant_category, count(num_transactions)
FROM fraudlent_transactions
group by cardholder_name,merchant_category;

-- Que. Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

-- Ans. The above query from the view suggests that the transactions done at restaurant, bars and pubs might be fraudlent 
-- The transaction of $2 at a coffee shop might be not fraudlent as a cup of coffee would cost less than $2.



-- Que. What are the top 100 highest transactions made between 7:00 am and 9:00 am?

-- Ans. Create a view from the table transaction to list the top 100 transactions beween 7 am and 9 am

CREATE VIEW Top100_transactions AS
Select id, CAST(date as TIME),amount
from transaction
where CAST(date as TIME) BETWEEN '07:00:00' AND '09:00:00'
order by amount desc
LIMIT 100;

-- Query Top100_transactions view to count the top 100 transactions

SELECT *
FROM Top100_transactions;

-- Que. Do you see any anomalous transactions that could be fraudulent?
-- Ans: The first 9 transactions seems to be fraudlent as the amount seems to be large and outliers when compared to the remaining smaller amounts.


-- Create a view from the table transaction to list the top 100 transactions during rest of the day

CREATE VIEW Top100_transactions_new AS
Select id, CAST(date as TIME),amount
from transaction
where CAST(date as TIME) NOT BETWEEN '07:00:00' AND '09:00:00'
order by amount desc
LIMIT 100;

-- Query Top100_transactions_new view to count the top 100 transactions during rest of the day

SELECT *
FROM Top100_transactions_new;


-- Que. Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
-- Ans. There seems to be more fraudlent trnasaction in the rest of the day compared to the time frame between 7 and 9 am.

-- Que. If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
-- Ans. No

-- What are the top 5 merchants prone to being hacked using small transactions?

CREATE VIEW Top5_merchants AS
Select a.name, b.amount, count(*) as num_transactions
from merchant a
JOIN transaction b ON a.id = b.id_merchant
group by a.name, b.amount
having b.amount < 2
order by b.amount asc
;

select * from Top5_merchants

Select name, sum(amount)
from Top5_merchants
group by name
order by sum(amount) asc
LIMIT 5;