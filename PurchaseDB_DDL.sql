/*                           
						    SQL Project Name : PurchaseDB-DDL
							    
						    	 
----------------------------------------------------------------------------------------------

Table of Contents: DDL
			‣ SECTION 01: CREATE  A DATABASE PurchaseDB
			‣ SECTION 02: CREATE APPROPRIATE TABLES WITH COLUMN DEFINATION RELATED TO THE project
			‣ SECTION 03: CREATE CLUSTERED AND NONCLUSTERED INDEX
			‣ SECTION 04: CREATE A VIEW 
			‣ SECTION 05: CREATE STORED PROCEDURE 
			‣ SECTION 06: CREATE FUNCTION(SCALER VALUED FUNCTION , TABLE VALUED FUNCTION ,MULTISTATEMENT FUNCTION)
			‣ SECTION 07: CREATE TRIGGER (FOR/AFTER TRIGGER)
			‣ SECTION 08: CREATE TRIGGER (INSTEAD OF TRIGGER)
			‣ SECTION 09: CREATE SEQUENCE & ALTER SEQUENCE
			‣ SECTION 10: ALTER, DROP AND MODIFY TABLES & COLUMNS 
			
----------------------------------------------------------------------------------------------*/
			
                            ----CREATE DATABASE----

Use master
Go
IF DB_ID('PurchaseDB') Is Not Null
Drop database purchaseDB
GO
Create Database PurchaseDB
On
(name=purchase_Data_1,
FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\purchase_Data_1.mdf', 
Size=25mb,Maxsize=100mb,fileGrowth=5%
)
Log On
(name=purchase_Log_1,
FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\purchase_Log_1.ldf', 
Size=25mb,Maxsize=25mb,fileGrowth=1%)

Use PurchaseDB
GO
                           ---- CREATE TABLE ---- 

CREATE Table Customer_t

(CustomerId Int Primary Key nonclustered not null,
CustomerFName Varchar (10) Not null,
CustomerLName  Varchar (10) Not null,
Phone Varchar (11) Not null)


Create Table CarModel_t

(ModelId Int primary Key Not Null,
Title Varchar (10) Not NULL )


Create Table Manufacturer_t
(MId Int Primary Key not null,
ManufactureTitle Varchar (10) not null)


Create Table Car_t

(CarId int primary key not null,
 ModelId int not null References CarModel_t(ModelId),
 MId int Not null References Manufacturer_t (MId),
 ManufactureYear int not null )


Create Table Purchase_t

(PurchaseId Int Primary key not null,
CustomerId Int Not NUll References Customer_t (CustomerId),
CarId Int Not null References Car_t(CarId),
price Money Not null,
PurchaseDate Date Not null,
CarLoan Decimal (18,2) Not Null,
PaymentDate Date ,
PaymentTotal money ,
CreditTotal money )


                            ----CREATE INDEX----

---- CREATE CLUSTER INDEX ----

Create Clustered Index ix_Customerdb On Customer_t (CustomerFName)

--Justify--
EXEC sp_helpindex Customer_t

 ----CREATE NON CLUSTER INDEX----

Create NonClustered Index ix_nonclusterindex On CarModel_t (Title)

---justify---
EXEC sp_helpindex CarModel_t

                           ----CREATE VIEW----

GO

Create View vu_CustomerJhonDoeInformation
With Encryption,Schemabinding
As

Select  Ct.CustomerId,
CustomerFName+' '+CustomerLName as CustomerName,
Phone 'Customer phone',Title 'Car Model',price 'Car Price',
CarLoan*price 'Car loan',PurchaseDate,
DATEADD(MONTH,2,PurchaseDate) 'Delivery Date'

From  dbo.Purchase_t Pt 
Join dbo. Customer_t Ct on Pt.CustomerId=Ct.CustomerId
Join dbo. Car_t c On c.CarId=Pt.CarId
Join dbo. CarModel_t Cm On Cm.ModelId=c.ModelId
join dbo. Manufacturer_t Mt on Mt.MId=c.MId
Where CustomerFName='Jhon' and CustomerLName='Doe'
GO

                ---VIEW FOR SHOW FULL TABLE INFORMATION----

Create View vu_fulltableinformation
With Encryption,Schemabinding
As
Select  Ct.CustomerId,
CustomerFName+' '+CustomerLName as CustomerName,
Phone 'Customer phone',Title 'Car Model',ManufactureTitle Make , price 'Car Price',
CarLoan*price 'Car loan',PurchaseDate,
DATEADD(MONTH,2,PurchaseDate) 'Delivery Date After 2 months'

From  dbo.Purchase_t Pt 
Join  dbo.Customer_t Ct on Pt.CustomerId=Ct.CustomerId
Join  dbo.Car_t c On c.CarId=Pt.CarId
Join  dbo.CarModel_t Cm On Cm.ModelId=c.ModelId
join  dbo.Manufacturer_t Mt on Mt.MId=c.MId

GO

                          ---CREATE PROCEDURE---

Create Proc spselectinertupdatedeleteprocedure1

@statement varchar(10) = '',
@ModelId Int ,
@Title Varchar (12),
@CarModelcount Int OutPut
AS
Begin 

---Selecting using stored procedure---

If @statement='Select'
Begin 
Select * FROM CarModel_t
End 

--- insert using stored procedure with error handling--- 

If @statement='Insert '
BEgin 
Begin Try
Begin Transaction
Insert Into CarModel_t
(ModelId,Title)
Values
(@ModelId,@Title)
Commit Transaction
End Try

Begin Catch 
select ERROR_MESSAGE() As Errormassge,
ERROR_LINE() As ErrorLinr,
ERROR_SEVERITY()As ErrorSeverity
RollBack Transaction
End Catch

End

----Updating values using stored procedure-----

If @statement='Update'
Begin 
Update CarModel_t Set Title=@Title
WHERE ModelId=@ModelId
End

---Deleting values using stored procedure---

If @statement='Delete'
Begin 
Delete From CarModel_t
Where ModelId=@ModelId
End

---Output values using stored procedure---

If @statement='Output'
Begin
Select @CarModelcount=Count(ModelId) From CarModel_t Output
End

---Return values using stored procedure---

If @Statement='Return'
Declare @return Int
Begin
Select @return= Count(ModelId) From CarModel_t
Return @return
End

End


GO
                    ---CREATE FUNCTION---

---Single valued function-- 

Create Function getDatedifferences(@PurchaseDate Date)
Returns Int
As
Begin 
Return (Select DATEDIFF(DAY,PurchaseDate,Getdate()) From Purchase_t
Where PurchaseDate=@PurchaseDate)
End
Go

---Table valued Function---

Create Function CustomerWiseDetail(@CustomerId Int)
Returns Table 
return 
Select CustomerId,
CustomerFName+' '+CustomerLName 'Customer Name',
Phone 'Customer Phone'
From Customer_t
Where CustomerId=@CustomerId
GO

---Multiple Statement function---

Create Function fn_Purchesecar(@carId Int,@Carloan Decimal)
Returns @carpriceWithCarloan Table 
(CarId Int,Price money,Carloan money)
Begin 
Insert Into @carpriceWithCarloan
Select CarId,Price,CarLoan from Purchase_t 
Update @carpriceWithCarloan Set Carloan=(@Carloan*100)
Return
End
Go


                               ----CREATE TRIGGER----


---Trigger for Insert---

Create Trigger CarmodelForInsert
On CarModel_t
For Insert 
AS
Declare @Id Int,@ModelName VArchar (10);
Select @Id=ModelId, @ModelName=Title From inserted
If @ModelName<>'Title'
Begin
Raiserror ('Production Is off',11,1)
RollBack
END

----Trigger for update---

Create Trigger Tr_CarModelUpdateTrigger
On CarModel_t
For Update
AS
Declare @OldModelName Varchar (10),@NewModelName Varchar(10)
Select @OldModelName=Title From deleted
Select @NewModelName=Title From inserted
If @NewModelName=@OldModelName
Begin
Raiserror ('This Model Already Exist',1,1)
Rollback
End
GO

---Instead of Trigger---

Create table Carmodel
(Id int not null,Model Varchar(10)  null)
GO

Create table logs
(Insertion varchar (20),DateOfinsertion Date)
GO

Create Trigger CarModelInsert
On CarModel_t
Instead Of Insert
As
Begin
Insert Into Carmodel
Select * From inserted
Insert Into Logs
values
('Inserted',Getdate())
End

GO

                            ---CREATE SEQUENCE---

CREATE Sequence purchasedbsq
As int
Start with 100
Increment by 5
Minvalue 0 Maxvalue 10000
Cycle Cache 10

---customer table for drop/alter statement---

Create table customer
(customerid int not null,
CustomerfName varchar (20) not null,
CustomerlName varchar(10) null,phone Varchar(11))

                               ---DROP STATEMENT---

Drop Database PurchaseDB

Drop table customer

Drop View vu_fulltableinformation

Drop index  ix_Customerdb On Customer_t 

Drop Proc spselectinertupdatedeleteprocedure1

Drop Function fn_Purchesecar


--Drop a column in a table--

Alter table customer 
Drop column phone

                             ----ALTER STATEMENT----

Alter Table customer with nocheck 
Add LastDate Date null

Alter Table customer 
Alter column phone Varchar(12)


------------------------------------END------------------------------------------------------




