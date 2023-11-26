USE BIKE;

SELECT * FROM Bicycle

SELECT C.CUSTOMERID,C.LASTNAME,C.FIRSTNAME,B.MODELTYPE,P.ColorList,B.OrderDate,B.SALESTATE
FROM CUSTOMER C INNER JOIN Bicycle B ON C.CustomerID=B.CUSTOMERID
INNER JOIN Paint P ON P.PaintID=B.PaintID
WHERE B.SALESTATE='CA' AND P.COLORLIST='RED' AND YEAR(B.OrderDate) = '2003' AND MONTH(B.ORDERDATE)=9  AND ModelType = 'MOUNTAIN' 


SELECT E.EMPLOYEEID, E.LASTNAME, B.SALESTATE,B.MODELTYPE, B.STOREID, B.ORDERDATE 
FROM EMPLOYEE E INNER JOIN BICYCLE B ON E.EmployeeID=B.EmployeeID
WHERE B.SALESTATE= 'WI' AND B.ModelType='RACE' AND YEAR (B.ORDERDATE)='2001' AND StoreID IN ('1', '2', null) 


SELECT DISTINCT C.COMPONENTID, M.MANUFACTURERNAME,C.PRODUCTNUMBER,B.SaleState,B.OrderDate,C.Category
FROM COMPONENT C INNER JOIN MANUFACTURER M ON C.MANUFACTURERID=M.MANUFACTURERID
INNER JOIN BIKEPARTS BP ON C.COMPONENTID=BP.COMPONENTID
INNER JOIN BICYCLE B ON BP.SerialNumber=B.SerialNumber
WHERE B.ModelType='ROAD' AND YEAR(B.ORDERDATE)='2002' AND B.SaleState='FL' AND C.Category='REAR DERAILLEUR' 

SELECT B.CUSTOMERID,C.LASTNAME,C.FIRSTNAME,B.MODELTYPE,B.SALESTATE,B.FRAMESIZE,B.ORDERDATE
FROM BICYCLE B INNER JOIN CUSTOMER C ON C.CustomerID=B.CustomerID
WHERE B.MODELTYPE='MOUNTAIN FULL' AND B.SALESTATE='GA' AND YEAR(B.OrderDate) =2004
AND FRAMESIZE= (SELECT MAX(FRAMESIZE) FROM BICYCLE WHERE MODELTYPE= 'MOUNTAIN FULL' AND SALESTATE='GA' AND YEAR (ORDERDATE) =2004)

SELECT M.MANUFACTURERNAME, P.MANUFACTURERID 
FROM Manufacturer M INNER JOIN PurchaseOrder P ON M.ManufacturerID=P.ManufacturerID
WHERE YEAR (P.ORDERDATE)='2003' AND DISCOUNT= (SELECT MAX(DISCOUNT) FROM PurchaseOrder WHERE YEAR (ORDERDATE)=2003)



SELECT C.COMPONENTID, M.MANUFACTURERNAME, C.PRODUCTNUMBER, C.CATEGORY, P.PRICEPAID 
AS [VALUE] FROM PURCHASEORDER PO INNER JOIN PURCHASEITEM P
 ON PO.PURCHASEID = P.PURCHASEID INNER JOIN COMPONENT C 
ON P.COMPONENTID = C.COMPONENTID INNER JOIN MANUFACTURER M 
ON C.MANUFACTURERID = M.MANUFACTURERID 
WHERE YEAR(PO.ORDERDATE) = '2003' 
AND P.PRICEPAID = (SELECT MAX(P.PRICEPAID)
 FROM PURCHASEITEM P INNER JOIN PURCHASEORDER PO 
ON P.PURCHASEID = PO.PURCHASEID 
WHERE YEAR(PO.ORDERDATE) = '2003');

SELECT TOP 1 LETTERSTYLEID, COUNT(LETTERSTYLEID) AS COUNTOFSERIALNUMBER
FROM  BICYCLE
WHERE ORDERDATE LIKE '%2003%' AND MODELTYPE= 'RACE'
ORDER BY COUNTOFSERIALNUMBER DESC;
