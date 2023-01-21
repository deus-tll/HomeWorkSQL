--1.)
select
	LR.[Name] 'Lecture Room`s Name'
from
	[Schedules] as S join [Lectures] as L on
	S.[LectureID] = L.[ID]

	join [LectureRooms] as LR on
	S.[LectureRoomID] = LR.[ID]

	join [Teachers] as T on 
	L.[TeacherID] = T.ID
where
	T.[Name] = 'Edward' and
	T.[Surname] = 'Hopper'

--2.)
select
	T.[Surname] as 'Teacher`s Surname'
from
	[GroupsLectures] as GL join [Lectures] as L on
	GL.[LectureID] = L.[ID]

	join [Teachers] as T on
	L.[TeacherID] = T.[ID]

	join [Assistants] as A on
	A.[TeacherID] = T.[ID]

	join [Groups] as G on
	GL.[GroupID] = G.[ID]
where
	G.[Name] = 'F505'

--3.)
select
	S.[Name] as 'Subject`s name'
from
	[GroupsLectures] as GL join [Lectures] as L on
	GL.[LectureID] = L.[ID]

	join [Subjects] as S on
	L.[SubjectID] = S.[ID]

	join [Teachers] as T on
	L.[TeacherID] = T.[ID]

	join [Groups] as G on
	GL.[GroupID] = G.[ID]
where
	T.[Name] = 'Alex' and
	T.[Surname] = 'Carmack' and
	G.[Year] = 5

--4.)
select
	T.[Surname] as 'Teacher`s Surname'
from
	[Schedules] as S join [Lectures] as L on
	S.[LectureID] = L.[ID]

	join [Teachers] as T on 
	L.[TeacherID] = T.ID
where
	not exists(
		select L.[ID]
		where S.[DayOfWeek] = 1
	)

--5.)
select
	LR.[Name] 'Lecture Room`s Name',
	LR.[Building]
from
	[Schedules] as S join [Lectures] as L on
	S.[LectureID] = L.[ID]

	join [LectureRooms] as LR on
	S.[LectureRoomID] = LR.[ID]
where
	not exists(
		select L.[ID]
		where S.[Week] = 2 and
			  S.[DayOfWeek] = 3 and
			  S.[Class] = 3
	)

--6.)
select
	T.[Name] + ' ' + T.[Surname] as 'FullName'
from
	[GroupsCurators] as GC join [Curators] as C on
	GC.[CuratorID] = C.[ID]

	join [Teachers] as T on
	C.[TeacherID] = T.[ID]

	join [Groups] as G on
	GC.[GroupID] = G.[ID]

	join [Departments] as D on
	G.[DepartmentID] = D.[ID]

	join [Faculties] as F on
	D.[FacultyID] = F.[ID]
where
	not exists(
		select T.[ID]
		where F.[Name] = 'Computer Science' and
			  D.[Name] = 'Software Development'
	);

--7.)
select Building
from Faculties
union all
select Building
from Departments
union all
select Building
from LectureRooms

--8.)
select [Name] + ' ' + [Surname] as 'FullName'
from [Deans] as D join [Teachers] as T on
	 D.[TeacherID] = T.[ID]
union all
select [Name] + ' ' + [Surname] as 'FullName'
from [Heads] as H join [Teachers] as T on
	 H.[TeacherID] = T.[ID]
union all
select T.[Name] + ' ' + T.[Surname] as 'FullName'
from (
	select *
	from
		[Teachers] as T
	where 
		T.[ID] <> any(
			select
				*
			from 
				[Deans] as D,
				[Heads] as H,
				[Curators] as C,
				[Assistants] as A
			where
				D.[TeacherID] = T.[ID] or
				H.[TeacherID] = T.[ID] or
				C.[TeacherID] = T.[ID] or
				A.[TeacherID] = T.[ID]
	)
) as T
union all
select [Name] + ' ' + [Surname] as 'FullName'
from [Curators] as C join [Teachers] as T on
	 C.[TeacherID] = T.[ID]
union all
select [Name] + ' ' + [Surname] as 'FullName'
from [Assistants] as A join [Teachers] as T on
	 A.[TeacherID] = T.[ID]

--9.)
select distinct
	S.[DayOfWeek]
from
	[Schedules] as S join [LectureRooms] as LR on
	S.[LectureRoomID] = LR.[ID]

	join [Lectures] as L on
	S.[LectureID] = L.[ID]
where
	LR.[Name] = 'A311' or
	LR.[Name] = 'A104'

/*
create table [Teachers](
	[ID] int not null identity(1,1),
	[Name] nvarchar(100) not null,
	[Surname] nvarchar(100) not null,

	constraint PK_Teachers_ID primary key ([ID]),
	constraint CK_Teachers_Name check([Name] <> ''),
	constraint CK_Teachers_Surname check([Surname] <> '')
);


create table [Assistants](
	[ID] int not null identity(1,1),
	[TeacherID] int not null,

	constraint PK_Assistants_ID primary key([ID]),
	constraint FK_Assistants_TeacherID foreign key([TeacherID]) references [Teachers]([ID])
);


create table [Curators](
	[ID] int not null identity(1,1),
	[TeacherID] int not null,

	constraint PK_Curators_ID primary key([ID]),
	constraint FK_Curators_TeacherID foreign key([TeacherID]) references [Teachers]([ID])
);


create table [Deans](
	[ID] int not null identity(1,1),
	[TeacherID] int not null,

	constraint PK_Deans_ID primary key([ID]),
	constraint FK_Deans_TeacherID foreign key([TeacherID]) references [Teachers]([ID])
);


create table [Heads](
	[ID] int not null identity(1,1),
	[TeacherID] int not null,

	constraint PK_Heads_ID primary key([ID]),
	constraint FK_Heads_TeacherID foreign key([TeacherID]) references [Teachers]([ID])
);


create table [Faculties](
	[ID] int not null identity(1,1),
	[Building] tinyint not null,
	[Name] nvarchar(100) not null,
	[DeanID] int not null,

	constraint PK_Faculties_ID primary key([ID]),
	constraint CK_Faculties_Building check([Building] between 1 and 5),
	constraint CK_Faculties_Name check([Name] <> ''),
	constraint UQ_Faculties_Name unique ([Name]),
	constraint FK_Faculties_DeanID foreign key ([DeanID]) references [Deans]([ID])
);


create table [Departments](
	[ID] int not null identity(1,1),
	[Building] tinyint not null,
	[Name] nvarchar(100) not null,
	[FacultyID] int not null,
	[HeadID] int not null,

	constraint PK_Departments_ID primary key([ID]),
	constraint CK_Departments_Building check([Building] between 1 and 5),
	constraint CK_Departments_Name check([Name] <> ''),
	constraint UQ_Departments_Name unique ([Name]),
	constraint FK_Departments_FacultyID foreign key ([FacultyID]) references [Faculties]([ID]),
	constraint FK_Departments_HeadID foreign key ([HeadID]) references [Heads]([ID])
);


create table [Groups](
	[ID] int not null identity(1,1),
	[Name] nvarchar(100) not null,
	[Year] tinyint not null,
	[DepartmentID] int not null,

	constraint PK_Groups_ID primary key([ID]),
	constraint CK_Groups_Name check([Name] <> ''),
	constraint UQ_Groups_Name unique ([Name]),
	constraint CK_Groups_Year check([Year] between 1 and 5),
	constraint FK_Groups_DepartmentID foreign key ([DepartmentID]) references [Departments]([ID])
);


create table [Subjects](
	[ID] int not null identity(1,1),
	[Name] nvarchar(100) not null,

	constraint PK_Subjects_ID primary key([ID]),
	constraint CK_Subjects_Name check([Name] <> ''),
	constraint UQ_Subjects_Name unique ([Name]),
);


create table LectureRooms(
	[ID] int not null identity(1,1),
	[Building] tinyint not null,
	[Name] nvarchar(100) not null,

	constraint PK_LectureRooms_ID primary key([ID]),
	constraint CK_LectureRooms_Building check([Building] between 1 and 5),
	constraint CK_LectureRooms_Name check([Name] <> ''),
	constraint UQ_LectureRooms_Name unique ([Name]),
);


create table [Lectures](
	[ID] int not null identity(1,1),
	[SubjectID] int not null,
	[TeacherID] int not null,

	constraint PK_Lectures_ID primary key([ID]),
	constraint FK_Lectures_SubjectID foreign key([SubjectID]) references [Subjects]([ID]),
	constraint FK_Lectures_TeacherID foreign key([TeacherID]) references [Teachers]([ID])
);


create table [GroupsCurators](
	[GroupID] int not null,
	[CuratorID] int not null,

	constraint PK_GroupCurator primary key([GroupID], [CuratorID]),
	constraint FK_GroupsCurators_GroupID foreign key([GroupID]) references [Groups]([ID]),
	constraint FK_GroupsCurators_CuratorID foreign key([CuratorID]) references [Curators]([ID])
);


create table [GroupsLectures](
	[GroupID] int not null,
	[LectureID] int not null,

	constraint PK_GroupLecture primary key([GroupID], [LectureID]),
	constraint FK_GroupsLectures_GroupID foreign key([GroupID]) references [Groups]([ID]),
	constraint FK_GroupsLectures_LectureID foreign key([LectureID]) references [Lectures]([ID])
);


create table [Schedules](
	[ID] int not null identity(1,1),
	[Class] tinyint not null,
	[DayOfWeek] tinyint not null,
	[Week] tinyint not null,
	[LectureID] int not null,
	[LectureRoomID] int not null,

	constraint PK_Schedules_ID primary key([ID]),
	constraint CK_Schedules_Class check([Class] between 1 and 8),
	constraint CK_Schedules_DayOfWeek check([DayOfWeek] between 1 and 7),
	constraint CK_Schedules_Week check([Week] between 1 and 52),
	constraint FK_Schedules_LectureID foreign key([LectureID]) references [Lectures]([ID]),
	constraint FK_Schedules_LectureRoomID foreign key([LectureRoomID]) references [LectureRooms]([ID])
);
*/


--1.)

