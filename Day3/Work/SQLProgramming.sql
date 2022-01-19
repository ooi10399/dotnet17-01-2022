use Northwind

-- if else, print, set variable
begin
declare
	@num int,
	@dob datetime,
	@name varchar(20),
	@score int
	set @dob = '1982-10-19'
	set @num = 100
	set @score = 100
	set @name = 'Max'
	print 'Hello ' + @name
	print @score
	if(@score>70)
		print'Pass'
	else
		print'Fail'
	print'My Date of birth is '+ cast(@dob as varchar(20))
end

--while loop
--more than one stement need this
begin 
declare
	@count int
	set @count = 0
		while(@count<10)
		begin --more than one stement need this
			print @count
			set @count = @count +1
		end
end

--Function
create procedure proc_FirstProcedure
as
begin
	print 'Hello from procedure'
end
--call the function
exec proc_FirstProcedure

--Function with variable
create proc proc_PrintResult(@score int)
as
begin
	if(@score>70)
		print'Pass'
	else
		print'Fail'
end
--call the function
exec proc_PrintResult 80

--use alter after createed which is run b4 , eddited the function 
alter proc proc_PrintResult(@score int,@name varchar)

--Assign variable to the function output
	--function
create proc proc_calculate(@amount float,@tax float out)
as
begin
	print 'Calculating......'
	set @tax = @amount*10.2/100
	print 'Done'
end
	--Assign part
declare @giventax float
exec proc_calculate 10000, @giventax out
print @giventax


--Combining above to statement
select * from [Order Details]
alter proc proc_PrintPayable(@OrderNumber varchar(5))
as
begin
	Declare
	@CustName varchar(20),
	@Gross float,
	@discount float,
	@fright float,
	@netPrice float
	set @CustName = (select ContactName from customers where CustomerID
					=(select CustomerID from Orders where OrderID = @OrderNumber))
	print 'Hello ' + @CustName
	set @Gross = (select sum(unitprice*quantity) from [Order Details] where OrderID = @OrderNumber)
	set @discount = (select sum(Discount) from [Order Details] where OrderID = @OrderNumber)
	if(@discount>0)
		set @Gross = @Gross -  (@Gross*@discount/100)
	set @fright = (select Freight from Orders where OrderID = @OrderNumber)
	set @netPrice = @Gross + @fright
	print 'Gross Amount ' + cast(@gross as varchar(20))
	print 'Freight amount '+cast(@fright as varchar(20))
	print '-----------------'
	print 'Net Price ' +cast(@netPrice as varchar(20))
end

exec proc_PrintPayable '10248'


--Store the value into new table

----function to fetch the value
create proc proc_FetchAllCustomers
as
  select * from Customers
----call the function
exec proc_FetchAllCustomers
----create the table
create table tblSimple
(f1 int primary key,
f2 varchar(20))
----create function to insert value into the table
create proc proc_InsertIntoSimple(@f1 int,@f2 varchar(20))
as
  insert into tblSimple values(@f1,@f2)
-----call function with parameter
exec proc_InsertIntoSimple 101,'Hello'
----check out the value is it included
select * from tblSimple


-------TRASACTION
create table tblStatus
(f1 int,
msg varchar(20))

begin tran
	insert into tblSimple values(102, 'Check Done')
	insert into tblStatus values(102, 'Success')
	if((select count(f1) from tblSimple where f1 = 102)>0) --to check whether inserted
		rollback-- rollback start from begin tran, only DML queries, all DML queries
	else
		commit
end

-------------------------------------------------------------
alter proc proc_Transaction(@f1 int,@f2 varchar(20))
as
begin
    begin tran
	declare @count int
	set @count = (select count(f1) from tblSimple where f2 = @f2)
	   insert into tblSimple values(@f1,@f2)
	   insert into tblStatus values(@f1,'Success')
	   if(@count>0)
		  rollback
	   else
		 commit
end

exec proc_Transaction 105,'NewHello'

select * from tblSimple
select * from tblStatus

---------------------------------------------------------------------------

--create a stored procedure that will calculate total salary
--take input of basic, Dearness allwance(da), HOuse Rent Allowance(hra), deductions and the number of leaves
--if the number of leave is more than 2 deduct the pay for the extra days and the net salary

create proc proc_stored(@basic int,@da int,@hra int ,@deductions int, @numLeave int)
as 
begin
	Declare
	@net float,
	@exceededLeave int,
	@deductionLeave float
	if (@numLeave > 2)
		begin
			set @exceededLeave = @numLeave - 2
			set @deductionLeave = (@basic/30)*@exceededLeave
		end
	set @net = @basic+@da+@hra-@deductions-@deductionLeave
	print cast(@net)
		
end

exec proc_stored(2000,1234,123,50,3)

--correction
create proc proc_calTotalSalary(@basic float, @da float, @hra float, @deduction float, @numLeaves int)
as
begin
	Declare
		@nettSalary float,
		@grossSalary float
	set @grossSalary = @basic + @da + @hra - @deduction
	if(@numLeaves > 2)
	begin
	declare 
		@perDaySal float
		set @perDaySal = @grossSalary / 30
		set @nettSalary = @grossSalary - ((@numLeaves -2)*@perDaySal)
		print 'Leave Deductions '+  cast(((@numLeaves -2)*@perDaySal) as varchar(20))
	end
	else
	   set @nettSalary = @grossSalary
	print 'Gross Salary '+cast(@grossSalary as varchar(20))
	print '---------------------------------------'
	print 'Net Salary '+cast(@nettSalary as varchar(20))
end

---------------------------------------------------------------------------------------------------

--REAL FUNCTION

create function fn_Sample(@num int)
returns int
as 
begin
	return @num*@num
end

select dbo.fn_Sample(UnitPrice) from Products

------------print statement cmi only return

create function fn_CalSal(@basic float, @da float, @hra float, @deduction float, @numLeaves int)
returns float
as
begin
	Declare
		@nettSalary float,
		@grossSalary float
	set @grossSalary = @basic + @da + @hra - @deduction
	if(@numLeaves > 2)
	begin
	declare 
		@perDaySal float
		set @perDaySal = @grossSalary / 30
		set @nettSalary = @grossSalary - ((@numLeaves -2)*@perDaySal)
		print 'Leave Deductions '+  cast(((@numLeaves -2)*@perDaySal) as varchar(20))
	end
	else
	   set @nettSalary = @grossSalary
	return @nettSalary
end

select dbo.fn_CalSal(10000,5000,3000,1500,4)

----------with table insert create

create function fn_CalSalTable(@basic float, @da float, @hra float, @deduction float, @numLeaves int)
returns @SalTable Table(
GrossAmount float,
LeaveDeductions float,
NetAmount float
)
as
begin
	Declare
		@nettSalary float,
		@grossSalary float
	set @grossSalary = @basic + @da + @hra - @deduction
	if(@numLeaves > 2)
	begin
	declare 
		@perDaySal float
		set @perDaySal = @grossSalary / 30
		set @nettSalary = @grossSalary - ((@numLeaves -2)*@perDaySal)
		insert into @SalTable values(@grossSalary,((@numLeaves -2)*@perDaySal),@nettSalary)
	end
	else
	begin
	   set @nettSalary = @grossSalary
		insert into @SalTable values(@grossSalary,0,@nettSalary)
	end
	return
end

select * from dbo.fn_CalSalTable(10000,5000,3000,1500,4)


--------------------------------------------------------
---TRIGGER

select * from account
select * from trans

create trigger trg_InsertCheck
on tblSimple
for Insert
as
begin
	print 'Hello'
end

drop trigger trg_InsertCheck
insert into tblSimple values(106,'dgfd')
update tblSimple set f2 = 'ddd' where f1 = 106
--------------------------------
create table account
(accno int primary key,
balance float)

create table trans
(tranno int primary key,
fromacc int references account(accno),
toacc int references account(accno),
amount float,
status varchar(100))

insert into account values(101,5000)
insert into account values(102,1000)
insert into account values(103,10000)


create trigger trg_Transact
on trans
for insert
as
begin
     declare @bal float,@check float,@credit float
	 set @bal = (select balance from account where accno =(select fromacc from inserted))
	 set @credit = (select amount from inserted)
	 set @check = @bal - (select amount from inserted)
	 if(@check <500)
		update trans set status = 'Failed' where tranno = (select tranno from inserted)
	 else
	 begin
	   update account set balance = @check where accno =(select fromacc from inserted)
	   update account set balance = balance + @credit where accno =(select toacc from inserted)
	   update trans set status = 'Success' where tranno = (select tranno from inserted)
	end
end


select * from account
select * from trans

insert into trans values(3,101,102,3100,null)

---------------Cursor
declare
@acoountNo int,
@Balance float
-----declaring a cursor have SELECT statement
declare cur_account CURSOR FOR select * from account
OPEN cur_account
fetch next from cur_account into @accountNo,@Balance

while (@@FETCH_STATUS = 0)
begin
----- no records will be -1
	print 'Account number : '+ cast(@accountNo as varchar(20))
	print 'Account Balance : '+ cast(@Balance as varchar(20))
	print '---------------------------------------------------'
	FETCH NEXT FROM cur_account into @accountNo,@Balance
end

CLOSE cur_account
DEALLOCATE cur_account

declare 
@account int,
@Balance float

DECLARE cur_account CURSOR FOR select * from account

OPEN cur_account

FETCH NEXT FROM cur_account INTO @account,@balance

while(@@FETCH_STATUS =0)
begin
   print 'Account number : '+ cast(@account as varchar(20))
   print 'Account Balance : '+ cast(@Balance as varchar(20))
   print '-----------------------------------'
  
	   declare @amount float, @status varchar(20)
	   DECLARE cur_tran CURSOR FOR select amount,status from trans where fromacc = @account

	   OPEN cur_tran

	   FETCH NEXT FROM cur_tran INTO @amount,@status
	    
	   while(@@FETCH_STATUS =0)
	   begin
		   print '               Amount transffered : '+ cast(@amount as varchar(20))
		   print '               Transaction status : '+ @status
		   print '-----------------------------------'
		   FETCH NEXT FROM cur_tran INTO @amount,@status
	   end 

	   CLOSE cur_tran
	   DEALLOCATE cur_tran
   FETCH NEXT FROM cur_account INTO @account,@balance
end

CLOSE cur_account
DEALLOCATE cur_account












