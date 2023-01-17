--1.)
select
	Count(distinct T.[ID]) as 'Number of Teachers'
from
	[Departments] as Dep,
	[Teachers] as T,
	[Groups] as G,
	[Lectures] as L,
	[GroupsLectures] as GL
where
	GL.[GroupID] = G.[ID] and
	G.[DepartmentID] = Dep.[ID] and
	Dep.[Name] = 'Software Development' and
	GL.[LectureID] = L.[ID] and
	L.[TeacherID] = T.[ID]

--2.)
select
	Count(*) as 'Number of Lectures'
from
	[GroupsLectures] as GL,
	[Lectures] as L,
	[Teachers] as T
where
	GL.[LectureID] = L.[ID] and
	L.[TeacherID] = T.[ID] and
	T.[Name] = 'Dave' and
	T.[Surname] = 'McQueen'

--3.)
select
	Count(*) as 'Number of Lectures'
from
	[GroupsLectures] as GL,
	[Lectures] as L
where
	GL.[LectureID] = L.[ID] and
	L.[LectureRoom] = 'D201'

--4.)
select
	L.[LectureRoom],
	Count(*) as 'Number of Lectures'
from
	[GroupsLectures] as GL,
	[Lectures] as L
where
	GL.[LectureID] = L.[ID]
group by
	L.[LectureRoom]

--5.)
select
	Count(distinct S.[ID]) as 'Number of Students'
from
	[GroupsLectures] as GL,
	[Lectures] as L,
	[Teachers] as T,
	[Groups] as G,
	[Students] as S,
	[Subjects] as Sub
where
	GL.[GroupID] = G.[ID] and
	S.[GroupID] = G.[ID] and
	GL.[LectureID] = L.[ID] and
	L.[TeacherID] = T.[ID] and
	T.[Name] = 'Jack' and
	T.[Surname] = 'Underhill' and
	L.[SubjectID] = Sub.[ID]

--6.)
select
	Avg(distinct T.[Salary]) as 'Average Salary'
from
	[GroupsLectures] as GL,
	[Teachers] as T,
	[Groups] as G,
	[Departments] as Dep,
	[Lectures] as L,
	[Faculties] as F
where
	GL.[LectureID] = L.[ID] and
	L.[TeacherID] = T.[ID] and
	GL.[GroupID] = G.[ID] and
	G.[DepartmentID] = Dep.[ID] and
	Dep.[FacultyID] = F.[ID] and
	F.[Name] = 'Computer Science'

--7.)
select
	Min(GC.[CountOfStud]) as 'Min numbers of students',
	Max(GC.[CountOfStud]) as 'Max numbers of students'
from
	[Groups] as G,
	(
		select
			Count(Stud.[ID]) as 'CountOfStud'
		from
			[Students] as Stud,
			[Groups] as Gr
		where
			Stud.[GroupID] = Gr.[ID]
		group by Gr.[Name]
	) as GC

--8.)
select
	Avg(D.[Financing]) as 'Average financing'
from
	[Departments] as D

--9.)
select
	T.[Name] + ' ' + T.[Surname] as 'FullName',
	Count(*) as 'Number of Subjects'
from
	[Lectures] as L,
	[Teachers] as T,
	[Subjects] as S
where
	L.[TeacherID] = T.[ID] and
	L.[SubjectID] = S.[ID]
group by
	T.[Name],T.[Surname]

--10.)
select distinct
	L.[DayOfWeek],
	CL.[ContOfLectures]
from
	[Lectures] as L,
	(
		select
			Count(Lec.[ID]) as 'ContOfLectures',
			Lec.[DayOfWeek] as DOW
		from
			[Lectures] as Lec
		group by
			Lec.[DayOfWeek]
	) as CL
where
	L.[DayOfWeek] = CL.[DOW]

--11.)
select
	L.[LectureRoom] as 'Lecture`s room',
	Count(distinct Dep.[ID]) as 'Count of Departments'
from
	[GroupsLectures] as GL,
	[Groups] as G,
	[Lectures] as L,
	[Departments] as Dep
where
	GL.[GroupID] = G.[ID] and
	G.[DepartmentID] = Dep.[ID] and
	GL.[LectureID] = L.[ID]
group by
	L.[LectureRoom]

--12.)
select
	F.[Name] as 'Facultie`s name',
	Count(distinct S.[ID]) as 'Count of Subjects'
from
	[GroupsLectures] as GL,
	[Groups] as G,
	[Lectures] as L,
	[Departments] as Dep,
	[Subjects] as S,
	[Faculties] as F
where
	GL.[LectureID] = L.[ID] and
	L.[SubjectID] = S.[ID] and
	GL.[GroupID] = G.[ID] and
	G.[DepartmentID] = Dep.[ID] and
	Dep.[FacultyID] = F.[ID]
group by
	F.[Name]

--13.)
select
	Count(distinct L.[ID]) as 'Count of Lectures',
	T.[Name] + ' ' + T.[Surname] as 'Teacher',
	L.LectureRoom
from
	[Lectures] as L,
	[Subjects] as S,
	[Teachers] as T
where
	L.[TeacherID] = T.[ID] and
	L.[SubjectID] = S.[ID]
group by
	T.[Name] + ' ' + T.[Surname],
	L.LectureRoom