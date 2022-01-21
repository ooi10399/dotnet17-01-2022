use dbViewspresentation



create table tblBoss
(bossID int identity(1,1) primary key,
bossName varchar(20),
salary int,
password varchar(20)
)

create table tblEmp
(empID int identity(1,1) primary key,
empName varchar(20),
salary int,
password varchar(20)
)

insert into tblEmp values('Alice',75000,'abcd123')
insert into tblEmp values('Ned',45000,'qwer123')
insert into tblEmp values('Andrew',25000,'asdf123')

insert into tblBoss values('Nathan',35000,'abcd1234')
insert into tblBoss values('Gerad',95000,'qwer1234')
insert into tblBoss values('Ken',65000,'asdf1234')

select* from tblBoss

select* from tblEmp

select* from viewInfo

--Create View
Create VIEW viewInfo AS 
select empName,password 
from tblEMP

--Update View
UPDATE viewInfo 
set password = 'jk123333'
FROM viewInfo
WHERE empName = 'Ned'

--Delete View
DROP View viewInfo;

DROP table tblEmp,tblBoss;

--Combine with 2 tables
Create VIEW viewInfo AS 
select bossName as name,salary,password 
from tblBoss
union
select empName as name ,salary,password 
from tblEMP







