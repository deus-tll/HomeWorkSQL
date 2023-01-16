--1.)
select
	D.[Name] + ' ' + D.[Surname] as 'FullName',
	S.[Name] as 'Name Specialization'
from
	[Doctors] as D,
	[DoctorsSpecializations] as DS,
	[Specializations] as S
where
	DS.[DoctorId] = D.[Id] and
	DS.[SpecializationId] = S.[Id];

--2.)
select
	D.[Surname],
	D.[Premium] + D.[Salary] as 'Wage'
from
	[Doctors] as D,
	[Vacations] as V
where
	V.[DoctorId] = D.[Id] and
	V.[EndDate] <= getdate();

--3.)
select
	W.[Name] as 'Ward`s name'
from
	[Wards] as W, 
	[Departments] as D
where
	W.[DepartmentId] = D.[Id] and 
	D.[Name] = 'Intensive Treatment';

--4.)
select distinct
	Dep.[Name] as 'Department`s name'
from
	[Departments] as Dep, 
	[Sponsors] as S, 
	[Donations] as Don
where
	Don.[DepartmentId] = Dep.[Id] and
	Don.[SponsorId] = S.[Id]
	and S.[Name] = 'Umbrella Corporation';

--5.)
select
	Dep.[Name] as 'Department`s Name',
	S.[Name] as 'Sponsor`s Name',
	Don.[Amount] as 'Donation Amount',
	Don.[Date] as 'Date of Donation'
from
	[Departments] as Dep, 
	[Sponsors] as S,
	[Donations] as Don
where
	Dep.[Id] = Don.[DepartmentId] and
	S.[Id] = Don.[SponsorId] and
	DateDiff(month, getdate(), Don.[Date]) = 0;

--6.)
select
	D.[Surname] as 'Doctor`s surname',
	Dep.[Name] as 'Department`s name'
from
	[Doctors] as D,
	[DoctorsExaminations] as DE,
	[Departments] as Dep,
	[Wards] as W
where
	DE.[DoctorId] = D.[Id] and
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	datepart(weekday, DE.[StartTime]) < 6 and
	datepart(weekday, DE.[EndTime]) < 6

--7.)
select
	W.[Name] as 'Ward`s name',
	Dep.[Building]
from
	[Doctors] as D,
	[DoctorsExaminations] as DE,
	[Departments] as Dep,
	[Wards] as W
where
	DE.[DoctorId] = D.[Id] and
	D.[Name] = 'Helen' and
	D.[Surname] = 'Williams' and
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id]

--8.)
select
	Dep.[Name] as 'Department`s name',
	D.[Name] + ' ' + D.[Surname] as 'Full Name' 
from
	[Departments] as Dep,
	[Donations] as Don,
	[DoctorsExaminations] as DE,
	[Doctors] as D,
	[Wards] as W
where
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	Don.[DepartmentId] = Dep.[Id] and
	DE.[DoctorId] = D.[Id] and
	Don.[Amount] > 100000

--9.)
select
	Dep.[Name] as 'Department`s name'
from
	[Departments] as Dep,
	[Doctors] as D,
	[DoctorsExaminations] as DE,
	[Wards] as W
where
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	DE.[DoctorId] = D.[Id] and
	D.[Premium] is null

--10.)
select
	S.[Name] as 'Specialization`s name'
from
	[DoctorsExaminations] as DE,
	[DoctorsSpecializations] as DS,
	[Diseases] as [Des],
	[Doctors] as D,
	[Specializations] as S
where
	DE.[DoctorId] = D.[Id] and
	DS.[DoctorId] = D.[Id] and
	DE.[DiseaseId] = [Des].[Id] and
	DS.[SpecializationId] = S.[Id] and
	[Des].[SeverityDegree] > 3

--11.)
select
	Dep.[Name] as 'Department`s name',
	[Des].[Name] as 'Disease`s name'
from
	[Departments] as Dep,
	[DoctorsExaminations] as DE,
	[Diseases] as [Des],
	[Doctors] as D,
	[Wards] as W,
	[Examinations] as E
where
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	DE.[DoctorId] = D.[Id] and
	DE.[DiseaseId] = [Des].[Id] and
	DE.[ExaminationId] = E.[Id] and
	(DateDiff(month, DE.[StartTime], getdate()) between 0 and 6) and
	(DateDiff(month, DE.[EndTime], getdate()) between 0 and 6)

--12.)
select
	Dep.[Name] as 'Department`s name',
	W.[Name] as 'Ward`s name'
from
	[Departments] as Dep,
	[DoctorsExaminations] as DE,
	[Diseases] as [Des],
	[Doctors] as D,
	[Wards] as W,
	[Examinations] as E
where
	DE.[WardId] = W.[Id] and
	W.[DepartmentId] = Dep.[Id] and
	DE.[ExaminationId] = E.[Id] and
	DE.[DoctorId] = D.[Id] and
	DE.[DiseaseId] = [Des].[Id] and
	[Des].[IsContagious] = 1