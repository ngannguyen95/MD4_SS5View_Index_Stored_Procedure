create database studenttest;
use studenttest;
create table test(
testId int auto_increment primary key,
name varchar (20)
);
create table student(
rn int auto_increment primary key,
name varchar (20),
age tinyint,
status bit
);
create table studentTest(
rn int,
foreign key(rn) references student(rn),
testId int,
foreign key (testId) references test(testId),
`date` date,
mark int 
);
insert into student(name,age) values
("Nguyễn Hồng Hà",20),
("Trương Ngọc Anh",30),
("Tuấn Minh",25),
("Dan Trường",22);
insert into test(name) values
("EPC"),("DWMX"),("SQL1"),("SQL2");
insert into studenttest(rn,testId,date,mark) values
(1,1,"2006-7-17",8),
(1,2,"2006-7-18",5),
(1,3,"2006-7-19",7),
(2,1,"2006-7-17",7),
(2,2,"2006-7-18",4),
(2,3,"2006-7-19",2),
(3,1,"2006-7-17",10),
(3,3,"2006-7-18",1);

-- a.	Thêm ràng buộc dữ liệu cho cột age với giá trị thuộc khoảng: 15-55
alter table student
modify age int check(15<age and age<55);
-- b.	Thêm giá trị mặc định cho cột mark trong bảng StudentTest là 0
alter table studenttest
modify mark int default 0;
-- c.	Thêm khóa chính cho bảng studenttest là (RN,TestID)
insert into studenttest(rn,testid) values
(3,2),(4,1),(4,2),(4,3),(4,4);
-- d.	Thêm ràng buộc duy nhất (unique) cho cột name trên bảng Test
alter table test
modify name varchar (20) unique;
-- e.	Xóa ràng buộc duy nhất (unique) trên bảng Test
alter table test drop index name;
-- 3.	Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó,
-- điểm thi và ngày thi giống như hình sau
select (select @stt:=@stt+1) as `stt`,s.name,t.name,st.mark,st.date from (select @stt:=0) r, student s 
join studenttest st on s.rn=st.rn
join test t on st.testid=t.testid;
-- 4.	Hiển thị danh sách các bạn học viên chưa thi môn nào 
select (select @stt:=@stt+1) as `stt`,s.rn,s.name,s.age from (select @stt:=0) r, student s 
join studenttest st on s.rn=st.rn
join test t on st.testid=t.testid
where st.mark like 0 
group by s.rn,s.name,s.age;
-- Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5) như sau
select (select @stt:=@stt+1) as `stt`, s.name, t.name,st.mark from(select @stt:=0) stt, student s join studenttest st on s.rn = st.rn
join test t on st.testId= t.testId 
group by s.name, t.name,st.mark
having st.mark <5;
--  6.	Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. 
select (select @stt:=@stt+1) as `stt`, s.name, avg(st.mark)  from (select @stt:=0) stt, student s join studenttest st on s.rn = st.rn
group by s.name;
-- 7.	Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất như 
select (select @stt:=@stt+1) as `stt`, s.name ,avg(st.mark) from (select @stt:=0) stt, student s join studenttest st on s.rn = st.rn
group by s.name
order by avg(st.mark) desc limit 1;
-- 8.	Hiển thị điểm thi cao nhất của từng môn học
select (select @stt:=@stt+1) as "", t.name, max(st.mark) from (select @stt:=0) stt, studenttest st join test t on st.testId=t.testId
group by t.name;
-- 9.	Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null 
 select s.`name`, t.`name` from student s join studenttest st on s.rn = st.rn
join test t on st.testid = t.testid;
-- Sửa  tuổi của tất cả các học viên mỗi người lên một tuổi
update Student 
set age=age+1;
-- 11.	Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student.
alter table student
modify `status` varchar(10);
-- 12.	Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, 
-- trường hợp còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ 
update student 
set status = case when age <30 then "Young" else "Old" end;
select (select @stt:=@stt+1) as `stt`,s.rn, s.name, s.status from student s;
-- 13.	Hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi 
select (select @stt:=@stt+1) as "",s.name,st.mark,st.date from student s join studenttest st on s.rn = st.rn
order by st.date;
-- Hiển thị các thông tin sinh viên có tên bắt đầu bằng ký tự ‘T’ và điểm thi trung bình >4.5.
-- Thông tin bao gồm Tên sinh viên, tuổi, điểm trung bình
select (select @stt:=@stt+1) as "",s.name,s.age,avg(st.mark) from student s join studenttest st on s.rn = st.rn
group by s.rn 
having s.name like "T%" and avg(st.mark)>4.5 ;
-- 15.	Hiển thị các thông tin sinh viên (Mã, tên, tuổi, điểm trung bình, xếp hạng).
--  Trong đó, xếp hạng dựa vào điểm trung bình của học viên, điểm trung bình cao nhất thì xếp hạng 1.
select (select @stt:=@stt+1) as "Xếp hạng",s.rn,s.name,s.age,avg(st.mark) from (select @stt:=0) stt,  student s join studenttest st on s.rn = st.rn
group by s.rn
order by avg(st.mark) desc;
-- 16.	Sủa đổi kiểu dữ liệu cột name trong bảng student thành nvarchar(max)
alter table student
modify name varchar(255);
-- 17.	Cập nhật (sử dụng phương thức write) cột name trong bảng student với yêu cầu sau:
-- a.	Nếu tuổi >20 -> thêm ‘Old’ vào trước tên (cột name)
-- b.	Nếu tuổi <=20 thì thêm ‘Young’ vào trước tên (cột name)
update student 
set name = case when age> 20 then  concat("Old",`name`) else  concat("Young",`name`) end;
-- Xóa tất cả các môn học chưa có bất kỳ sinh viên nào thi
delete from test where `name` not in (select s.name from student s join studenttest st on s.rn = st.rn);
-- 19.	Xóa thông tin điểm thi của sinh viên có điểm <5. 
delete studenttest from studenttest
where mark <5;