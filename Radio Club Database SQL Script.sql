/*
Bennett, Josiah
Web Databases
Finalized Physical Model
4/25/12
*/

use master;

 --Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = 'radioclub'
)
DROP DATABASE radioclub;
GO

--creates the database for radioclub
create database radioclub
go 
use radioclub;
go

--Tables

--Create table member.
create table member(
memberid int identity primary key,
fname varchar(25)not null,
mi varchar(1),
lname varchar(25)not null,
memberlength varchar(2),
committee varchar(25));

--Create table project.
create table project(
projectid int identity primary key,
memberid int,
projectname varchar(25)not null,
projecttype varchar(10),
projectleader varchar(25)not null
);

--Create table committee.
create table committee(
committeeid int identity primary key,
committeename varchar(25));


--Create table committeeproject.
create table committeeproject(
projectid int,
projectname varchar(25),
committeeid int,
primary key(projectid,committeeid));

--Create table committeemember.
create table committeemember(
memberid int,
fname varchar(25),
lname varchar(25),
committeeid int,
primary key(memberid,committeeid));

--Create table dues.
create table dues(
duesid int identity primary key not null,
fname varchar(25),
lname varchar(25),
memberid int not null,
duesamount decimal
);

--Indexes

--Creates an index on the column (lname) on table member.  
create index idx_member_lname on member(lname);

--Creates an index on the columns (fname and lname) on table member.  
create index idx_member_fname_lname on member(fname,lname);

--Creates an index on the column (committeename) on table committee.  
create index idx_committee_name on committee(committeename);

--Creates an index on the column (projectname) on table project.  
create index idx_project_name on project(projectname);

--Foreign Keys

--Constraint for table dues.
alter table dues add constraint fk_dues_member foreign key (memberid)references member(memberid);

--Constraint for table project.
alter table project add constraint fk_project_member foreign key (memberid)references member(memberid);

--Constraints for table committeeproject.
alter table committeeproject add constraint fk_committeeproject_project foreign key (projectid)references project(projectid);
alter table committeeproject add constraint fk_committeeproject_committee foreign key (committeeid)references committee(committeeid);

--Constraints for table committeemember.
alter table committeemember add constraint fk_committeemember_member foreign key (memberid)references member(memberid);
alter table committeemember add constraint fk_committeemember_committee foreign key (committeeid)references committee(committeeid);



--Insert Statements

--Inputs data into table member.
insert into member (fname,mi,lname,memberlength,committee)values('Josiah','J','Bennett',2,'Executive');
insert into member (fname,mi,lname,memberlength,committee)values('Alexandria','K','Young',2,'Studio');
insert into member (fname,mi,lname,memberlength,committee)values('John','C','Stahlman',2,'Executive');
insert into member (fname,mi,lname,memberlength,committee)values('Vincent',null,'Petrone',2,'Executive');
insert into member (fname,mi,lname,memberlength,committee)values('Tyler',null,'Crozure',2,'Studio');
insert into member (fname,mi,lname,memberlength,committee)values('Johnny','R','Jefferson',3,'Executive');
insert into member (fname,mi,lname,memberlength,committee)values('Kali',null,'Learn',1,'Studio');
insert into member (fname,mi,lname,memberlength,committee)values('Connor',null,'Holton',1,'Studio');
insert into member (fname,mi,lname,memberlength,committee)values('Cody','A','Souder',2,'Executive');
insert into member (fname,mi,lname,memberlength,committee)values('Robert',null,'Small',3,'Studio');

--Inputs data into table dues.
insert into dues (fname,lname,memberid,duesamount)values('Josiah','Bennett',1,'10.00');
insert into dues (fname,lname,memberid,duesamount)values('Alexandria','Young',2,'10.00');
insert into dues (fname,lname,memberid,duesamount)values('John','Stahlman',3,'10.00');
insert into dues (fname,lname,memberid,duesamount)values('Vincent','Petrone',4,'10.00');
insert into dues (fname,lname,memberid,duesamount)values('Tyler','Crozure',5,'10.00');
insert into dues (fname,lname,memberid,duesamount)values('Johnny','Jefferson',6,'5.00');
insert into dues (fname,lname,memberid,duesamount)values('Kali','Learn',7,'15.00');
insert into dues (fname,lname,memberid,duesamount)values('Connor','Holton',8,'15.00');
insert into dues (fname,lname,memberid,duesamount)values('Cody','Souder',9,'10.00');
insert into dues (fname,lname,memberid,duesamount)values('Robert','Small',10,'5.00');

--Inputs data into table committee.
insert into committee (committeename) values ('Executive');
insert into committee (committeename) values ('Studio');

--Inputs data into table project.
insert into project(memberid,projectname,projecttype,projectleader)values(3,'Alumni Weekend Event','Community','John Stahlman');
insert into project(memberid,projectname,projecttype,projectleader)values(3,'Weekend Radio Show Events','Community','John Stahlman');
insert into project(memberid,projectname,projecttype,projectleader)values(4,'Club Night Event','Membership','Vincent Petrone');
insert into project(memberid,projectname,projecttype,projectleader)values(1,'Member Management','Membership','Josiah Bennett');

--Inputs data into table committeemember.
insert into committeemember (memberid,fname,lname,committeeid)values(1,'Josiah','Bennett',1);
insert into committeemember (memberid,fname,lname,committeeid)values(2,'Alexandria','Young',2);
insert into committeemember (memberid,fname,lname,committeeid)values(3,'John','Stahlman',1);
insert into committeemember (memberid,fname,lname,committeeid)values(4,'Vincent','Petrone',1);
insert into committeemember (memberid,fname,lname,committeeid)values(5,'Tyler','Crozure',2);
insert into committeemember (memberid,fname,lname,committeeid)values(6,'Johnny','Jefferson',1);
insert into committeemember (memberid,fname,lname,committeeid)values(7,'Kali','Learn',2);
insert into committeemember (memberid,fname,lname,committeeid)values(8,'Connor','Holton',2);
insert into committeemember (memberid,fname,lname,committeeid)values(9,'Cody','Souder',1);
insert into committeemember (memberid,fname,lname,committeeid)values(10,'Robert','Small',2);

--Inputs data into table committeeproject.
insert into committeeproject(projectid,projectname,committeeid)values(1,'Alumni Weekend Event',2);
insert into committeeproject(projectid,projectname,committeeid)values(2,'Weekend Radio Show Events',2);
insert into committeeproject(projectid,projectname,committeeid)values(3,'Club Night Event',2);
insert into committeeproject(projectid,projectname,committeeid)values(4,'Member Management',1);




--Views

--Gives all member dues without filter.
go
CREATE VIEW memberdues AS
SELECT m.memberid as 'Member ID',m.fname as 'First Name',m.lname as 'Last Name',d.duesamount as 'Amount Due'
FROM member m
join dues d on m.memberid=d.memberid
group by d.duesamount,m.memberid,m.fname,m.lname


--Gives the member's name alone with the project they are currently working on.
go
CREATE VIEW memberproject AS
SELECT m.memberid as 'Member ID',m.fname as 'First Name',m.lname as 'Last Name',p.projectname as 'Project'
FROM member m
join project p on m.memberid=p.memberid

--Gives the member name along with the total amount of dues they owe based on a selected amount.
go
CREATE VIEW membertotaldues AS
SELECT m.memberid as 'Member ID',m.fname as 'First Name',m.lname as 'Last Name', d.duesamount as 'Amount Due'
FROM member m
join dues d on m.memberid=d.memberid
where d.duesamount in ('10.00')
group by d.duesamount,m.memberid,m.fname,m.lname

--Helps users find a member along with that member's committee.
go
CREATE VIEW membercommittee AS
SELECT cm.memberid as 'Member ID',cm.fname as 'First Name',cm.lname as 'Last Name', c.committeename as'Committee'
FROM committeemember cm
join committee c on cm.committeeid=c.committeeid



--Stored Procedures

--Looks up members based on committee ranking.
go
create procedure membercommitteelookup
@committee varchar(15)
as
	begin
		select memberid as 'Member ID',fname+lname as 'Member Name' from member
		where committee = @committee;
end
go
exec membercommitteelookup 'Studio';



--Updates a member's committee ranking.
go
create procedure updatecommittee
	@fname varchar(25),
	@lname varchar(25),
	@newcommittee varchar(15)
as
begin
	update member
		set committee=@newcommittee
		where fname=@fname and lname=@lname;
	end;
go
exec updatecommittee 'John','Stahlman','Executive';
select*from member



--Find a member by memberid
go
create procedure membername
	@memberid int,
	@fname varchar(25) output,
	@lname varchar(25) output
AS
BEGIN
	select @fname=fname,@lname=lname
	from member
	where memberid=@memberid;
END;
Go

declare @firstname varchar(25);
declare @lastname varchar(25);

EXEC membername '1',@firstname output,@lastname output;
SELECT @firstname+@lastname as Member;



