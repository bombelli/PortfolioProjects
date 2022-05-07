---Background -- Evolution of Business Intelligence
---Data Development and Database Admin
---Report development
-- ETL - Extraction, Transformation, Load of data
---Analytics - reports, dashboard
---Data mining
---Data Warehouse
---Data Science
---Machine Learning & AI
---Ediscovery
---Data Privacy and data protection 
---Data Officer
---Cloud, Cyber Security
---Technology - Data
---Big Data
---Unstructure  data and Structure data
----Oracle, Microsoft, MySQL, Postgres
---Salary - $90,000 - mid 110,000, 120,000 plus
---Job ---

----Database Development  

---How to create tables
---Schema is like an organizer or container

----How to to get to a table
---3 part name - database - schema - table
select * from AdventureWorks2017.HumanResources.employee
select * from AdventureWorks2017.Person.Person
---* means give/display every column
----dbo is a default schedule 

---How to create a table
----Table name ---Employee
---Column name  ---FirstName
---Data type ---int, varchar/nvarchar(varied), char/nchar (fix),date,money
---Data Size (50)
---Not every data type needs a data size. eg int, date,money 
---Comment ---- /*dfadss*/
---Create table table name(column name data type, data size
Create table Students(StudentID int,FirstName varchar(30), LastName varchar(40), Gender char(1), BirthDate date)

----naming cons -- First_Name, firstName
select * from Students

---How insert data into a table

insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(1, 'John', 'Mensah', 'M', '12-25-1990')


insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(2, 'Mary', 'Ofori', 'F', '12-24-1999')

insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(3, 'Kofi', 'Owusu', 'M', '10-20-1998')

insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(4, 'Kofi', 'Fosu', 'M', '10-20-1995')


select * from students
---How to update a table

Begin Tran
Update students 
set LastName= 'Asare'
Where StudentID = 2 

rollback tran

select * from students

---How to delete a record
Begin tran
Delete Students
where StudentID = 4

---IN ---Use the IN keyword for multiple operation
Begin tran
Delete Students
where StudentID IN (2, 3)

---== Delete without a	WHERE clause vs Delete with a WHERE clause
----Truncate
---You cannot have a Where clause in a Truncate statement
Begin tran
Truncate table students 

----===Truncate vs Delete
---How to Drop a table 
begin tran
drop table students 
---Drop table drops the table structure and content
---Delete and truncate empties the content of a table but leaves the structure

rollback tran
alter table students add City varchar(30)

select * from students

begin tran
update students
set city= 'Ho' 
where studentid = 1

rollback

----Constraints - Primary Key, Foreign key, Not Null, Check, Unique
---Primary key uniquely identify a records. Every record will be unique. 
---PK does not allow NULL 
---NULL	is not empty, it also does not mean blank. Null means unknown
--PK does not allow duplicates
----You can only have one primary on a table 
insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(1, 'Kofi', 'Kwie', 'M', '11-20-1985')

drop table students 
Create table Students(StudentID int constraint pk_students primary key,FirstName varchar(30), LastName varchar(40), 
Gender char(1), BirthDate date)

insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(1, 'John', 'Mensah', 'M', '12-25-1990')

insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(2, 'Kojo', 'Sam', 'M', '12-25-1989')

insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(3, 'Esi', 'Esun', 'F', '12-25-1992')
select * from Students

---==Foreign Keys
---Foreign Key enforces referential integrity
----child/parent/orphan
----You don't want orphans in your database
---You can have multiple foreign keys on a table
drop table Registration 

Create table Students(StudentID int constraint pk_students primary key,FirstName varchar(30),
LastName varchar(40), Gender char(1), BirthDate date)

Create table Registration(RegistrationID char(4) constraint pk_Registration primary key, 
RegDate date, 
StudentID int constraint fk_Registration references Students(studentID), 
Degree varchar(20), 
Hall varchar(15))

select * from students
select * from Registration
---Multiple insert
insert into students(StudentID, FirstName, LastName, Gender, BirthDate)
values(4, 'Ama', 'Fynn', 'F', '12-25-1981'),
(5, 'Eric', 'Wilson', 'M', '10-25-1981'),
(6, 'Ama', 'Atta', 'F', '08-25-1994')

insert into Registration(RegistrationID, RegDate, StudentID, Degree, Hall)
Values('R001', '01/04/2019', 10, 'BA', 'Legon')

insert into Registration(RegistrationID, RegDate, StudentID, Degree, Hall)
Values('R001', '01/04/2019', 1, 'BA', 'Legon')

---No child without a parent will be allowed when there is a foreign key

begin tran
delete students where StudentID = 3

rollback

select * from STUDENTS
select * from Registration

insert into Registration(RegistrationID, RegDate, StudentID, Degree, Hall)
Values('R003', '02/06/2019', 1, 'BS', 'Commonwealth')


insert into Registration(RegistrationID, RegDate, StudentID, Degree, Hall)
Values('R005', '05/06/2021', 2, 'PhD', 'Commonwealth')

---===Queries and Joins
---Structure of a select statement
/*
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
*/

Select * from Registration 
order by RegistrationID desc

Select * from Registration 
order by RegDate desc

Select * from Registration 
order by RegDate asc

Select * from Registration 
where Degree = 'BS'
---IN
Select * from Registration 
where Degree IN ('BS','BA')

Select * from Registration 
where Degree IN ('BS','BA','Phd')

Select * from Registration 
where Degree = 'BS' and Degree = 'Phd'

---Group By
select StudentID, FirstName, LastName from students

----Aggregate function - Max, Min, Avg
----Sum, Count

select max(studentid) from students 
select min(studentid) from students 
---Alais

select count(*) as Totals from students 
select count(studentid) as Totals from students 
---Any column that is list in your select line that is not being used by an agregate function should be listed in you group by line
select gender, count(studentid) TotalbyGender from students 
group by gender 
select * from students 

----Where and Having in Group by
select jobtitle, count(BusinessEntityID) Total from AdventureWorks2017.HumanResources.Employee
where gender = 'f'
group by JobTitle
having count(BusinessEntityID)>1


Create table People(StudentID int identity constraint pk_people primary key,FirstName varchar(30),
LastName varchar(40), Gender char(1), BirthDate date)

insert into People(FirstName, LastName, Gender, BirthDate)
values('Ama', 'Fynn', 'F', '12-25-1981'),
('Eric', 'Wilson', 'M', '10-25-1981'),
('Ama', 'Atta', 'F', '08-25-1994')
select * From People 

select jobtitle, gender, count(BusinessEntityID) Total from AdventureWorks2017.HumanResources.Employee
group by JobTitle, gender
order by JobTitle

select jobtitle, gender, maritalstatus, count(BusinessEntityID) Total from AdventureWorks2017.HumanResources.Employee
group by JobTitle, gender, maritalstatus
order by JobTitle

-----Views
select * from students 
Create view vw_Students as
Select studentid, firstname, lastname from students 

select * from vw_Students

begin tran
update vw_Students set LastName='Afriye' where StudentID = 3

---Encryption 
Alter view vw_Students 
with encryption as
Select studentid, firstname, lastname from students 

Alter view vw_Students 
with schemabinding as
Select studentid, firstname, lastname, Gender from dbo.students 

alter table students drop gender 

---===View with Check Option

---Stored Procedure 
---CAST and CONVERT
---Varibles 
declare @a int, @b int
Set @a = 5
set @b = 20
select @a * @b 

declare @a varchar(30), @b varchar(20)
Set @a = 'Joe'
set @b = 'Oku'
select @a + ' ' + @b 


declare @a varchar(30), @b varchar(20)
Set @a = 'Joe'
set @b = 'Oku'
print @a + ' ' + @b 

declare @a varchar(30), @b varchar(20)
Set @a = 'Efua'
set @b = 'Amani'
print @a + ' ' + @b 

---stored procedure without a variable
create proc sp_student as
select * from students 

Exec sp_student

---Store procedures with variable/parameter

create proc sp_employee1 @id int
as
begin
select firstname, lastname from students 
where StudentID = @id
end

Exec sp_employee1 1

Exec sp_employee1 4

select firstname, lastname from students 
where StudentID = 3

create proc sp_student2 @first varchar(30), @last varchar(30), @DOB date
as
begin
select firstname, lastname from students 
where FirstName= @first and LastName = @last and BirthDate= @DOB 
end

exec sp_student2  'john','mensah','1990-12-25'

---===Join ---Inner Join, Left Join, Right Join, Cross Join
select * from Students 

Select * from Registration
---Inner join returns matching records
---To jon two tables you need a common column

select * from Students 
Select * from Registration

Select * from Students 
inner join Registration
on Students.StudentID=Registration.StudentID


Select * from  Registration
inner join  Students
on Students.StudentID=Registration.StudentID

Select * from Students s
inner join Registration r
on s.StudentID=r.StudentID

---Left Outer Join
----Left returns ALL the records in the table on the left and then their matching records from the table on the right.
select * from Students 
Select * from Registration

Select * from Students 
left outer join Registration
on Students.StudentID=Registration.StudentID

----Right join returns ALL records in the table on the right and their matching records in the table on the left
select * from Students 
Select * from Registration

Select * from Students 
right outer join Registration
on Students.StudentID=Registration.StudentID


select * from Students 
Select * from Registration

Select * from Students 
left outer join Registration
on Students.StudentID=Registration.StudentID
where Registration.StudentID is null

select * from Students 
Select * from Registration

Select * from Students 
left outer join Registration
on Students.StudentID=Registration.StudentID
where Registration.StudentID is not null


select * into registration2 from Registration 

select * from registration2

insert into Registration2(RegistrationID, RegDate, StudentID, Degree, Hall)
Values('R006', '02/06/2019', 10, 'BS', 'Legon')


insert into Registration2(RegistrationID, RegDate, StudentID, Degree, Hall)
Values('R007', '05/06/2021', 20, 'PhD', 'Sabah')

select * from Students 
Select * from Registration2

Select * from Students 
right outer join Registration2
on Students.StudentID=Registration2.StudentID

create view vwstudRegis as
Select s.StudentID, FirstName,LastName, Degree from Students s
inner join Registration r
on s.StudentID=r.StudentID


select * from vwstudRegis

----CTE --Common table Expression
With mycte as
(
Select BusinessEntityID, JobTitle, 
ROW_NUMBER() OVER(PARTITION BY JobTitle ORDER BY JobTitle DESC) 
  AS Row1  
,ROW_NUMBER() OVER(ORDER BY JobTitle DESC) AS Row,
Gender, SickLeaveHours
from AdventureWorks2017.HumanResources.Employee )
select * from mycte 
where Row1 >1

----Data Warehouse a repository for hitorical data
---Tables in data warehouse are usually denormalized 
----Dim - Dimension --descriptive attibutes -- firstname, lastname, location, 
---Fact - Measures ---columns you can aggregate eg sales, tax, profit
----Multi dimensional tables - Dim and Fact
----Star schema -- fact table is connected	DIRECTLY to dimesion tables

---ETL
---Migrate employee table in Adventurewowks to Employee in UG database
Create table Employee(EmployeeID int, Title varchar(30), Sex char(1), SickLeave int, DateLoaded date, FirstName varchar(80), LastName varchar(80), FullName varchar(200))
drop table employee
select * from employee

select getdate() 

Truncate table employee

select e.BusinessEntityID, JobTitle, Gender, FirstName, LastName, MaritalStatus, BirthDate 
from AdventureWorks2017.HumanResources.Employee e
join AdventureWorks2017.Person.Person p
on e.BusinessEntityID=p.BusinessEntityID

select  FirstName + ' ' + LastName from AdventureWorks2017.Person.Person 

select distinct jobtitle from AdventureWorks2017.HumanResources.Employee 

Create table Employee(EmployeeID int primary key, FirstName varchar(80), LastName varchar(80), Gender char(10),  [State] char(2))

Create table EmployeeStage(EmployeeID int, FirstName varchar(80), LastName varchar(80), Gender char(10),  [State] char(2))

Create table EmployeeHist(EmpHistID int identity primary key, EmployeeID int, FirstName varchar(80), LastName varchar(80), Gender char(10),  [State] char(2))

select * from employee
select * from EmployeeStage
select * from EmployeeHist order by EmployeeID

Truncate table employee
Truncate table EmployeeStage
Truncate table EmployeeHist


select e.Employeeid, e.firstname, e.lastname, e.gender, e.state 
from employee e
left join employeehist h
on e.EmployeeID=h.EmpHistID
where h.EmployeeID is null

update e
set e.firstname=s.firstname, e.lastname=s.lastname, e.gender=s.gender, e.state =s.state
from employee e
inner join EmployeeStage s
on e.EmployeeID=s.EmployeeID 

insert into EmployeeHist
select Employeeid, firstname, lastname, gender, state 
from EmployeeStage 


select e.BusinessEntityID, FirstName, LastName, JobTitle, Gender, MaritalStatus, SickLeaveHours,VacationHours, BirthDate 
from AdventureWorks2017.HumanResources.Employee e
join AdventureWorks2017.Person.Person p
on e.BusinessEntityID=p.BusinessEntityID
where JobTitle=@JT

select distinct JobTitle from AdventureWorks2017.HumanResources.Employee 