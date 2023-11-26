--1. For each invoice, list the invoice number and invoice date along with the ID, first name, and last name of the customer for which the invoice was created.
SELECT INVOICE_NUM, INVOICE_DATE,CUSTOMER.CUST_ID,FIRST_NAME,LAST_NAME
FROM INVOICES, CUSTOMER
WHERE INVOICES.CUST_ID=CUSTOMER.CUST_ID

SELECT INVOICE_NUM, INVOICE_DATE, CUSTOMER.CUST_ID, FIRST_NAME, LAST_NAME
FROM INVOICES INNER JOIN CUSTOMER ON INVOICES.CUST_ID=CUSTOMER.CUST_ID;

--2. For each invoice placed on November 15, 2021, list the invoice number along with the ID, first name, and last name of the customer for which the invoice was created.
SELECT INVOICE_NUM, INVOICE_DATE,CUSTOMER.CUST_ID,FIRST_NAME,LAST_NAME
FROM INVOICES,CUSTOMER
WHERE INVOICES.CUST_ID=CUSTOMER.CUST_ID
      AND INVOICE_DATE='2021-11-15';

SELECT INVOICE_NUM, INVOICE_DATE,CUSTOMER.CUST_ID,FIRST_NAME,LAST_NAME
FROM INVOICES INNER JOIN CUSTOMER ON INVOICES.CUST_ID=CUSTOMER.CUST_ID
WHERE INVOICE_DATE='2021-11-15'


--3. For each invoice, list the invoice number, invoice date, item ID, quantity ordered, and quoted price for each invoice line that makes up the invoice.
SELECT INVOICES.INVOICE_NUM, INVOICE_DATE, ITEM_id, QUANTITY, QUOTED_PRICE
FROM INVOICES INNER JOIN INVOICE_LINE ON INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM;
-- ASSIGN AS FUNCTION
SELECT I.INVOICE_NUM, INVOICE_DATE, ITEM_id, QUANTITY, QUOTED_PRICE
FROM INVOICES AS I INNER JOIN INVOICE_LINE AS IL ON I.INVOICE_NUM=IL.INVOICE_NUM;

--4. Use the IN operator to find the ID, first name, and last name of each customer for which as invoice was created on November 15, 2021.
SELECT CUST_ID, FIRST_NAME,LAST_NAME
FROM CUSTOMER
WHERE CUST_ID IN (SELECT CUST_ID
                  FROM INVOICES
				  WHERE INVOICE_DATE='2021-11-15')


--5. Repeat Exercise 4, but this time use the EXISTS operator in your answer.
SELECT CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER
WHERE EXISTS (SELECT * FROM INVOICES 
                       WHERE INVOICES.CUST_ID=CUSTOMER.CUST_ID
					   AND INVOICE_DATE='2021-11-15');

--6. Find the invoice number and invoice date for each invoice that includes an item stored in location C. (Using nested subquery for one approach, and using table join for a second approach )
SELECT INVOICE_NUM, INVOICE_DATE, ITEM.ITEM_ID, ITEM.LOCATION
FROM INVOICES,ITEM
WHERE INVOICE_NUM IN (SELECT INVOICE_NUM;

SELECT INVOICE_NUM,INVOICE_DATE
FROM INVOICES
WHERE EXISTS (SELECT * 
               FROM INVOICE_LINE, ITEM
			   WHERE INVOICE_LINE.ITEM_ID= ITEM.ITEM_ID
			   AND INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
			   AND ITEM.LOCATION='C');

--NESTED IN 
SELECT INVOICE_NUM, INVOICE_DATE
FROM INVOICES 
WHERE INVOICE_NUM IN (SELECT INVOICE_NUM 
                       FROM INVOICE_LINE 
					   WHERE ITEM_ID IN (SELECT ITEM_ID
					                      FROM ITEM
										  WHERE LOCATION='C'));

-- NESTED EXISTS 
SELECT INVOICE_NUM, INVOICE_DATE
FROM INVOICES
WHERE EXISTS (SELECT *
              FROM INVOICE_LINE
			  WHERE EXISTS ( SELECT* 
			  FROM ITEM 
			  WHERE INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
			  AND ITEM.ITEM_ID=INVOICE_LINE.ITEM_ID
			  AND LOCATION='C'));
        
--7. Find the ID, first name, and last name of each customer for which an invoice was not created on November 15, 2021.
select CUSTOMER.CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER INNER JOIN INVOICES ON CUSTOMER.CUST_ID=INVOICES.CUST_ID 
WHERE INVOICE_DATE <> '2021-11-15';

SELECT* FROM CUSTOMER;
-- BETTER SOLUTION
SELECT CUSTOMER.CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER
WHERE CUST_ID NOT IN (SELECT CUST_ID 
                      FROM INVOICES
					  WHERE INVOICE_DATE='2021-11-15')

SELECT* 
FROM CUSTOMER LEFT OUTER JOIN INVOICES ON CUSTOMER.CUST_ID=INVOICES.CUST_ID
WHERE INVOICE_DATE <> '2021-11-15'

SELECT * 
FROM CUSTOMER LEFT OUTER JOIN INVOICES
ON CUSTOMER.CUST_ID=INVOICES.CUST_ID;


--8. For each invoice, list the invoice number, invoice date, item ID, description, and category for each item that makes up the invoice.
SELECT INVOICES.INVOICE_NUM, INVOICE_DATE, INVOICE_LINE.ITEM_ID,
ITEM.DESCRIPTION, ITEM.CATEGORY
FROM INVOICES INNER JOIN INVOICE_LINE
     ON INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
	 INNER JOIN ITEM
	 ON INVOICE_LINE.ITEM_ID=ITEM.ITEM_ID
-- ^^COMEPLETE THIS ONE


--9. Repeat Exercise 7, but this time order the rows by category and then by invoice number.
SELECT INVOICES.INVOICE_NUM, INVOICE_DATE, INVOICE_LINE.ITEM_ID,
ITEM.DESCRIPTION, ITEM.CATEGORY
FROM INVOICES INNER JOIN INVOICE_LINE
     ON INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
	 INNER JOIN ITEM
	 ON INVOICE_LINE.ITEM_ID=ITEM.ITEM_ID
	 ORDER BY CATEGORY, INVOICES.INVOICE_NUM;

--10. Use a subquery to find the sales rep ID, first name, and last name of each sales rep who represents at least one customer with a credit limit of $500. List each sales rep only once in the results.

--IN
SELECT DISTINCT REP_ID, FIRST_NAME, LAST_NAME
FROM SALES_REP
WHERE REP_ID IN (SELECT REP_ID
                   FROM CUSTOMER
				   WHERE CREDIT_LIMIT=500)

--EXISTS 
SELECT DISTINCT REP_ID, FIRST_NAME,LAST_NAME
FROM SALES_REP
WHERE EXISTS  ( SELECT REP_ID
                FROM CUSTOMER
				WHERE CREDIT_LIMIT=500
				AND SALES_REP.REP_ID=CUSTOMER.REP_ID);

--11. Repeat Exercise 10, but this time do not use a subquery.
SELECT DISTINCT SR.REP_ID, SR.FIRST_NAME, SR.LAST_NAME
FROM SALES_REP AS SR INNER JOIN CUSTOMER AS C ON SR.REP_ID=C.REP_ID
WHERE CREDIT_LIMIT=500

--12. Find the ID, first name, and last name of each customer that currently has an invoice on file for Wild Bird Food (25 lb).
SELECT CUSTOMER.CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER INNER JOIN INVOICES
ON CUSTOMER.CUST_ID=INVOICES.CUST_ID
INNER JOIN INVOICE_LINE
ON INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
INNER JOIN ITEM
ON INVOICE_LINE.ITEM_ID=ITEM.ITEM_ID
WHERE ITEM.DESCRIPTION='WILD BIRD FOOD (25 LB)'


--13. List the item ID, description, and category for each pair of items that are in the same category. (For example, one such pair would be item FS42 and item PF19, because the category for both items is FSH.)
--EXISTS
SELECT CATEGORY, ITEM_ID, DESCRIPTION
FROM ITEM
WHERE EXISTS (SELECT COUNT (*) 
              FROM ITEM I WHERE I.CATEGORY=ITEM.CATEGORY
			  GROUP BY CATEGORY
			  HAVING COUNT(*)=2);

--14. List the invoice number and invoice date for each invoice created for the customer James Gonzalez.
SELECT INVOICE_NUM, INVOICE_DATE
FROM INVOICES
WHERE CUST_ID IN (SELECT CUST_ID
                  FROM CUSTOMER 
				  WHERE FIRST_NAME='JAMES'
				  AND LAST_NAME='GONZALEZ');


--15. List the invoice number and invoice date for each invoice that contains an invoice line for a Wild Bird Food (25 lb).
SELECT INVOICES.INVOICE_NUM, INVOICE_DATE
FROM INVOICES INNER JOIN INVOICE_LINE
   ON INVOICES.INVOICE_NUM = INVOICE_LINE.INVOICE_NUM
   INNER JOIN ITEM
   ON INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID
   WHERE ITEM.DESCRIPTION='WILD BIRD FOOD (25LB)';

--16. List the invoice number and invoice date for each invoice that either was created for James Gonzalez or that contains an invoice line for Wild Bird Food (25 lb).
SELECT CUSTOMER.CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER INNER JOIN INVOICES
ON CUSTOMER.CUST_ID=INVOICES.CUST_ID
INNER JOIN INVOICE_LINE
ON INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
INNER JOIN ITEM
ON INVOICE_LINE.ITEM_ID=ITEM.ITEM_ID
WHERE ITEM.DESCRIPTION='WILD BIRD FOOD (25 LB)'
 OR (CUSTOMER.FIRST_NAME= 'JAMES'
        AND LAST_NAME='GONZALEZ')


--17. List the invoice number and invoice date for each invoice that was created for James Gonzalez and that contains an invoice line for Wild Bird Food (25 lb).

--18. List the invoice number and invoice date for each invoice that was created for James Gonzalez but that does not contain an invoice line for Wild Bird Food (25 lb).
SELECT DISTINCT INVOICES.INVOICE_NUM, INVOICE_DATE
FROM CUSTOMER INNER JOIN INVOICES
ON CUSTOMER.CUST_ID=INVOICES.CUST_ID
INNER JOIN INVOICE_LINE
ON INVOICES.INVOICE_NUM=INVOICE_LINE.INVOICE_NUM
INNER JOIN ITEM
ON INVOICE_LINE.ITEM_ID=ITEM.ITEM_ID
WHERE ITEM.DESCRIPTION='WILD BIRD FOOD (25 LB)'
 OR (CUSTOMER.FIRST_NAME= 'JAMES'
        AND LAST_NAME='GONZALEZ')


--19. List the item ID, description, unit price, and category for each item that has a unit price greater than the unit price of every item in category CAT. Use either the ALL or ANY operator in your query. (Hint: Make sure you select the correct operator.)

SELECT ITEM_ID, DESCRIPTION, PRICE,CATEGORY
FROM ITEM 
WHERE PRICE > ALL (SELECT PRICE FROM ITEM WHERE CATEGORY='CAT')

SELECT PRICE FROM ITEM WHERE CATEGORY='CAT';

--20. For each item, list the item ID, description, units on hand, invoice number, and quantity ordered. All items should be included in the results. For those items that are currently not on an invoice, the invoice number and quantity ordered should be left blank. Order the results by item ID.
SELECT ITEM.ITEM_ID, ITEM.DESCRIPTION,ITEM.PRICE,ITEM.ON_HAND INVOICE_LINE,iNVOICE_NUM, INVOICE_LINE.QUANTITY
FROM ITEM LEFT JOIN INVOICE_LINE ON ITEM.ITEM_ID=INVOICE_LINE.ITEM_ID
ORDER BY ITEM.ITEM_ID



-- If you used ALL in Exercise 18, repeat the exercise using ANY. If you used ANY, repeat the exercise using ALL, and then run the new command. What question does the new command answer?

--21. For each sales rep, list the ID, first name, and last name for the customer, along with the sales rep first name, and sales rep last name. All reps should be included in the results. Order the results by rep ID. There are two SQL commands for this query that lists the same results. Create and run each SQL command.
SELECT C.CUST_ID, C.FIRST_NAME AS CUST_FNAME, C.LAST_NAME AS CUST_LNAME,
S.FIRST_NAME AS RERP_FNAME, S.LAST_NAME AS REP_LNAME
FROM CUSTOMER C RIGHT JOIN SALES_REP S ON C.REP_ID=S.REP_ID
ORDER BY S.REP_ID


--LIST THE ID AND NAMES OF EACH CUSTOMER THAT IS EITHERR REPRESENTED BY SALES REP 10 OR CURRENTLY HAS INVOICES ON FLE, OR BOTH
SELECT CUST_ID, FIRST_NAME, LAST_NAME
FROM CUSTOMER
WHERE REP_ID='10'
UNION
SELECT CUSTOMER.CUST_ID,FIRST_NAME, LAST_NAME
FROM CUSTOMER INNERR JOIN INVOICES ON CUSTOMER.CUST_ID=INVOICES.CUST_ID
