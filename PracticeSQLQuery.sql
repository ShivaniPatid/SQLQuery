---------- create database-----
CREATE DATABASE PersonDB;


---------- create a table--------

create table Person
(
	PersonId int primary key identity(1,1),
	FirstName varchar(255),
	LastNAme varchar(255),
	Address varchar(255),
	City varchar(255)
)

-------insert data--------
insert into Person values('Pratiksha','Gome','Street 5','Shajapur'),
							('Kushal','Patidar','Street 4','Indore'),
							('Roanak','Sharma','Street 3','Shajapur')

select * from Person

----select distinct query--------
select distinct city from Person

-----where clause
select * from Person 
where City = 'Ujjain';

------- AND----
select * from Person
where Address = 'Street 2' AND City = 'Ujjain';

----- OR --------
select * from Person
where City = 'Shajapur' OR City = 'Ujjain';

------ NOT ------
select * from Person
where NOT City = 'Ujjain';

-------- ORDER BY ---------
----- ascending order------
select * from Person
order by FirstName;

-------- ORDER BY ---------
---------decending order--------
select * from Person
order by FirstName DESC;

----- update query-----
update Person set Address = 'Street 5', City = 'Indore'
where PersonId = 3

-------Delete query---------
delete from Person
where PersonId = 6

--------- select top query--------
select top 3 * from Person

select top 30 PERCENT * from Person

-------- create product table------
create table Product
(
	ProductId int primary key identity(1,1),
	ProductName varchar(255),
	Price int
)

--------inset data in product table--------
insert into Product values('Book',300),
						('Furnitre',1000),
						('Table',700),
						('Fan',1500),
						('Cooler',2000)

select * from Product

-------MIN() function---------
select MIN(Price) as SmallestPrice
from Product

-------MAX() function---------
select MAX(Price) as LargestPrice
from Product

-------Count()function-------
select Count(ProductId) as CountId
from Product

-------Avg()function-------
select Avg(Price) as Average
from Product

-------Sum()function-------
select sum(Price) as TotalSum
from Product

----------- Like Operator-------
select * from Person
where City Like 'U%';

select * from Person
where City Like '%n';

select * from Person
where City Like '%OR%';

select * from Person
where City Like '_n%';

select * from Person
where FirstName Like 'R__%';

select * from Person
where City Like 'u%n';

select * from Person
where City not Like 'u%';

select * from Person
where City  Like '[u-i]%';

select * from Person
where City  Like '[!u-i]%';

---------IN operator------
select * from Person
where City  IN ('Ujjain','Shajapur');

--------- NOT IN operator------
select * from Person
where City NOT IN ('Ujjain','Shajapur');

------- BETWEEN Operator------ 
select * from Product
where Price BETWEEN 700 AND 2000

------- NOT BETWEEN Operator------ 
select * from Product
where Price NOt BETWEEN 700 AND 1500

---------BETWEEN with IN------------
select * from Product
where Price BETWEEN 700 AND 1500
AND ProductId NOT IN (1,2)

-----BETWEEN Text Values------
select * from Person
where FirstName BETWEEN 'Keldeep' AND 'Rajat'
order by FirstName

-----NOT BETWEEN Text Values------
select * from Person
where FirstName NOT BETWEEN 'Keldeep' AND 'Rajat'
order by FirstName

-----------Alias for Columns ---------
select PersonId as ID, firstName as Name
from Person

select PersonId, firstName , LastName, Address + ', ' +City as Address
from Person

--------inner join-------
select a1.AddressId, a1.FullAddress, a1.City, a1.state, a1.userId, a2.typeId
		from AddressTable a1 inner join AddressTypeTable a2 
		on a1.TypeId = a2.TypeId


--------------left join-----------
select c.CartId, c.Quantity, c.UserId, b.bookName, b.AuthoreName, b.BookImage,
		b.OriginalPrice, b.DiscountPrice from Cart c 
		left join Books b on c.BookId = b.BookId	

		--------right join----------
select w.wishlistId, w.userId, w.BookId, 
		b.BookName, b.AuthoreName, b.BookImage, b.originalPrice, b.DiscountPrice
		from Wishlist w right join Books b on 
		w.BookId = b.BookId

--------full outer join--------
select f.FeedbackId, f.Comment, f.Rating, f.BookId, u.UserID
		from FeedbackTable f full outer join Users u
		on f.UserId = u.UserId

-----self join-------
select f.feedbackid, u.fullname
from Users u, FeedbackTable f
where u.UserId <> f.UserId

----------- UNION Operator--------
select Quantity from Books
UNION
select Quantity from Cart

----------- UNION Operator--------
select Quantity from Books
UNION ALL
select Quantity from Cart

----------- Group by statement--------
select count(PersonId) as CountID, City from Person
 GROUP BY City

 select count(PersonId) as CountID, City from Person
 GROUP BY City
 Order by count(PersonId) DESC;

 select MIN(Price) as MinPrice, ProductName from Product
 GROUP BY ProductName
 order by min(price) 

 select MAX(Price) as MaxPrice, ProductName from Product
 GROUP BY ProductName
 order by MAX(price)  DESC;


 --------HAVING Clause-------
 select COUNT(PersonId), City from Person
 Group by City
 Having count(PersonId) > 1;

 select count(personId), city from Person
 Group by City
 Having COUNT(PersonId) > 1
 order by COUNT(PersonId) DESC;

 -------EXISTS Operator----------
 select BookName from Books
 where EXISTS(Select Rating, Comment from FeedbackTable where Books.BookId = FeedbackTable.BookId AND Rating > 3)

  select BookName from Books
 where EXISTS(Select Rating, Comment from FeedbackTable where Books.BookId = FeedbackTable.BookId AND Rating = 5)


----------- Any operator-------
select BookName from Books
where bookid = any( select BookId from OrderTable where BookQuantity = 2);

select BookName from Books
where bookid = any( select BookId from OrderTable where BookQuantity >= 1);

select BookName from Books
where bookid = any( select BookId from OrderTable where BookQuantity > 3);

--------ALL Operator---------
select BookName from Books
where BookId = ALL
( select BookId from OrderTable where BookQuantity = 2);


--------- select into(copies data from one table into a new table.)--------
select * into PersonBackup
from Person

select * from PersonBackup

 select FirstName, LastNAme, City into PersonBackup2 
 from Person

 select * from PersonBackup2

 ----CASE Expression---

 select ProductId, ProductName, Price,
 CASE
	WHEN Price > 700 THEN 'The price is greater then 700'
	WHEN Price = 700 THEN 'The price is 700'
	ELSE 'The price is under 700'
END AS PriceText
From Product

----------- stored procedure-------
create procedure AddPersonData
(
	@FirstName varchar(255),
	@LastName varchar(255),
	@Address varchar(255),
	@City varchar(255)
)
AS
BEGIN
	insert into Person (FirstName, LastNAme, Address, City)
	values (@FirstName, @LastName, @Address, @City)
END

--------CREATE INDEX Statement--------
create index idx_Person
on Person(firstName, LastNAme);

--------DROP INDEX Statement--------

drop index person.idx_Person

----CREATE VIEW --------
create view [Indore Person] AS 
select * from Person
where City = 'Ujjain';

select * from [Indore Person];


create view [Product Above Average Price] AS
select ProductName, Price from Product
where price > (select avg(price) from Product);

select * from [Product Above Average Price]


--------Exception handling---------
---An error condition during a program execution is called an exception and the mechanism for resolving such an exception is known as exception handling.
---Types of SQL Server Exceptions

--SQL Server contains the following two types of exceptions:
-- 1. System Defined
-- 2. User Defined

BEGIN TRY
	SELECT 
		1 / 0 As error;
END TRY
BEGIN CATCH 
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_STATE() as ErrorState,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO


-----System Defined Exception
Declare @val1 int;
Declare @val2 int;
BEGIN TRY
Set @val1 = 5;
set @val2 = @val1/0; /* Error occur here */
END TRY
BEGIN CATCH
Print 'Error Occur that is : '
Print Error_Message()
END CATCH

---User Defined Exception
Declare @a int;
Declare @b int;
BEGIN TRY
Set @a = 8;
set @b = @a/2;
if @a = 1
Print 'Error Not Occour'
else
Begin
Print 'Error Occur';
Throw 60000, 'Number Is Even', 5
End

END TRY
BEGIN CATCH
Print 'Error Occur that is : '
Print Error_Message()
END CATCH

----- create procedure with exception handling
CREATE PROCEDURE GetErrorInfo  
AS  
SELECT  
    ERROR_NUMBER() AS ErrorNumber,  
    ERROR_SEVERITY() AS ErrorSeverity, 
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,  
    ERROR_LINE() AS ErrorLine,  
    ERROR_MESSAGE() AS ErrorMessage;  
GO  
  
BEGIN TRY  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    EXECUTE GetErrorInfo;  
END CATCH;  


--------Trigger----------
--A trigger is a special type of stored procedure that automatically runs when an event occurs in the database
-- server. DML triggers run when a user tries to modify data through a data manipulation language (DML) event. 
-- DML events are INSERT, UPDATE, or DELETE statements on a table or view. 

-- Types of SQL Server Triggers
-- We can categorize the triggers in SQL Server in mainly three types:

-- 1. Data Definition Language (DDL) Triggers
-- 2. Data Manipulation Language (DML) Triggers
-- 3. Logon Triggers

CREATE TABLE Employee  
(  
  Id INT PRIMARY KEY,  
  Name VARCHAR(45),  
  Salary INT,  
  Gender VARCHAR(12),  
  DepartmentId INT  
)  

INSERT INTO Employee VALUES (1,'Steffan', 82000, 'Male', 3),  
(2,'Amelie', 52000, 'Female', 2),  
(3,'Antonio', 25000, 'male', 1),  
(4,'Marco', 47000, 'Male', 2),  
(5,'Eliana', 46000, 'Female', 3)  

select * from Employee

CREATE TABLE Employee_Audit_Test  
(    
Id int IDENTITY,   
Audit_Action text   
)  


--create a trigger that stores transaction records of each insert operation

CREATE TRIGGER trInsertEmployee   
ON Employee  
FOR INSERT  
AS  
BEGIN  
  Declare @Id int  
  SELECT @Id = Id from inserted  
  INSERT INTO Employee_Audit_Test  
  VALUES ('New employee with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is added at ' + CAST(Getdate() AS VARCHAR(22)))  
END  

INSERT INTO Employee VALUES (6,'Peter', 62000, 'Male', 3)  

select * from Employee_Audit_Test


---create another trigger to store transaction records of each delete operation

CREATE TRIGGER trDeleteEmployee   
ON Employee  
FOR DELETE  
AS  
BEGIN  
  Declare @Id int  
  SELECT @Id = Id from deleted  
  INSERT INTO Employee_Audit_Test  
  VALUES ('An existing employee with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is deleted at ' + CAST(Getdate() AS VARCHAR(22)))  
END  

DELETE FROM Employee WHERE Id = 2;  


select * from Employee_Audit_Test