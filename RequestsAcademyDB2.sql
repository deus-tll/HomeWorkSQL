--1.)
select
	(T.[Name] + ' ' + T.[Surname]) as 'Full Name',
	G.[Name] as 'Group`s name'
from
	[Teachers] as T, 
	[Groups] as G;

--2.)
select
	F.[Name] as 'Faculty`s name'
from
	[Faculties] as F,
	[Departments] as D
where
	F.[ID] = D.[ID] and
	D.[Financing] > F.[Financing];

--3.)
select
	C.[Surname] as 'Curator`s surname',
	G.[Name] as 'Group`s Name'
from
	[Curators] as C,
	[Groups] as G,
	[GroupsCurators] as GC
where
	GC.[CuratorID] = C.[ID] and
	GC.[GroupID] = G.[ID];

--4.)
select
	T.[Name] as 'Teacher`s name',
	T.[Surname] as 'Teacher`s surname'
from
	[Teachers] as T,
	[Groups] as G,
	[Lectures] as L,
	[GroupsLectures] as GL
where
	GL.[LectureID] = L.[ID] and
	L.[TeacherID] = T.[ID] and
	GL.[GroupID] = G.[ID] and
	G.[Name] = 'P107';

--5.)
select
	 T.[Surname] as 'Teacher`s surname',
	 F.[Name] as 'Faculty`s name'
from
	[Teachers] as T,
	[Groups] as G,
	[Lectures] as L,
	[GroupsLectures] as GL,
	[Faculties] as F,
	[Departments] as D
where
	GL.[LectureID] = L.[ID] and
	L.[TeacherID] = T.[ID] and
	GL.[GroupID] = G.[ID] and
	G.[DepartmentID] = D.[ID] and
	D.[FacultyID] = F.[ID];

--6.)
select
	D.[Name] as 'Department`s name',
	G.[Name] as 'Group`s name'
from
	[Departments] as D,
	[Groups] as G
where
	G.[DepartmentID] = D.[ID];

--7.)
select
	S.[Name] as 'Subject`s name'
from
	[Lectures] as L,
	[Teachers] as T,
	[Subjects] as S
where
	L.[TeacherID] = T.[ID] and
	L.[SubjectID] = S.[ID] and
	T.[Name] = 'Samantha' and
	T.[Surname] = 'Adams';

--8.)
select
	D.[Name] as 'Department`s name'
from
	[Subjects] as S,
	[Departments] as D,
	[GroupsLectures] as GL,
	[Lectures] as L,
	[Groups] as G
where
	GL.[GroupID] = G.[ID] and
	G.[DepartmentID] = D.[ID] and
	GL.[LectureID] = L.[ID] and
	L.[SubjectID] = S.[ID] and
	S.[Name] = 'Database Theory';

--9.)
select
	G.[Name] as 'Group`s name'
from
	[Groups] as G,
	[Departments] as D,
	[Faculties] as F
where
	G.[DepartmentID] = D.[ID] and
	D.[FacultyID] = F.[ID] and
	F.[Name] = 'Computer Science';

--10.)
select
	G.[Name] as 'Group`s name',
	F.[Name] as 'Faculty`s name'
from
	[Groups] as G,
	[Departments] as D,
	[Faculties] as F
where
	G.[Year] = 5 and
	G.[DepartmentID] = D.[ID] and
	D.[FacultyID] = F.[ID]

--11.)
select
	(T.[Name] + ' ' + T.[Surname]) as 'Full Name',
	G.[Name] as 'Group`s name',
	S.[Name] as 'Subject`s name'
from
	[Groups] as G,
	[Subjects] as S,
	[GroupsLectures] as GL,
	[Lectures] as L,
	[Teachers] as T
where
	GL.[GroupID] = G.[ID] and
	GL.[LectureID] = L.[ID] and
	L.[LectureRoom] = 'B103' and
	L.[TeacherID] = T.[ID] and
	L.[SubjectID] = S.[ID]