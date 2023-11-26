CREATE TABLE VENDOR (
V_CODE INT PRIMARY KEY NOT NULL,
V_NAME VARCHAR (15),
V_CONTACT VARCHAR(50) NULL,
V_AREACODE VARCHAR(3),
V_PHONE VARCHAR(8),
V_STATE VARCHAR (2),
V_ORDER VARCHAR (1));

INSERT INTO VENDOR VALUES ();

--PURCHASEORDER PONUM PK V_CODE AS FK
CREATE TABLE PURCHASEORDER(
PONUM VARCHAR(5) PRIMARY KEY,
V_CODE INT FOREIGN KEY REFERENCES VENDOR(V_CODE)
);

INSERT INTO VENDOR VALUES ('40','JOHN SMITH',NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO VENDOR(V_CODE,V_NAME) VALUES ('35','JOHN SMITH');

UPDATE VENDOR
SET V_STATE='TN'
WHERE V_CODE='35';

UPDATE VENDOR
SET V_NAME='JANE SMITH'
WHERE V_CODE='40';

UPDATE VENDOR
SET V_NAME='JAME SMITH'
WHERE V_CODE='40';

DELETE VENDOR
WHERE V_ORDER IS NULL;

ALTER TABLE VENDOR
ADD V_RATE DECIMAL (4,2);

ALTER TABLE VENDOR
DROP COLUMN V_RATE;
SELECT * FROM VENDOR;
DROP TABLE VENDOR;
DROP TABLE PURCHASEORDER;
--- END OF THIS ONE


-- CREATE TABLE TEST1
-- PK TESTNO INT
-- TEST DESC VARCHAR(20)

--TABLE TEST 2
--TEST INT
-- TESTNO FK FROM TEST1

CREATE TABLE TESTING (
TESTNO INT PRIMARY KEY,
TEST_DESC VARCHAR(20));

CREATE TABLE TEST2(
TEST INT PRIMARY KEY,
TESTNO INT FOREIGN KEY REFERENCES TESTING(TESTNO));

-- ADD DATA TO TESTING TESTNO=1, TEST DESC NULL
INSERT INTO TESTING (TESTNO) VALUES (1);

-- ADD DATA TO TESTING TESTNO=2, TEST DESC NULL
INSERT INTO TESTING VALUES (2,NULL)

-- ADD COLUMN TO TABLE, TEST_PRICE DECIMAL (4,2)
ALTER TABLE TESTING
ADD TEST_PRICE DECIMAL (4,2);

-- CHANGE DATA WITHIN TABLE, TEST PRICE FOR TEST 1 IS 10
UPDATE TESTING
SET TEST_PRICE=10
WHERE TESTNO=1;

-- CHANGE DATA TYPE OF A COLUMN, TEST_PRICE DECIMAL (6,2)
ALTER TABLE TESTING
ALTER COLUMN TEST_PRICE DECIMAL (6,2)

-- DELETE COLUMN FROM TABLE, TESTING TEST_DESC
ALTER TABLE TESTING
DROP COLUMN TEST_DESC;

-- DELETE TABLE TESTING
DROP TABLE IF EXISTS TESTING;
DROP TABLE TEST2;

--TESTING TO SEE THE OUTPUT
SELECT*FROM TESTING;






--1. List the item ID, description, and price for all itmes.
SELECT ITEM_ID,DESCRIPTION, PRICE 
FROM ITEM

--2.List all rows and columns for the complete invoices table
SELECT * From INVOICES

--3. List the first and last names of customers with credit limits of $1000 or more
SELECT FIRST_NAME,LAST_NAME, CREDIT_LIMIT
FROM CUSTOMER
WHERE CREDIT_LIMIT >=1000

--4.List the order number for each order placed by customer number 125 on 11/15/2021. (Hint: If you need help, use the discussion of the DATE data type in Figure 3-19 in Module 3.)
SELECT INVOICE_NUM
FROM INVOICES
WHERE CUST_ID='125'
       AND INVOICE_DATE='2021-11-15';
SELECT* FROM INVOICES

--5.List the number and name of each customer represented by sales rep 10 or sales rep 15.
SELECT CUST_ID, FIRST_NAME, LAST_NAME, REP_ID
FROM CUSTOMER
WHERE REP_ID = '10' 
     OR REP_ID='15';

--6.List the item ID and description of each item that is not in category HOR.
SELECT ITEM_ID, DESCRIPTION
FROM ITEM
WHERE ITEM_ID <> 'HOR';

--7.List the item ID, description, and number of units on hand for each item that has between 10 and 30 units on hand, including both 10 and 30. Provide two alternate SQL statements to produce the same results.
SELECT ITEM_ID, DESCRIPTION, ON_HAND
FROM ITEM
WHERE ON_HAND >= 10 AND ON_HAND <= 30

SELECT ITEM_ID,DESCRIPTION,ON_HAND
FROM ITEM
WHERE ON_HAND BETWEEN 10 AND 30
--8.List the item ID, description, and on-hand value (units on hand * unit price) of each item in category CAT. 
--(On-hand value is technically units on hand * cost, but there is no COST column in the ITEM table.)
--Assign the name ON_HAND_VALUE to the computed column.
SELECT ITEM_ID, DESCRIPTION,(ON_HAND * PRICE) AS ON_HAND_VALUE
FROM ITEM
WHERE CATEGORY='CAT'

--9.List the item ID, description, and on-hand value for each item where the on-hand value is at least $1,500.
--Assign the name ON_HAND_VALUE to the computed column.
SELECT ITEM_ID, DESCRIPTION, (ON_HAND * PRICE) AS ON_HAND_VALUE
FROM ITEM
WHERE ON_HAND * PRICE >=1500;

--10.Use the IN operator to list the item ID and description of each item in category FSH or BRD
SELECT ITEM_ID, DESCRIPTION
FROM ITEM
WHERE CATEGORY IN ('FSH','BRD');

--11.Find the ID, first name, and last name of each customerwhose first name begins witht he letter "S."
SELECT CUST_ID,FIRST_NAME,LAST_NAME
FROM CUSTOMER
WHERE FIRST_NAME LIKE 'S%';

--12.List all details about all items.
--Orde the output by descirption
SELECT * FROM ITEM 
ORDER BY DESCRIPTION 

--13.List all details about all items.
--Order the output by item ID within location
--(That is, order the output by location and then by item ID)
SELECT * 
FROM ITEM
ORDER BY LOCATION, ITEM_ID

--14.How many customers have balances that are more than their credit limits ?
SELECT COUNT (*)
FROM CUSTOMER
WHERE BALANCE > CREDIT_LIMIT;

SELECT * FROM CUSTOMER

--15.



--1. HOW MANY ITEMS ARE PRICED AT OVER 40=
SELECT COUNT(*)
WHERE PRICE > 40 

--2. SELECT ALL COLUMNS FROM THE ITEM TABLE WHERE LOCATION IS A AND B
SELECT * FROM ITEM
WHERE LOCATION IN ('A','B')

--3. SELECT ALL COLUMNS FROM THE ITEM TABLE THAT ARE EQUAL TO MAXIMUM PRICE
SELECT * FROM ITEM 
WHERE PRICE = (SELECT MAX(PRICE)
FROM ITEM);

--4. SELECT INVOICE NUMBER AND THE ESTIMATE
SELECT INVOICE_NUM,(QUANTITY *QUOTED PRICE ) AS ESTIMATE 
FROM INVOICE_LINE
WHERE INVOICE_NUM='14216' 
 OR INVOICE_NUM='14219'

 --5. 

 ---

 SELECT*FROM ITEM
  