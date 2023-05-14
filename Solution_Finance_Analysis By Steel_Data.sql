/* 1. What are the names of all the customers who live in New York?*/

SELECT concat(FirstName,' ',LastName) as Name
FROM customers
WHERE City='New York';

/* 2. What is the total number of accounts in the Accounts table?*/
SELECT COUNT(distinct AccountID)
FROM accounts;

/* 3. What is the total balance of all checking accounts?*/

SELECT sum(Balance)
FROM accounts
WHERE AccountType = 'checking';


/* 4. What is the total balance of all accounts associated with customers who live in Los Angeles?*/
SELECT sum(Balance)
FROM accounts
JOIN customers
using (CustomerID)
WHERE City = 'Los Angeles';

/* 5. Which branch has the highest average account balance?*/
SELECT BranchName, ROUND(avg(Balance),2) as avg_bal
FROM accounts
JOIN branches USING (BranchID)
GROUP BY BranchName
ORDER BY avg_bal desc
LIMIT 1;

/* 6. Which customer has the highest current balance in their accounts?*/
SELECT a.CustomerID, concat(FirstName,' ',LastName) as Name, sum(Balance) as Total_Bal
FROM accounts a
JOIN customers USING (CustomerID)
GROUP BY a.CustomerID
ORDER BY Total_Bal desc
lIMIT 1;

/* 7. Which customer has made the most transactions in the Transactions table?*/
SELECT FirstName, COUNT(t.AccountID) AS total_count
FROM accounts a
JOIN transactions t on t.AccountID=a.AccountID
JOIN customers c ON c.CustomerID=a.CustomerID
GROUP BY FirstName
ORDER BY total_count desc
LIMIT 1;

/* 8.Which branch has the highest total balance across all of its accounts?*/

SELECT a.BranchID, BranchName, sum(Balance) as Total_bal
FROM accounts a
JOIN branches USING(BranchID)
GROUP BY 1, 2
ORDER BY total_bal desc
LIMIT 1;

/* 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?*/

SELECT DISTINCT(AccountType) FROM accounts;  /* check all distinct AccountTypes */

SELECT FirstName, sum(Balance) AS Total_bal
FROM accounts
JOIN customers USING (CustomerID)
WHERE AccountType in ('checking', 'savings')
GROUP BY 1
ORDER BY Total_bal desc
LIMIT 1;


/* 10. Which branch has the highest number of transactions in the Transactions table?*/
SELECT BranchName, COUNT(TransactionID) as total_transctn
FROM branches b
JOIN accounts a on a.BranchID=b.BranchID
JOIN transactions t ON a.AccountID=t.AccountID
GROUP BY 1
ORDER BY total_transctn desc;