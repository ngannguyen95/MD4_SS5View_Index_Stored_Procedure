use classicmodels;
-- tạo procedure với tham số loại in
DELIMITER //
CREATE PROCEDURE getCusById
(IN cusNum INT(11))
BEGIN
SELECT * FROM customers WHERE customerNumber= cusNum;
END //
DELIMITER ;
CALL getCusById(175);

-- tạo proceduce với tham số loại out
delimiter //
create procedure getCustomersCountByCity(
in in_city varchar(50),
out total int
)
begin 
select count(customerNumber)
into total
from customers
where city= in_city;
end//
delimiter ;
call getCustomersCountByCity('Lyon',@total);
select @total;
-- tạo produre dưới tham số dạng inout
delimiter //
create procedure setCounter(
inout counter int,
in inc int
)
begin
set counter = counter + inc;
end//
delimiter ;
-- gọi store procedure
set @counter =1;
call setCounter(@counter,1);
call setCounter(@counter,1);
call setCounter(@counter,5);
select @counter;
-- tạo view có tên customer_views
create view customer_views as
select customerNumber, customerName, phone
from customers;
-- gọi bảng ảo 
select * from customer_views;
-- cập nhật view customer_views
create or replace view customer_views as
select customerNumber, customerName,contactFirstName, contactLastName,phone
from customers
where city ="Nantes";
-- xóa views
drop view customer_views;

