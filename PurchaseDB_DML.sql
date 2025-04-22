 /*         	  
		             PROJECT NAME : PURCHASE DB_DML
		             
-----------------------------------------------------------------------------------------------
Table of Contents: DML

		 	 ‣SECTION   01  : SELECT STATEMENT
			 ‣SECTION   02  : SELECT STATEMENT TO CONTROL SEQUENCE OF OPERATION
			 ‣SECTION	03	: SELECT STATEMENT WITH LEFT STATEMENT
			 ‣SECTION	04	: TOP WITH DISTINCT
			 ‣SECTION	05	: SELECT INTO STATEMENT
			 ‣SECTION	06	: SELECT CLAUSE WITH IN PHRASE
			 ‣SECTION	07	: SELECT STATEMENT FOR RETRIVE NULL /NOT NULL
			 ‣SECTION	08	: INSERT DATA INTO TABLE VALUE USING INSERT STATEMENT
			 ‣SECTION	09	: UPDATE STATEMENT
			 ‣SECTION	10	: DELETE STATEMENT
			 ‣SECTION	11	: OFFSET FETCH
			 ‣SECTION	12	: ALL/ANY/SOME
			 ‣SECTION	13	: COMPARISION OPERATOR
			 ‣SECTION	14	: LOGICAL OPERATOR
			 ‣SECTION	15	: BETWEEN
			 ‣SECTION	16	: LIKE OPERATOR
			 ‣SECTION	17	: JOIN QUERY(INNER/OUTER/CROSS)
			 ‣SECTION	18	: SUBQUERY/CO-RELATED QUERY
			 ‣SECTION	19	: AGGREGATE WITH HAVING GROUP BY CLAUSE
			 ‣SECTION	20	: SIMPLE CASE/SEARCH CASE
			 ‣SECTION	21	: CTE
			 ‣SECTION	22	: ROLLUP - CUBE - GROUPING SETS
			 ‣SECTION	23	: GROPING
			 ‣SECTION	24	: EXISTS,NOT EXISTS
			 ‣SECTION	25	: EXCEPT/UNION/INTERSECT
			 ‣SECTION	26	: CONVERT - CAST - TRY CONVERT
			 ‣SECTION	27	: CHAR FUNCTION TO FORMAT OUTPUT
			 ‣SECTION	28	: MERGE TABLE
			 ‣SECTION	29	: CHOOSE/IFF
			 ‣SECTION	30	: COALESCE/ISNULL
			 ‣SECTION	31	: RANK/DENSERANK 
			 ‣SECTION	32	: NTILE FUNCTION
			 ‣SECTION	33	: ANALYTICAL FUNCTION
             ‣SECTION	34	: LAG/LEAD
			 SECTION	35	: PERCENTILE RANK
			 ‣SECTION	36	: ERROR HANDLING WITH TRY CATCH
			 ‣SECTION	37	: TRANSACTION
             ‣SECTION	38	: CURSOR
			 ‣SECTION	39	: IF-ELSE
             ‣SECTION	40	: DATE FUNCTION
			 ‣SECTION	41	: NUMERIC FUNCTION
             ‣SECTION	42	: STRING FUNCTION
			 ‣SECTION	43	: GOTO
			 ‣SECTION	44	: WAIT FOR
             ‣SECTION	45	: JUSTIFY
--------------------------------------------------------------------------------------------------------*/

USE PurchaseDB
GO
                          ----SELECT STATEMENT----

Select * From Customer_t
Select CustomerFName+' '+CustomerLName As customerName From Customer_t

               ---SELECT STATEMENT TO CONTROL SEQUENCE OF OPERATION---

Select CustomerId,CustomerId+7*3 As OderOfPrecedence,
(CustomerId+7)*3 As Addfirst
From Customer_t  

Select ModelId,ModelId/10 As Quotient,ModelId%10 As Remainder From CarModel_t

                ---SELECT STATEMENT WITH LEFT STATEMENT----

Select CustomerFName,CustomerLName,
LEFT(CustomerFName,1)+LEFT(CustomerLName,1) As Initial
From Customer_t

                         ----TOP WITH DISTINCT----

Select Distinct Top 2 * From Customer_t

                         ----SELECT INTO STATEMENT----

Select * into Customerinfo From Customer_t

                       ---SELECT CLAUSE WITH IN PHRASE--- 

Select * From Customer_t
Where CustomerId IN (101,102,104)

Select * From Customer_t
Where CustomerId  NOT IN (101,102,104) 

                     ---SELECT STATEMENT FOR RETRIVE NULL /NOT NULL---

Select * From Purchase_t
Where PaymentTotal IS NUll

Select * From Purchase_t
Where PaymentTotal IS NOT NUll


                ----INSERT DATA INTO TABLE VALUE USING INSERT STATEMENT----

---insert values into Customer_t Table--

Insert Into Customer_t
(CustomerId,CustomerFName,CustomerLName,Phone)
Values
(101,'Jhon','Doe','555-1234'),
(102,'Jane','Smith','555-1235'),
(103,'Frank','Lee','555-1236')

--Insert values into CarModel_t table-- 

Insert Into CarModel_t
(ModelId,Title)
Values
(201,'Fusion'),
(202,'Impala'),
(203,'Accord'),
(204,'Toyota')
 
--Insert values into Manufacturer_t table--

Insert Into Manufacturer_t
(MId,ManufactureTitle)
values
(301,'Ford'),
(302,'Charry'),
(303,'Honda')

--Insert values into Car_t table--

Insert Into Car_t
(CarId,ModelId,MId,ManufactureYear)

Values 
(401,201,301,2015),
(402,202,302,2015),
(403,203,303,2014),
(404,202,303,2015)

--Insert values into Purchase_t table--

Insert Into Purchase_t
(PurchaseId,CustomerId,CarId,price,PurchaseDate,CarLoan,PaymentDate,PaymentTotal,CreditTotal)
Values
(501,101,401,5000000,'2023-01-01',0.50,'2023-02-13',200000,100000),
(502,102,402,5400000,'2023-03-01',0.60,'2023-05-01',100000,200000),
(503,103,403,6000000,'2023-01-02',0.60,null,null,100000),
(504,101,404,7000000,'2023-01-03',0.70,null,null,200000)


Insert into customer
Values
(101,'Jhon','Doe','555-1234'),
(102,'Jane','Smith','555-1235'),
(104,'Alish','Lee','555-1237')


---Insert New Value--

Insert into Customer_t
Values
(105,'Elish','Brown','555-1237')

                              ----UPDATE STATEMENT----

Update Customer_t set CustomerFName='Gorgia'
WHERE CustomerId=105

                              ----DELETE STATEMENT----

Delete from Customer_t
where CustomerId=105

                                ---- FETCH OFFSET---- 

Select * From Customer_t
Order by CustomerId ASC
OFFSET 1 rows
Fetch next 2 rows only

                                ----ALL/ANY/SOME----

---All---

SELECT CustomerId,price,CarLoan FROM Purchase_t WHERE price >ALL
(SELECT price FROM Purchase_t
WHERE price=5000000 )

----Any---

SELECT CustomerId,price,CarLoan FROM Purchase_t WHERE price >ANY
(SELECT price FROM Purchase_t
WHERE price=5000000 )

---Some--

SELECT CustomerId,price,CarLoan FROM Purchase_t WHERE price >Some
(SELECT price FROM Purchase_t
WHERE price=5000000 )

                              ----COMPARISION OPERATOR----

Select * from Customer_t
Where CustomerLName='LEE'

Select * From Purchase_t
Where PurchaseDate>'2023-01-01'

Select * From Purchase_t
Where PurchaseDate>='2023-01-01'

Select * From Purchase_t
Where CreditTotal<>0

                               ----LOGICAL OPERATOR----
---And--

Select * From Customer_t
Where CustomerId=103 AND CustomerLName='Lee'

---Or---
Select * From Customer_t
Where CustomerId=103 or CustomerLName='Lee'

---Not--

Select * From Customer_t
Where NOT  CustomerId=103   

                                 ----BETWEEN----

Select Title 'Car Model',price From Purchase_t p join Car_t  c 
on p.CarId=c.CarId
join CarModel_t cm 
On cm.ModelId=c.ModelId
Where price BETWEEN 5000000 and 6000000

                            ---LIKE OPERATOR---

Select * From Customer_t
Where CustomerFName like 'Fra%'

Select * From Customer_t
Where CustomerFName LIKE 'FR__k%'

Select * From Customer_t
Where CustomerFName NOT LIKE 'FR__k%'


                             ---- JOIN QUERY(INNER/OUTER/CROSS)----

-- Inner join query --

Select c.CustomerId, CustomerFName+' '+CustomerLName CustomerName,
Phone,Title CarBrand , ManufactureTitle,price
from Customer_t c Join Purchase_t p
On c.CustomerId=p.CustomerId
join Car_t ct on ct.CarId=p.CarId
join CarModel_t cm on ct.ModelId=ct.ModelId
join Manufacturer_t m on m.MId=ct.MId
where c.CustomerId=103 

--Outer join query with Order by --

Select * From CarModel_t Cm Left outer join Car_t c
On Cm.ModelId=c.ModelId
Order by c.ModelId 

--cross join--

Select * From CarModel_t Cm cross join Car_t c

-- join query to to show Manufacturer wise car information using Group By and Having Clause-- 

Select  m.ManufactureTitle,COUNT(c.CarId) AS number_of_cars 
From Car_t c join Manufacturer_t m 
on c.MId=m.MId  
Group by  m.ManufactureTitle
Having COUNT(c.CarId)>1

                         ----SUBQUERY/CO-RELATED QUERY----

       ---SUBQUERY TO FIND ALL THE INFORMATION OF SUPPLIER MODEL -ACCORD ---

SELECT *
FROM Manufacturer_t
WHERE MId = (SELECT MId FROM Car_t c join CarModel_t Cm On c.ModelId=Cm.ModelId
WHERE Title = 'Accord')
                      
                         ----CO-RELATED QUERY----

SELECT ManufactureTitle As Manufacturer
FROM Manufacturer_t m Join Car_t c
On m.MId=c.MId
WHERE EXISTS 
(SELECT * FROM Purchase_t p
WHERE p.CarId = c.CarId
AND Price > 5000000)

                      ---AGGREGATE WITH HAVING GROUP BY CLAUSE----

Select price ,Sum (price) As sumtotal,AVG(price) AvgPrice ,Count(PurchaseId) CountNo
From Purchase_t
Group by price
Having Count(PurchaseId)=1

                              ----SIMPLE CASE/SEARCH CASE---

                                   ----SIMPLE CASE----

Select ModelId,Title,
case ModelId
When 201 then 'Outstanding'
When 202 then 'Meets expectation'
When 203 then 'Exceeds expectation'
Else 'Electronic'
End As 'comment by users'

from CarModel_t

                             ----SEARCH CASE----   
                       
Select CustomerFName+' '+CustomerLName CustomerName,Title,price,
case 
When price<5500000
then 'Sceond hand car'
When price=6000000
then 'local Brand'
Else 'New model car'
End As 'car condition'
from Purchase_t p join Customer_t ct
on p.CustomerId=ct.CustomerId
join Car_t c On c.CarId=p.CarId
join CarModel_t cm on c.ModelId=cm.ModelId

                             ---CTE---

With T1 as
(Select CustomerId,CustomerFName+' '+CustomerLName customername,Phone 
from Customer_t),

T2 As
(Select T1.CustomerId,Count(T1.CustomerId) CountId From T1
Group by T1.CustomerId )

Select * From T1 Join T2
On T1.CustomerId=T2.CustomerId

                        ----ROLLUP - CUBE - GROUPING SETS---

---Rollup---

Select CustomerId,Count (*) as Membercount From Customer_t
Group by Rollup (CustomerId) 

---Cube---

Select CustomerId,Count (*) as Membercount From Customer_t
Group by Cube (CustomerId)

---grouping sets---

Select CustomerId,Count (*) as Membercount From Customer_t
Group by Grouping sets (CustomerId)


                         ------GROPING -----

Select  
Case 
When GROUPING(CustomerId)=101 Then 1 
Else CustomerId
End AS CustomerNo
From Customer_t 
Group by CustomerId With Rollup 
Order by CustomerId DESC
                    
					  -----EXISTS,NOT EXISTS----

---Exists---

Select * From CarModel_t
Where  EXISTS
(Select ModelId From Car_t
Where CarModel_t.ModelId= Car_t.ModelId)

---Not Exists---

Select ModelId,Title From CarModel_t
Where NOT  EXISTS
(Select ModelId From Car_t
Where CarModel_t.ModelId= Car_t.ModelId)

                        ---EXCEPT/UNION/INTERSECT--- 

                               ----EXCEPT----

Select 'High price' as SALE,price,PurchaseDate  From Purchase_t
WHERE   PurchaseDate='2023-01-02'
EXCEPT
Select 'Low price' as SALE,price,PurchaseDate From Purchase_t
WHERE PurchaseDate='2023-03-01'

                                 ----UNION----

Select 'High price' as SALE,price,PurchaseDate  From Purchase_t
WHERE  PurchaseDate='2023-01-02'
union
Select 'Low price' as SALE,price,PurchaseDate From Purchase_t
WHERE PurchaseDate='2023-03-01'

                                    ---INTERSECT---

Select CustomerId  From Customer_t
INTERSECT
Select CustomerId From Purchase_t


                          ----CONVERT - CAST - TRY CONVERT---- 

---Convert--

SELECT CONVERT(varchar,PurchaseDate,2)AS NewDate
FROM Purchase_t

---Cast--

SELECT price ,CAST(price AS int) NEWPRICE
FROM Purchase_t 

---TRY CONVERT---

Select TRY_CONVERT(varchar,PurchaseDate,1) As VarcharDate From Purchase_t

                 ---CHAR FUNCTION TO FORMAT OUTPUT---

Select CustomerFName+CHAR(13)+CHAR(10)+CustomerLName+CHAR(10) AS 'Full Name' From Customer_t

                           ---MERGE TABLE---

MERGE INTO Customer_t AS target
USING customer AS source
ON target.CustomerId = source.customerid
WHEN MATCHED THEN
UPDATE SET target.CustomerfName = source.CustomerfName,
target.CustomerlName = source.CustomerlName,
target.phone = source.phone
WHEN NOT MATCHED THEN
INSERT (customerid, CustomerfName,CustomerlName,phone)
VALUES (source.customerid, source.CustomerfName,source.CustomerlName, source.phone);

---justify---

Select * From Customer_t


                             ----CHOOSE/IFF---
							 
----CHOOSE----

Select ModelId,Title, CHOOSE(ModelId,'Fusion','Accord','Toyota') As Brand from CarModel_t

----IIF---

SELECT CarId,price,PurchaseDate,
SUM (price)AS TotalPrice,
IIF(SUM (price)>5000000,'GOOD QUALITY','POOR QUALITY') AS QUALITY
FROM Purchase_t
GROUP BY CarId,price,PurchaseDate

                          ----COALESCE/ISNULL---

----COALESCE---

Select PaymentDate, Coalesce(PaymentDate,'2020-02-20') as NewDate from Purchase_t 

----ISNULL---

Select PaymentDate,ISNULL(PaymentDate,'2023-01-03') as NewDate from Purchase_t 

                             ----RANK/DENSERANK----

Select Rank() over (Order by CustomerId) AS Rank,
DENSE_RANK() over (Order by CustomerId) AS DenseRank,
CustomerId,CustomerFName+' '+CustomerLName As CustomerName
From Customer_t 

                               ----NTILE FUNCTION----

Select CustomerId,CustomerFName+' '+CustomerLName As CustomerName,
NTILE(2) over (Order by CustomerId) As Title2,
NTILE(3) over (Order by CustomerId) As Title3,
NTILE(4)over (Order by CustomerId) As Title4
From Customer_t
                      
					           ---ANALYTICAL FUNCTION----

                         ----FIRST VALUE LAST VALUE FUNCTION----

Select Price, c.CustomerId,CustomerFName+' '+CustomerLName As CustomerName, 
FIRST_VALUE (CustomerFName+' '+CustomerLName) 
Over (Partition by price Order by price DESC) As HighestSales,
LAST_VALUE (CustomerFName+' '+CustomerLName) 
Over (Partition by price Order by price DESC 
Range Between Unbounded Preceding And Unbounded Following) As LowestSales
From Purchase_t p Join Customer_t c
On p.CustomerId = c.CustomerId

                                      ----LAG/LEAD---

---Lag---

SELECT PurchaseDate,price,
LAG(price, 1, 0) OVER (ORDER BY PurchaseDate) AS previousamount
FROM Purchase_t

---Lead---

SELECT PurchaseDate,price,
LEAD(price, 1, 0) OVER (ORDER BY PurchaseDate) AS previousamount
FROM Purchase_t

                                 ----PERCENTILE RANK---

Select CarId,Price,PERCENT_RANK()
over (Partition by price order by CarId) As PetRank
From Purchase_t

                        -----ERROR HANDLING WITH TRY CATCH----

BEGIN TRY
Select 1/0
END TRY
BEGIN CATCH
Print 'you can not divide by 0'
PRINT ERROR_MESSAGE()
PRINT ERROR_SEVERITY()
PRINT ERROR_STATE()
PRINT ERROR_LINE()
RAISERROR (16,1,1)
END CATCH

                              ---TRANSACTION----

Begin Tran
Declare @Price money,@paymenttotal Money,@credittotal money;
Select  @Price=price,@paymenttotal=PaymentTotal,@Credittotal=CreditTotal
from Purchase_t Where CarId=402
 
Update Purchase_t Set price=@Price,CreditTotal=@credittotal,
PaymentTotal=@Price-@credittotal,PaymentDate=getDate()
Where CarId=402

Commit Tran

 Select * From Purchase_t Where CarId=402
                               
							   ---CURSOR---

Create Table #Model 
(Id int,Name Varchar(20))
Insert Into #Model
Values 
(1,'Toyota'),
(2,'Ampula'),
(3,'Accord'),
(4,'Ford')

DECLARE @id int,@name Varchar (20)
DECLARE ModelCusor Cursor FOR
Select * From #Model

Open ModelCusor 
FETCH Next From ModelCusor Into @id,@name
WHILE (@@FETCH_STATUS=0)
BEGIN 
If @name<>'Ampula'
Insert Into CarModel_t  Values (@id,@name)
FETCH Next From ModelCusor Into @id,@name
END
Close ModelCusor
DEALLOCATE ModelCusor

                                   ----IF-ELSE----

DECLARE @Totalmoney Money
SET @Totalmoney=(Select Sum(price*CarLoan) Totalmoney From Purchase_t 
where CarId=402)
 
If @Totalmoney>0
Print'Total  Amount $'+Convert(Varchar,@Totalmoney,1);
Else 
Print 'No Value Found'
GO

                          ---DATE FUNCTION---

SELECT PurchaseDate,DATEPART(DAY,PurchaseDate) AS Day
FROM Purchase_t

SELECT PurchaseDate,DATEADD(MONTH,2,PurchaseDate) AS NewDate
FROM Purchase_t

SELECT PurchaseDate,DATEDIFF(YEAR,PurchaseDate,GETDATE()) AS YEARDIFF
FROM Purchase_t

SELECT PurchaseDate,DATEDIFF(DAY,PurchaseDate,GETDATE()) DayDifference
FROM Purchase_t

SELECT PurchaseDate,DATENAME(DAY,PurchaseDate) DAY
FROM Purchase_t

SELECT PurchaseDate,DATENAME(YEAR,PurchaseDate) YEAR
FROM Purchase_t

SELECT PurchaseDate,DATENAME(QUARTER,PurchaseDate) QUARTER
FROM Purchase_t

SELECT PurchaseDate,DATENAME(MONTH,PurchaseDate) 'MonthName'
FROM Purchase_t

SELECT ISDATE('2020-04-29') As isdate

Select EOMONTH(PurchaseDate) EndMonth From  Purchase_t

                             ---NUMERIC FUNCTION---

Select ROUND(13.6,0) As Roundnumber

Select IsNumeric (13.6) As Truenumber 
Select IsNumeric ('sornali') As Truenumber

Select ABS(-1.25) As AbsoluteNumber

Select CEILING(3.25) TopNumber

Select FLOOR(1.25) LowNumber

Select SQUARE(5.7) Square

Select SQRT(125) SquareRoot

Select Rand()

                           ----STRING FUNCTION----

Select LEN(CustomerFName) CountAlphabate From Customer_t

Select LEFT ('CustomerFName',2) 

Select LTRIM(CustomerFName) LtrimName From Customer_t

Select TRIM(CustomerFName) trimName From Customer_t
 
Select PATINDEX('%v_r%','sql server ') As 'Patindex'

Select CHARINDEX('_','Purchase_DB') As 'Charindex' 

                              ----GOTO----

DECLARE @Loop INT = 0;

PRINT 'Starting loop';

WHILE @Loop < 10
BEGIN
SET @Loop = @Loop + 1;
IF @Loop = 5
GOTO Label1;
PRINT @Loop;
END

Label1:
PRINT 'Jumped to Label1'

                                  ----WAIT FOR---

PRINT 'HELLO,GOOD DAY'
WAITFOR DELAY '00:00:03'
PRINT 'GOOD LUCK'
GO

                               ---View call---

--Justify--
Select * From vu_CustomerJhonDoeInformation

EXEC sp_helptext vu_CustomerJhonDoeInformation

Select * From vu_fulltableinformation

EXEC sp_helptext vu_fulltableinformation

Go

                            ---Procedure call---

--Justify--

EXEC spselectinertupdatedeleteprocedure1 'select','','',''
EXEC spselectinertupdatedeleteprocedure1 'Insert','205','TOYOTA',''
EXEC spselectinertupdatedeleteprocedure1 'Update','205','Hitachi',''
EXEC spselectinertupdatedeleteprocedure1 'Delete','205','Hitachi',''

Declare @Count Int
EXEC spselectinertupdatedeleteprocedure1 'Output','','',@Count Output
Print @count
Go

Declare @returnValue Int
EXEC @returnValue=spselectinertupdatedeleteprocedure1 'Return','','',''
Print @returnValue
Go

                               ---Function call---
--ScalarValuedfunction

---justify---
Print dbo.getDatedifferences('2023-01-01')
GO

---Table valuedfunction

---justify---
 
Select * From  CustomerWiseDetail(102)
Go


---Multiple Statement function

---justify---

Select * from fn_Purchesecar (404,1)

GO

                            ---Justify trigger---

--for insert

EXEC spselectinertupdatedeleteprocedure1 'Insert','205','TOYOTA',''

GO

--for update

Update CarModel_t Set Title='Accord' Where ModelId = 203
Go

--Instead of trigger

Insert Into CarModel_t  
Values
(205,'Audi')





-----------------------------------END--------------------------------------------------------








 

 










