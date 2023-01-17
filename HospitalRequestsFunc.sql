--1.)
select
	count(W.[Id]) as 'Count of Wards'
from
	[Wards] as W
where
	W.[Places] > 10

--2.)
select
	D.[Building] as 'Building',
	Count(W.[Id]) as 'Count of Wards'
from
	[Departments] as D,
	[Wards] as W
where
	W.[DepartmentId] = D.[Id]
group by
	D.[Building]

--3.)
select
	D.[Name] as 'Department`s name',
	Count(W.[Id]) as 'Count of Wards'
from
	[Departments] as D,
	[Wards] as W
where
	W.[DepartmentId] = D.[Id]
group by
	D.[Name]


--4.)
select
	Dep.[Name] as 'Department`s name',
	Sum(D.[Premium]) as 'Total premium by Department'
from
	[Departments] as Dep,
	[Wards] as W,
	[Doctors] as D,
	[DoctorsExaminations] as DE
where
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	DE.[DoctorId] = D.[Id]
group by
	Dep.[Name]

--5.)
select
	Dep.[Name] as 'Department`s name'
from
	[Departments] as Dep,
	[Wards] as W,
	[Doctors] as D,
	[DoctorsExaminations] as DE
where
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	DE.[DoctorId] = D.[Id]
group by
	Dep.[Name]
having
	Count(D.[Id]) >= 5

--6.)
select
	Count(*) as 'Count of Doctors',
	Sum(D.[Salary] + D.[Premium]) as 'Wage'
from
	[Doctors] as D

--7.)
select
	Avg(D.[Salary] + D.[Premium]) as 'Average wage'
from
	[Doctors] as D


--8.)
select
	W.[Name] as 'Ward`s name'
from
	[Wards] as W,
	(
		select 
			Min([Wards].Places) as 'CountOfPlaces' 
		from [Wards]
	) as C
where
	W.[Places] = C.CountOfPlaces

--9.)
select
	Dep.[Building]
from
	[Departments] as Dep,
	[Wards] as W
where
	W.[DepartmentId] = Dep.[Id] and
	W.[Places] > 10 and
	Dep.[Building] in (1, 6, 7, 8)
group by
	Dep.[Building]
having Sum(W.[Places]) > 100