use [master];
go


if db_id('SportingGoodsStoreDB') is not null
begin
	drop database [SportingGoodsStoreDB];
end
go


create database [SportingGoodsStoreDB];
go


use [SportingGoodsStoreDB];
go


create table [GoodsTypes](
	[ID] int not null identity(1,1),
	[Name] nvarchar(150) not null unique,

	constraint PK_GoodsTypes_ID primary key([ID]),
	constraint CK_GoodsTypes_Name check([Name] <> ''),
);


create table [Manufacturers](
	[ID] int not null identity(1,1),
	[Name] nvarchar(150) not null,
	[Address] nvarchar(max) not null,

	constraint PK_Manufacturers_ID primary key([ID]),
	constraint CK_Manufacturers_Name check([Name] <> ''),
	constraint UQ_Manufacturers_Name unique([Name]),
	constraint CK_Manufacturers_Address check([Address] <> ''),
);


create table [Goods](
	[ID] int not null identity(1,1),
	[Name] nvarchar(300) not null,
	[GoodsTypeID] int,
	[InStock] smallint not null default(1),
	[CostPrice] money not null default(0.0),
	[SellingPrice] money not null default(0.0),
	[ManufacturerID] int,

	constraint PK_Goods_ID primary key([ID]),
	constraint CK_Goods_Name check([Name] <> ''),
	constraint UQ_Goods_Name unique([Name]),
	constraint FK_Goods_GoodsTypeID foreign key([GoodsTypeID]) references [GoodsTypes]([ID]),
	constraint CK_Goods_InStock check([InStock] > 0),
	constraint FK_Goods_ManufacturerID foreign key([ManufacturerID]) references [Manufacturers]([ID])
);


create table [Employees](
	[ID] int not null identity(1,1),
	[Name] nvarchar(max) not null,
	[Surname] nvarchar(max) not null,
	[Patronymic] nvarchar(max) not null,
	[Position] varchar(max),
	[EmploymentDate] date,
	[IsWorking] bit not null default(1),
	[Gender] varchar(6),
	[Salary] money,

	constraint PK_Employees_ID primary key([ID]),
	constraint CK_Employees_Name check([Name] <> ''),
	constraint CK_Employees_Surname check([Surname] <> ''),
	constraint CK_Employees_Patronymic check([Patronymic] <> ''),
	constraint CK_Employees_Position check([Position] <> ''),
	constraint CK_Employees_EmploymentDate check([EmploymentDate] <= getdate()),
	constraint CK_Employees_Gender check([Gender] in ('Female', 'Male', 'Other')),
	constraint CK_Employees_Salary check([Salary] > 0)
);


create table [Customers](
	[ID] int not null identity(1,1),
	[Name] nvarchar(max) not null,
	[Surname] nvarchar(max) not null,
	[Patronymic] nvarchar(max) not null,
	[Email] varchar(254) not null,
	[ContactPhone] varchar(15),
	[Gender] varchar(6),
	[MailingList] bit not null default(1),
	[Discount] tinyint not null default(0),

	constraint PK_Customers_ID primary key([ID]),
	constraint CK_Customers_Name check([Name] <> ''),
	constraint CK_Customers_Surname check([Surname] <> ''),
	constraint CK_Customers_Patronymic check([Patronymic] <> ''),
	constraint CK_Customers_Email check([Email] <> ''),
	constraint CK_Customers_ContactPhone check([ContactPhone] <> ''),
	constraint CK_Customers_Gender check([Gender] in ('Female', 'Male', 'Other')),
	constraint CK_Customers_Discount check([Discount] between 0 and 100)
);


create table [ArchiveSales](
	[ID] int not null identity(1,1),
	[Name] nvarchar(300) not null,
	[GoodsTypeID] int,
	[CostPrice] money not null default(0.0),
	[SellingPrice] money not null default(0.0),
	[ManufacturerID] int,

	constraint PK_ArchiveSales_ID primary key([ID]),
	constraint CK_ArchiveSales_Name check([Name] <> ''),
	constraint FK_ArchiveSales_GoodsTypeID foreign key([GoodsTypeID]) references [GoodsTypes]([ID]),
	constraint FK_ArchiveSales_ManufacturerID foreign key([ManufacturerID]) references [Manufacturers]([ID])
);


create table [HistorySales](
	[ID] int not null identity(1,1),
	[Name] nvarchar(300) not null,
	[SellingPrice] money not null,
	[Offtake] smallint not null,
	[Date] date not null,
	[EmployeeID] int not null,
	[CustomerID] int not null,

	constraint PK_HistorySales_ID primary key([ID]),
	constraint CK_HistorySales_Name check([Name] <> ''),
	constraint CK_HistorySales_Date check([Date] <= getdate()),
	constraint FK_HistorySales_EmployeeID foreign key([EmployeeID]) references [Employees]([ID]),
	constraint FK_HistorySales_CustomerID foreign key([CustomerID]) references [Customers]([ID])
);


create table [Sales](
	[ID] int not null identity(1,1),
	[Name] nvarchar(300) not null,
	[SellingPrice] money not null,
	[Offtake] smallint not null,
	[Date] date not null,
	[EmployeeID] int not null,
	[CustomerID] int not null,

	constraint PK_Sales_ID primary key([ID]),
	constraint CK_Sales_Name check([Name] <> ''),
	constraint CK_Sales_Date check([Date] <= getdate()),
	constraint FK_Sales_EmployeeID foreign key([EmployeeID]) references [Employees]([ID]),
	constraint FK_Sales_CustomerID foreign key([CustomerID]) references [Customers]([ID])
);


create table [CustomersSales](
	[CustomerID] int not null,
	[SaleID] int not null,

	constraint PK_CustomersSales primary key([CustomerID], [SaleID]),
	constraint FK_CustomersSales_CustomerID foreign key([CustomerID]) references [Customers]([ID]),
	constraint FK_CustomersSales_SaleID foreign key([SaleID]) references [Sales]([ID])
);


--1,2)
create trigger SaleEvent
on [Sales]
for insert
as
begin
	if (@@ROWCOUNT = 1)
	begin
		declare
		@Offtake smallint, @Name nvarchar(300),
		@SellingPrice money, @Date date, 
		@EmployeeID int, @CustomerID int,
		@InStock smallint, @GoodsTypeID int,
		@CostPrice money, @ManufacturerID int;
		select
			@Offtake = i.[Offtake],
			@Name = i.[Name],
			@SellingPrice = i.[SellingPrice],
			@Date = i.[Date],
			@EmployeeID = i.[EmployeeID],
			@CustomerID = i.[CustomerID]
		from
			inserted as i

		select
			@InStock = G.[InStock],
			@GoodsTypeID = G.[GoodsTypeID],
			@CostPrice = G.[CostPrice],
			@ManufacturerID = G.[ManufacturerID]
		from
			[Goods] as G
		where
			[Name] = @Name

		if (@Offtake > @InStock)
		begin
			raiserror('There are not enough units of the product',0,1)
			rollback tran
		end
		else
		begin
			insert into [HistorySales] values(@Name, @SellingPrice, 
											  @Offtake, @Date,
											  @EmployeeID, @CustomerID);

			if (@Offtake = @InStock)
			begin
				insert into [ArchiveSales] values(@Name, @GoodsTypeID,
												  @CostPrice, @SellingPrice,
												  @ManufacturerID);

				delete from [Goods] where [Name] = @Name;
			end
		end

	end
	else
	begin
		print 'Error insert!'
		rollback tran
	end
end

--3.)
create trigger RegisterEvent
on Customers
for insert
as
begin
	if (@@ROWCOUNT = 1)
	begin
		declare
		@Name nvarchar(max),
		@Surname nvarchar(max),
		@Patronymic nvarchar(max),
		@Email varchar(254);
		select
			@Name = i.[Name],
			@Surname = i.[Surname],
			@Patronymic = i.[Patronymic],
			@Email = i.[Email]
		from
			inserted as i
		
		declare @ID int = null;
		select
			@ID = C.[ID]
		from
			[Customers] as C
		where
			C.[Name] = @Name and
			C.[Surname] = @Surname and
			C.[Patronymic] = @Patronymic and
			C.[Email] = @Email;

		if (@ID = null)
		begin
			print 'This customer already in base!'
			rollback tran
		end
	end
	else
	begin
		print 'Error insert!'
		rollback tran
	end
end


--4.)
create trigger DisableDeleteCustomers
on [Customers]
for delete
as
begin
	raiserror('Deleting customers is prohibited!', 0, 1)
	rollback tran
end


--5.)
create trigger DisableDeleteEmployeesBefore2015
on [Employees]
for delete
as
begin
	if(@@ROWCOUNT = 1)
	begin
		declare @EmploymentDate date;
		select
			@EmploymentDate = d.EmploymentDate
		from 
			deleted as d

		if(Year(@EmploymentDate) < 2015)
		begin
			raiserror('This employee cannot be deleted', 0, 1)
			rollback tran
		end
	end
	else
	begin
		print 'Error while deleted!'
		rollback tran
	end
end


--6.)
create trigger CheckForDiscount
on [Sales]
for insert
as 
begin
	if(@@ROWCOUNT = 1)
	begin
		declare @CustomerID int, @sum money;
		select
			@CustomerID = i.[CustomerID]
		from
			inserted as i;

		select
			@sum += S.SellingPrice
		from
			[CustomersSales] as CS join [Sales] as S on
			CS.SaleID = S.[ID]
		where
			CS.[CustomerID] = @CustomerID;

		if(@sum >= 50000)
		begin
			update [Customers] set [Discount] = 15 where [ID] = @CustomerID;
			print('Now this customer`s discount percentage is 15%.');
		end
		else
		begin
			print('This customer`s discount percentage is 0%.');
		end
	end
	else
	begin
		print 'Error insert!';
		rollback tran;
	end
end