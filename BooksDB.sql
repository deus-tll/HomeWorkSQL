use BooksDB;
go

create table [Themes](
	[Id] int not null identity(1,1),
	[Name] nvarchar(40) not null,

	constraint PK_Themes_Id   primary key([Id]),
	constraint CK_Themes_Name check([Name] <> ''),
);


create table [Categories](
	[Id] int not null identity(1,1),
	[Name] nvarchar(40) not null,

	constraint PK_Categories_Id   primary key([Id]),
	constraint CK_Categories_Name check([Name] <> ''),
);


create table [Formats](
	[Id] int not null identity(1,1),
	[Name] varchar(20) not null,

	constraint PK_Formats_Id   primary key([Id]),
	constraint CK_Formats_Name check([Name] <> ''),
);


create table [PublishingHouses](
	[Id] int not null identity(1,1),
	[Name] nvarchar(40) not null,
	[Country] varchar(25) null,
	[City] varchar(35) null,

	constraint PK_PublishingHouses_Id   primary key([Id]),
	constraint CK_PublishingHouses_Name check([Name] <> ''),
	constraint CK_PublishingHouses_Country check([Country] <> ''),
	constraint CK_PublishingHouses_City check([City] <> ''),
);


create table [Books](
	[Id] int not null identity(1,1),
	[Code] float not null unique,
	[Name] nvarchar(100) not null,
	[Price] money null,
	[Pages] smallint null,
	[DateIn] date not null,
	[PressRun] smallint not null,
	constraint PK_Books_Id primary key([Id]),
	constraint CK_Books_Code check([Code] > 0),
	constraint CK_Books_Name check([Name] <> ''),
	constraint CK_Books_Price check([Price] >= 0),
	constraint CK_Books_Pages check([Pages] > 0),
	constraint CK_Books_DateIn check([DateIn] < getdate()),
	constraint CK_Books_PressRun check([PressRun] < YEAR(getdate())),


	[ThemeId] int not null,
	[CategoryId] int not null,
	[FormatId] int not null,
	[PublishingHouseId] int not null,
	constraint FK_Books_ThemeId foreign key ([ThemeId]) references [Themes](Id),
	constraint FK_Books_CategoryId foreign key ([CategoryId]) references [Categories](Id),
	constraint FK_Books_FormatId foreign key ([FormatId]) references [Formats](Id),
	constraint FK_Books_PublishingHouseId foreign key ([PublishingHouseId]) references [PublishingHouses](Id)
);