create database quanlisinhvienss5;
use quanlisinhvienss5;
create table students(
studentId int auto_increment primary key,
studentName varchar(50),
age int,
email varchar(255)
);
create table classes (
classId int auto_increment primary key,
className varchar(10)
);
create table classStudent(
studentId int,
foreign key (studentId) references students(studentId),
classId int,
foreign key (classId) references classes(classId)
);
create table subjects(
subjectId int auto_increment primary key,
subjectName varchar(20)
);
create table marks(
mark int,
subjectId int ,
foreign key(subjectId) references subjects(subjectId),
studentId int,
foreign key (studentId) references students(studentId)
);

insert into students(studentName,age,email) values
("Nguyễn Văn Quang",18,"an@yahoo.com"),
("Nguyễn Công Vinh",20,"vinh@gmial.com"),
("Nguyễn Văn Quyền",19,"quyen"),
("Phạm Thanh Bình",25,"binh@com"),
("Nguyễn Văn Tài Em",30,"taiem@sport.vn");
insert into classes(className) values
("C0706L"),("C0708G");
insert into classStudent(studentId,classId) values
(1,1),(2,1),(3,2),(4,2),(5,2);
insert into subjects(subjectname) values
("SQL"),("JAVA"),("C"),("VISUAL BASIC");
insert into marks (mark,subjectid,studentid) values
(8,1,1),(4,2,1),(9,1,1),(7,1,3),(3,1,4),(5,2,5),(8,3,3),(1,3,5),(3,2,4);
-- hiển thị danh sách tất cả học viên
select * from students;
-- Hien thi danh sach tat ca cac mon hoc
select * from subjects;
-- Tinh diem trung binh 
select s.studentId, s.studentName,avg(m.mark) from students s 
join marks m on s.studentId = m.studentId
group by s.studentId,s.studentName;
-- 	Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select s.subjectName, max(m.mark)
from subjects s join marks m on s.subjectId=m.subjectId
where m.mark = (select max(mark) from marks)
group by s.subjectName;
-- 	Danh so thu tu cua diem theo chieu giam
select mark from marks 
order by mark  desc;

create index m
on marks(mark desc);
-- Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table subjects
modify column subjectName varchar(255);
-- 	Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update subjects
set subjectName= concat("Đây là môn học", subjectName);
-- 	Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table students
modify age int check (15< age<50) ;
--  Loai bo tat ca quan he giua cac bang
alter table classStudent drop constraint classstudent_ibfk_1;
alter table classStudent drop constraint classstudent_ibfk_2;
alter table marks drop foreign key marks_ibfk_1;
alter table marks drop foreign key marks_ibfk_2;
-- xóa học viên có id là 1
delete from students where studentId like 1;
-- 	Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students 
add column status bit default 1;
-- 	Cap nhap gia tri Status trong bang Student thanh 0
update students
set status=0;
