USE bank;

SELECT * FROM loan;

/* display the accounts with loans > AVG amount of loan
1. AVG */

SELECT AVG(amount) FROM loan;

/* 2. Get the accounts with loans > AVG
average_loan = np.mean(loan.amount) 
loan[(loan["amount"]>average_loan].account_id */

SELECT account_id, amount FROM loan
WHERE amount > (SELECT AVG(amount) AS average_loan FROM loan)
ORDER BY amount DESC;
/* SUBQUERY in brackets */

/* For each account GROUP BY account_id
the total amount transfer 
WHERE > 10.000 */

SELECT account_id, account_to, bank_to, CEILING(sum(amount)) AS total_amount FROM request
GROUP BY account_id, account_to, bank_to
HAVING total_amount > 10000;