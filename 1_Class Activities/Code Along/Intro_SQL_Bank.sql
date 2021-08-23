SELECT *, amount - payments AS balance
FROM bank.loan;

/* df["balance"] = df|“amount"] - df["paments"]*/

SELECT loan_id, account_id, duration, status, (amount - payments)/1000 
AS "Balance in Thousands"
FROM bank.loan;

SELECT duration%2 FROM bank.loan;

SELECT DISTINCT A2 FROM bank.district
WHERE A2 in ("Benesov", "Beroun")
OR A4 < 75000;

SELECT * FROM bank.loan
	WHERE status 
		NOT IN ("B", "b") 
		AND amount <> 100000;

/* df[!df["status"].isin["B","b"]] & (df["amount"]!=100000 */

SELECT * FROM bank.account
WHERE district_id IN (1,2,3,4,5);

SELECT avg(amount) AS Average FROM bank.loan
GROUP BY status
ORDER BY Average ASC;

SELECT SUBSTRING("Hello World",7,2);
/* Index nicht zero-based! 2 Chars ab 7. Stelle */

SELECT * FROM bank.district 
WHERE A2 regexp "B";
/* Be aware of different libraries */



