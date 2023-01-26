--task 1

--1.)
--create proc OutHelloWorld
--as
--begin
--	print('Hello World');
--	return 0;
--end

--exec OutHelloWorld;


--2.)
--create proc OutCurrentTime
--as
--begin
--	select Convert (time, GetDate())
--	return 0;
--end

--exec OutCurrentTime;


--3.)
--create proc OutCurrentDate
--as
--begin
--	select Convert (date, GetDate())
--	return 0;
--end

--exec OutCurrentDate;


--4.)
--create proc SumOfThree
--	@a float,	@b float,	@c float, @sum float out
--as
--begin
--	if @a is null or @b is null or @c is null
--	begin
--		raiserror('one of args is null', 1,1);
--		return 1;
--	end
--	else
--	begin
--		select @sum = @a + @b + @c
--		return 0;
--	end
--end


--declare @a float = 1, @b float = 2, @c float = 3, @sum float
--exec SumOfThree @a, @b, @c, @sum out
--select @sum as 'Sum'


--5.)
--create proc AvgOfThree
--	@a float,	@b float,	@c float, @avg float out
--as
--begin
--	if @a is null or @b is null or @c is null
--	begin
--		raiserror('one of args is null', 1,1);
--		return 1;
--	end
--	else
--	begin
--		select @avg = (@a + @b + @c) / 3;
--		return 0;
--	end
--end

--declare @a float = 1, @b float = 2, @c float = 3, @sum float
--exec AvgOfThree @a, @b, @c, @avg out
--select @avg as 'Avg'



--task 2

--1.)
--create proc GetAllDoctors
--as
--begin
--	select *
--	from [Doctors]

--	return 0;
--end

--exec GetAllDoctors

--2.)
--create proc GetAllWardsByDepartments
--as
--begin
--	select
--		D.[Name] as 'Department`s name',
--		W.[Name] as 'Ward`s name'
--	from
--		[Wards] as W join [Departments] as D on
--		W.[DepartmentId] = D.[Id] 

--	return 0;
--end

--exec GetAllWardsByDepartments


--3.)
--create proc GetAllProfessors
--as
--begin
--	select
--		*
--	from
--		[Professors] as P join [Doctors] as D on
--		P.[DoctorId] = D.[Id]

--		return 0;
--end

--exec GetAllProfessors


--4.)
--create proc GetAllExamsByDate
--	@date date
--as
--begin
--	select
--		E.[Name] as 'Examination',
--		Doc.[Name] + ' ' + Doc.[Surname] as 'Doctor',
--		Dis.[Name] as 'Disease',
--		W.[Name] as 'Ward',
--		DE.[StartTime],
--		DE.[EndTime]
--	from
--		[DoctorsExaminations] as DE join [Examinations] as E on
--		DE.[ExaminationId] = E.[Id]

--		join [Diseases] as Dis on
--		DE.[DiseaseId] = Dis.[Id]

--		join [Doctors] as Doc on
--		DE.[DoctorId] = Doc.[Id]

--		join [Wards] as W on
--		DE.[WardId] = W.[Id]
--	where
--		DE.[ExDate] = @date;

--	return 0;
--end

--declare @date date = getdate();
--exec GetAllExamsByDate @date


--5.)
--create proc GetAllExamsByStartEndDate
--	@start date, @end date
--as
--begin
--	select
--		E.[Name] as 'Examination',
--		Doc.[Name] + ' ' + Doc.[Surname] as 'Doctor',
--		Dis.[Name] as 'Disease',
--		W.[Name] as 'Ward',
--		DE.[StartTime],
--		DE.[EndTime]
--	from
--		[DoctorsExaminations] as DE join [Examinations] as E on
--		DE.[ExaminationId] = E.[Id]

--		join [Diseases] as Dis on
--		DE.[DiseaseId] = Dis.[Id]

--		join [Doctors] as Doc on
--		DE.[DoctorId] = Doc.[Id]

--		join [Wards] as W on
--		DE.[WardId] = W.[Id]
--	where
--		DE.[ExDate] between @start and @end

--	return 0;
--end

--declare @start date = '2022-05-01', @end date = getdate();
--exec GetAllExamsByStartEndDate @start, @end


--6.)
--create proc GetAllExamsByDoctor
--	@Name nvarchar(max), @Surname nvarchar(max)
--as
--begin
--	select
--		E.[Name] as 'Examination`s name'
--	from
--		[DoctorsExaminations] as DE join [Doctors] as D on
--		DE.[DoctorId] = D.[Id]

--		join [Examinations] as E on
--		DE.[ExaminationId] = E.[Id]
--	where
--		D.[Name] = @Name and
--		D.[Surname] = @Surname

--	return 0;
--end

--declare @Name nvarchar(max) = 'Norman', @Surname nvarchar(max) = 'Reedus';
--exec GetAllExamsByDoctor @Name, @Surname;


--7.)
--create proc GetCountOfAllExamsByDoctorYear
--	@Year smallint, @Name nvarchar(max) = null, @Surname nvarchar(max) = null
--as
--begin
--	if(@Name = null or @Surname = null)
--	begin
--		select Count(*) as 'Count of Examinations'
--		from [Examinations]

--		return 0;
--	end
--	else
--	begin
--		select
--			Count(E.[Id]) as 'Count of Examinations'
--		from
--			[DoctorsExaminations] as DE join [Doctors] as D on
--			DE.[DoctorId] = D.[Id]

--			join [Examinations] as E on
--			DE.[ExaminationId] = E.[Id]
--		where
--			D.[Name] = @Name and
--			D.[Surname] = @Surname			
--	end
--end

--declare @Year smallint = 2022, @Name nvarchar(max) = 'Norman', @Surname nvarchar(max) = 'Reedus';
--exec GetCountOfAllExamsByDoctorYear @Year, @Name, @Surname;


--8.)

--create proc GetInfoForDisease
--	@YearOrMonth varchar(5), @Value smallint
--as
--begin
--	if(lower(@YearOrMonth) = 'year')
--	begin
--		select 
--			Dis.[Name] as 'Disease`s name',
--			Count(Dis.[Name]) as 'Count of Disease'
--		from
--			[DoctorsExaminations] as DE join [Diseases] as Dis on
--			DE.[DiseaseId] = Dis.[Id]
--		where
--			@Value = Year(DE.ExDate)
--		group by
--			Dis.[Name];

--		return 0;

--	end
--	else if(lower(@YearOrMonth) = 'month')
--	begin
--		select 
--			Dis.[Name] as 'Disease`s name',
--			Count(Dis.[Name]) as 'Count of Disease'
--		from
--			[DoctorsExaminations] as DE join [Diseases] as Dis on
--			DE.[DiseaseId] = Dis.[Id]
--		where
--			@Value = Month(DE.ExDate)
--		group by
--			Dis.[Name];

--		return 0;
--	end
--end

--exec GetInfoForDisease 'year', 2022