use master
create database day3Assignment

--13)Create the following tables

----Employee(id-identity starts in 100 inc by 1,Name,age, phone cannot be null, gender)
create table tblEmp
(empID int identity(100,1) primary key,
empName varchar(20),
age int,
phone int not null,
gender varchar(5))

----Salary(id-identity starts at 1 increments by 100,Basic,HRA,DA,deductions)
create table tblSalary
(salaryID int identity(1,100) primary key,
basic int,
hra int,
da int ,
deduction int)

----EmployeeSalary(transaction_number int,employee_id-reference Employee's Id 
---- Salary_id reference Salary Id,Date)
create table tblEmployeeSalary
(transaction_num int primary key,
empID int references tblEmp(empID) unique,
salaryID int references tblSalary(salaryID) unique,
date Date unique)
-----PS - In the emeployee salary table transaction number is the primary key
----the combination of employee_id, salary_id and date should always be unique

---Add a column email-varchar(100) to the employee table
alter table tblEmp
add email varchar(100)

---Insert few records in all the tables
insert into tblEmp values(103,'Max',25,90875665,'Male','abc@yahoo.com')
insert into tblEmp values(153,'Ruby',35,90872332,'Female','abc@gmail.com')
insert into tblEmp values(132,'Ken',45,90871991,'Male','abc@hotmail.com')

insert into tblSalary values(300,3200,5000,340,100,200)
insert into tblSalary values(500,2200,7000,900,300,100)
insert into tblSalary values(600,6200,9000,600,900,300)

insert into tblEmployeeSalary values(1,103,300,'2017-06-15')
insert into tblEmployeeSalary values(2,153,500,'2017-06-15')
insert into tblEmployeeSalary values(3,153,600,'2017-07-15')

---Create a procedure which will print the total salary of employee by taking the employee id and the date
----total = Basic+HRA+DA-deductions

create proc proc_totalSalary(@empID int, @date Date)
as 
begin
	Declare
	@total int,
	@basic int,
	@hra int,
	@da int,
	@d int
	set @basic = (select basic from tblEmployeeSalary es
					join tblEmp e on e.empID = es.empID
					join tblSalary s on s.salaryID = es.salaryID
					where empID = @empID)

	set @hra = (select hra from tblEmployeeSalary es
					join tblEmp e on e.empID = es.empID
					join tblSalary s on s.salaryID = es.salaryID
					where empID = @empID)
	set @da = (select da from tblEmployeeSalary es
					join tblEmp e on e.empID = es.empID
					join tblSalary s on s.salaryID = es.salaryID
					where empID = @empID)
	set @d = (select deduction from tblEmployeeSalary es
					join tblEmp e on e.empID = es.empID
					join tblSalary s on s.salaryID = es.salaryID
					where empID = @empID)
	set @total = @basic+@hra+@da-@d
	print 'Total Salary: ' + cast(@total as varchar(20))
end



---Create a procudure which will calculate the average salary of an employee taking his ID
create proc proc_avgSalary(@empID int)
as 
begin
	Declare
	@salary int,
	@basic int,
	@hra int,
	@da int,
	@d int,
	@avg int,
	@countTotal int,
	@c int
	set @countTotal = (select count(empID) from tblEmployeeSalary group by empID)
	set @c = 0
		while(@c<(@countTotal+1))
		begin 
			set @basic = (select sum(s.basic) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)

			set @hra = (select sum(s.hra) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)
			set @da = (select sum(s.da) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)
			set @d = (select sum(s.d) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)
			set @salary = @basic+@hra+@da-@d
			set @c = @c +1
		end
		set @avg = @salary/@countTotal
		print 'Average Salary: ' + cast(@avg as varchar(20))
end
	 


---Create a procedure which will catculate tax payable by employee
----Slabs as follows
----total - 100000 - 0%
----100000 > total < 200000 - 5%
----200000 > total < 350000 - 6%
----total > 350000 - 7.5%
create proc proc_calcTax(@empID int)
as 
begin
	Declare
	@salary int,
	@basic int,
	@hra int,
	@da int,
	@d int,
	@avg int,
	@tax float,
	@countTotal int,
	@c int
	set @countTotal = (select count(empID) from tblEmployeeSalary group by empID)
	set @c = 0
		while(@c<(@countTotal+1))
		begin 
			set @basic = (select sum(s.basic) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)

			set @hra = (select sum(s.hra) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)
			set @da = (select sum(s.da) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)
			set @d = (select sum(s.d) from tblEmployeeSalary es
							join tblEmp e on e.empID = es.empID
							join tblSalary s on s.salaryID = es.salaryID
							group by e.empID)
			set @salary = @basic+@hra+@da-@d
			set @c = @c +1
		end
		if (@salary <= 100000)
			set @tax = @salary
		else if(@salary <= 200000)
			set @tax = @salary*(5/100)
		else if(@salary <= 350000)
			set @tax = @salary*(6/100)
		else
			set @tax = @salary*(7.5/100)
		print 'Tax Payable: ' + cast(@tax as varchar(20))
end

--14) Create a function that will take the basic,HRA and da returns the sum of the three
create function fn_sum(@basic float, @da float, @hra float)
returns float
as
begin
	Declare
	@total float,
	set @total = @basic + @da + @hra
	return @total
end

--15) Create a cursor that will pick up every employee and print his details (difficult,cannot make it, need more time pls~)
---then print all the entries for his salary in the employeesalary table. 
---Also show the salary splitt up(Hint-> use the salary table)
use pubs

declare 
DECLARE cur_emp CURSOR FOR select * from employee

OPEN cur_emp

FETCH NEXT FROM cur_emp INTO 

while(@@FETCH_STATUS =0)
begin

	   declare @amount float, @status varchar(20)
	   
   FETCH NEXT FROM cur_emp INTO 
end

CLOSE cur_emp
DEALLOCATE cur_emp

