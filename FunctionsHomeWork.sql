--task 1

--1.)
--create function HelloName(@name nvarchar(max))
--returns nvarchar(max)
--as
--begin
--	return 'Hello, ' + @name;
--end

--select dbo.HelloName('Artem')

--2.)
--create function GetMinutes()
--returns nvarchar(max)
--as
--begin
--	return Datepart(minute,getdate());
--end

--select dbo.GetMinutes()


--3.)
--create function GetYear()
--returns nvarchar(max)
--as
--begin
--	return Datepart(year,getdate());
--end

--select dbo.GetYear()

--4.)
--create function GetEvenYear(@date date)
--returns nvarchar(max)
--as
--begin
--	if ((Datepart(year, @date) % 2 = 0))
--	begin
--		return 'Year is even';
--	end
--		return 'Year isn`t even';
--end

--select dbo.GetEvenYear(getdate())



--5.)
--create function GetPrimeNumber(@number int)
--returns nvarchar(max)
--as
--begin
--	declare @i int = 2;
--	while(@i < SQRT(@number) + 1)
--	begin
--		if(@number % @i = 0)
--		begin
--			return 'no';
--		end
--		set @i += 1;
--	end
--	return 'yes';
--end

--select dbo.GetPrimeNumber(32)


--6.)
--create function GetSumOfMinMax(@num1 float, @num2 float, @num3 float, @num4 float, @num5 float)
--returns float
--as
--begin
--	declare @table table([Numbers] float);
--	declare @min float , @max float;

--	insert into @table values(@num1), (@num2), (@num3), (@num4), (@num5);
--	select 
--		@min = Min(t.[Numbers]),
--		@max = Max(t.[Numbers])
--	from 
--		@table as t;

--	return @min + @max;
--end


--select dbo.GetSumOfMinMax(1,2,3,4,5)


--task 2

--1.)
--create function MinSaleByEmployee(@name nvarchar(max), 
--								  @surname nvarchar(max), 
--								  @patronymic nvarchar(max))
--returns money
--as
--begin
--	declare @result money = null;
--	select
--		@result = Min(S.[SellingPrice])
--	from
--		[Sales] as S join [Employees] as E on
--		S.[EmployeeID] = E.[ID]
--	where
--		E.[Name] = @name and
--		E.[Surname] = @surname and
--		E.[Patronymic] = @patronymic
		
--	return @result; 
--end


--select dbo.MinSaleByEmployee('Artem', 'Miller', 'Valeriyovich')


--2.)
--create function MinSaleByCustomer(@name nvarchar(max), 
--								  @surname nvarchar(max), 
--								  @patronymic nvarchar(max))
--returns money
--as
--begin
--	declare @result money = null;
--	select
--		@result = Min(S.[SellingPrice])
--	from
--		[Sales] as S join [Customers] as C on
--		S.[CustomerID] = C.[ID]
--	where
--		C.[Name] = @name and
--		C.[Surname] = @surname and
--		C.[Patronymic] = @patronymic
		
--	return @result; 
--end


--select dbo.MinSaleByCustomer('Vladislav', 'Nabiylin', 'Ivanovich')


--3.)
--create function TotalAmountFromSalesByDate(@date date)
--returns money
--as
--begin
--	declare @result money = null;
--	select
--		@result = Sum(S.[SellingPrice])
--	from
--		[Sales] as S
--	where
--		S.[Date] = @date
		
--	return @result; 
--end

--select dbo.TotalAmountFromSalesByDate('2023-01-20')


--4.)
--create function GetDateWithMaxTotalAmount()
--returns date
--as
--begin
--	declare @result date = null;
--	declare @table table([Date] date, [Sum] money);

--	insert into @table
--	select
--			S.[Date],
--			Sum(S.[SellingPrice]) as [Sum]
--		from
--			[Sales] as S
--		group by
--			S.[Date]
--		order by [Sum] desc;
		
--	select top 1
--		@result = t.[Date]
--	from
--		@table as t

--	return @result
--end

--select dbo.GetDateWithMaxTotalAmount()


--5.)
--create function GetAllSalesForCertainCommodity(@name nvarchar(300))
--returns table
--as
--	return (
--		select
--			*
--		from
--			[Sales] as S
--		where
--			S.[Name] = @name
--	)

--select * from dbo.GetAllSalesForCertainCommodity('sport shoes')

--6.)
--create function GetEmployeesNamesakes()
--returns table
--as 
--	return(
--		select
--			*
--		from
--			[Employees]
--		where
--			[Surname] = any(
--				select 
--					[Surname]
--				from
--					[Employees]
--				group by
--					[Surname]
--				having
--					Count([Surname]) > 1)
--	);

--select * from dbo.GetEmployeesNamesakes()


--7.)
--create function GetCustomersNamesakes()
--returns @table table([Name] nvarchar(max), [Surname] nvarchar(max),
--					 [Patronymic] nvarchar(max), [Gender] varchar(6),
--					 [Email] varchar(254), [ContactPhone] varchar(15), 
--					 [MailingList] bit, [Discount] tinyint)
--as
--begin
--	insert into @table
--	select
--		[Name],
--		[Surname],
--		[Patronymic],
--		[Gender],
--		[Email],
--		[ContactPhone],
--		[MailingList],
--		[Discount]
--	from
--		[Customers]
--	where
--		[Surname] = any(
--			select
--				[Surname]
--			from
--				[Customers]
--			group by
--				[Surname]
--			having
--				Count([Surname])  > 1)

--	return
--end

--select * from dbo.GetCustomersNamesakes()