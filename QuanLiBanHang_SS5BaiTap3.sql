create database qlbh;
-- drop database qlbh;
use qlbh;
create table customer(
cid int auto_increment primary key,
cname varchar (25),
cage tinyint
);
create table `order`(
oid int auto_increment primary key,
cid int,
foreign key (cid) references customer(cid),
odate datetime,
ototalPrice  float
);
create table product(
pid int auto_increment primary key,
pname varchar(25),
pprice int
);
create table orderdetail(
oid int,
foreign key(oid) references `order`(oid),
pid int,
foreign key (pid) references product(pid),
odqty int
);
insert into customer(cname,cage) values
("Minh Quan" , 10),
("Ngoc Oanh" , 10),
("Hong Ha" , 10);
insert into `order`(cid,odate,ototalPrice)values
(1,"2006-3-21",null),
(2,"2006-3-23",null),
(1,"2006-3-16",null);
insert into product(pname,pprice) values
("may giat",3),
("tu lanh",5),
("dieu hoa",7),
("quat ",1),
("bep dien ",2);
insert into orderdetail(oid,pid,odqty) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);
-- 2.	Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order,
--  danh sách phải sắp xếp theo thứ tự ngày tháng, hóa đơn mới hơn
select * from `order`
order by odate desc; 
-- 3.	Hiển thị tên và giá của các sản phẩm có giá cao nhất 
select pname,pprice,max(pprice) from product 
where (pprice = (select max(pprice) from product))
group by pname,pprice;
-- 4.	Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách đó 
select c.cname,p.pname from  customer c join `order` o  on c.cid= o.cid
join orderdetail od on o.oid = od.oid
join product p on od.pid = p.pid; 
-- 5.	Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.cname from  customer c left join `order` o  on c.cid= o.cid
where c.cid not in (select cid from `order`);
-- 6.	Hiển thị chi tiết của từng hóa đơn
select od.oid,o.odate,od.odqty,pname,pprice from orderdetail od join product p
join `order` o on o.oid = od.oid; 

-- 7.	Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
-- Giá bán của từng loại được tính = odQTY*pPrice) 
select o.oid,o.odate,od.odqty*p.pprice as "total" from `order` o join orderdetail od
join product p on p.pid= od.pid
group by o.oid,o.odate
order by oid asc;

