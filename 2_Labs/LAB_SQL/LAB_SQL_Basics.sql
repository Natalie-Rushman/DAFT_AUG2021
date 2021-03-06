/*
Here, we will practice selecting and projecting data. You can finish all questions with only those clauses:

    SELECT
    SELECT DISTINCT
    FROM
    WHERE
    ORDER BY
    LIMIT

Assume that any _id columns are incremental, meaning that higher ids always occur after lower ids. For example, a client with a higher client_id joined the bank after a client with a lower client_id.
Query 1

Get the id values of the first 5 clients from district_id with a value equals to 1.

Expected result:

2
3
22
23
28

*/

SELECT * FROM bank.client
ORDER BY district_id, client_id ASC LIMIT 5;

/*
Query 2

In the client table, get an id value of the last client where the district_id equals to 72.

Expected result:

13576

*/

SELECT * FROM bank.client
WHERE district_id = 72
ORDER BY client_id DESC LIMIT 1;

/*
Query 3

Get the 3 lowest amounts in the loan table.

Expected result:

4980
5148
7656

*/

SELECT amount FROM bank.loan
ORDER BY amount ASC LIMIT 3;

/*
Query 4

What are the possible values for status, ordered alphabetically in ascending order in the loan table?

Expected result:

A
B
C
D

*/

SELECT DISTINCT status FROM bank.loan
ORDER BY status ASC;

/*
Query 5

What is the loan_id of the lowest payment received in the loan table?

Expected result:

6312

*/

SELECT loan_id, payments FROM bank.loan
ORDER BY payments ASC LIMIT 1;

/*

Query 6

What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount

Expected result:

#id     amount
2	    80952
19	    30276
25	    30276
37	    318480
38	    110736

*/

SELECT account_id, amount FROM bank.loan
ORDER BY account_id, amount ASC LIMIT 5;

/*

Query 7

What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?

Expected result:

10954
938
10711
1766
10799

*/

SELECT account_id, amount, duration FROM bank.loan
WHERE duration = 60
ORDER BY amount ASC LIMIT 5;

/*

Query 8

What are the unique values of k_symbol in the order table?

Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. You have to use backticks to escape the order table name.

Expected result:

LEASING
POJISTNE
SIPO
UVER

*/

ALTER TABLE bank.order RENAME TO bank.request;

SELECT DISTINCT k_symbol FROM bank.request /* Check for backticks `` again! */
ORDER BY k_symbol ASC;

/*
Query 9

In the order table, what are the order_ids of the client with the account_id 34?

Expected result:

29445
29446
29447

*/

SELECT order_id FROM bank.request
WHERE account_id = 34;

/*
Query 10

In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?

Expected result:

88
90
96
97

*/

SELECT DISTINCT account_id FROM bank.request
WHERE order_id > 29540 and order_id < 29560;

/*

Query 11

In the order table, what are the individual amounts that were sent to (account_to) id 30067122?

Expected result:

5123

*/

SELECT account_id, amount FROM bank.request
WHERE account_id = "30067122";


/*
Query 12

In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.

Expected result:

3556468	981231	PRIJEM	78.6
233254	981216	VYDAJ	600
233104	981212	VYDAJ	1212
233248	981211	VYDAJ	851
233176	981207	VYDAJ	204
3556467	981130	PRIJEM	75.1
233395	981130	VYDAJ	14.6
233103	981112	VYDAJ	1212
233247	981111	VYDAJ	851
233175	981107	VYDAJ	204

*/

SELECT trans_id, `date`, `type`, amount FROM bank.trans /* show the trans_id, date, type and amount*/
WHERE account_id = 793 /* from account_id 793 */
ORDER BY `date` DESC /*  in chronological order, from newest to oldest*/
LIMIT 10; /* of the 10 first transactions from account_id 793 */

/*
Query 13

In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.

Expected result:

1	663
2	46
3	63
4	50
5	71
6	53
7	45
8	69
9	60

*/


SELECT DISTINCT district_id, COUNT(*) FROM bank.`client` /* from client table */
GROUP BY district_id
HAVING district_id < 10  /* of all districts with a district_id lower than 10 */
/* how many clients are from each district_id */
ORDER BY district_id ASC;/* sorted by the district_id in ascending order */


/*
Query 14

In the card table, how many cards exist for each type? 
Rank the result starting with the most frequent type.

Expected result:

classic	659
junior	145
gold	88

*/

SELECT DISTINCT `type`, COUNT(*) AS Nbr_Cards FROM bank.card /* how many cards exist for each type? */
GROUP BY `type`
ORDER BY Nbr_Cards DESC; /* Rank the result starting with the most frequent type.*/

/*
Query 15

Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

Expected result:

7542	590820
8926	566640
2335	541200
817	    538500
2936	504000
7049	495180
10451	482940
6950	475680
7966	473280
339	    468060

*/

SELECT account_id, SUM(amount) AS Sum_Amount FROM bank.loan /* based on the sum of all of their loan amounts */
GROUP BY account_id
ORDER BY Sum_Amount DESC LIMIT 10; /* print the top 10 account_ids */

/*
Query 16

In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

Expected result:

930906	1
930803	1
930728	1
930711	1
930705	1

*/

SELECT COUNT(loan_id) as Nbr_Loans, `date` FROM bank.loan /* count the number for each date */
GROUP BY loan_id, `date` /* Display nbr_loans and date */
HAVING `date` < 930907 /* The date shall be before 930907 */
ORDER BY `date` DESC; /* ordered by date in descending order. */

/*
Query 17

In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, 
ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

Expected result:

971206	24	1
971206	36	1
971208	12	3
971209	12	1
971209	24	1
971210	12	1
971211	24	1
971211	48	1
971213	24	1
971220	36	1
971221	36	1
971224	60	1
971225	24	1
971225	60	1

*/
		
SELECT `date`, COUNT(*) as Nbr_Loans 
FROM bank.loan /* count the number of loans issued for each unique loan duration */
WHERE `date`LIKE "9712%" /* for each day in December 1997 */ /* Unknown syntax, check again */
GROUP BY `date`, duration 
HAVING count(*) > 0
ORDER BY 'date'; /* ordered by date and duration, both in ascending order. */

/*
Query 18

In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). 
Your output should have the account_id, the type and the sum of amount, named as total_amount. 
Sort alphabetically by type.

Expected result:

396	PRIJEM	1028138.6999740601
396	VYDAJ	1485814.400024414

*/

SELECT account_id, `type`, SUM(amount) AS total_amount FROM bank.trans /* sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming) */
WHERE account_id = 396 /* for account_id 396 */
GROUP BY `type`
ORDER BY `type` ASC;/* Sort alphabetically by type. */

/*
Query 19

From the previous output, translate the values for type to English, 
rename the column to transaction_type, 
round total_amount down to an integer.

Expected result:

396	INCOMING	1028138
396	OUTGOING	1485814

*/

SELECT account_id, `type` as 'transaction_type', FLOOR(SUM(amount)) AS total_amount FROM bank.trans 
WHERE account_id = 396 
GROUP BY `type`
ORDER BY `type` ASC;

SET SQL_SAFE_UPDATES = 0;
UPDATE trans SET `type`="INCOMING" WHERE `type`="PRIJEM"; 
UPDATE trans SET `type`="OUTGOING" WHERE `type`="VYDAJ";
SET SQL_SAFE_UPDATES = 1;

/*
Query 20

From the previous result, modify your query so that it returns only one row, 
with a column for incoming amount, outgoing amount and the difference.

Expected result:

396	1028138	1485814	-457676

*/

SELECT account_id,
	FLOOR(SUM(IF (`type`='INCOMING', amount, 0))) AS Incoming,
    FLOOR(SUM(IF (`type`='OUTGOING', amount, 0))) AS Outgoing, /* Value does not display */
    FLOOR(SUM(IF (`type`='INCOMING', amount, 0))) - FLOOR(SUM(IF (`type`='OUTGOING', amount, 0))) AS Difference
FROM trans 
WHERE account_id=396
GROUP BY account_id;  

/*
Query 21

Continuing with the previous example, rank the top 10 account_ids based on their difference.

Expected result:

9707	869527
3424	816372
3260	803055
2486	735219
1801	725382
4470	707243
3674	703531
9656	702786
2227	696564
6473	692580

*/

SELECT account_id, FLOOR(SUM(IF (`type`='INCOMING', amount, 0))) - FLOOR(SUM(IF (`type`='OUTGOING', amount, 0))) AS Difference
FROM trans
GROUP BY account_id
ORDER BY Difference DESC LIMIT 10;