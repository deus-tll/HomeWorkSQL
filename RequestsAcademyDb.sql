use AcademyDb;

/*
alter table [Faculties] add [Dean] nvarchar(max) not null constraint CK_Faculties_Dean check([Dean] <> '');

alter table [Teachers] add [IsAssistant] bit not null default(0);
alter table [Teachers] add [IsProfessor] bit not null default(0);
alter table [Teachers] add [Position] nvarchar(max) not null constraint CK_Teachers_Position check([Position] <> '');
*/


--1.)
select * from [Departments]
order by [Id] desc


--2.)
select
	[Name] as [Group Name],
	[Rating] as [Group Rating]
from
	[Groups];


/*3.)*/
select 
	[Surname],
	[Salary] / [Premium] * 100 as [Rate to the allowance],
	([Salary] / ([Salary] + [Premium])) * 100 as [Rate to the salary]
from
	[Teachers];


--4.)
select
	'The dean of faculty ' + [Name] + ' is ' + [Dean]
from
	[Faculties];


--5.)
select
	[Surname]
from
	[Teachers]
where
	([IsProfessor] = 1 and [Salary] > 1500);


--6.)
select
	[Name]
from
	[Departments]
where
	([Financing] < 11000 or [Financing] > 25000);


--7.)
select
	[Name]
from
	[Faculties]
where
	([Name] <> 'Computer Science');


--8.)
select
	[Surname], [Position]
from
	[Teachers]
where
	([IsProfessor] = 0);


--9.)
select
	[Surname], [Position], [Salary], [Premium]
from
	[Teachers]
where
	([Premium] >= 160 and [Premium] <= 550);


--10.)
select
	[Surname], [Salary]
from
	[Teachers]
where
	([IsAssistant] = 1);


--11.)
select
	[Surname], [Position]
from
	[Teachers]
where
	([EmploymentDate] < '2000-01-01');


--12.)
select
	[Name] as [Name of Department]
from
	[Departments]
where
	([Name] < 'Software Development')
order by [Name];


--13.)
select
	[Surname]
from
	[Teachers]
where
	([IsAssistant] = 1 and [Salary] + [Premium] <= 1200);


--14.)
select
	[Name]
from
	[Groups]
where
	([Year] = 5 and ([Rating] >= 2 and [Rating] <= 4));


--15.)
select
	[Surname]
from
	[Teachers]
where
	([IsAssistant] = 1 and ([Salary] < 550 or [Premium] < 200 ));