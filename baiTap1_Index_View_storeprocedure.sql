create database productdemo;
use productdemo;
create table products(
id int auto_increment primary key,
productCode varchar(5),
productName varchar(20),
productPrice float,
productAmount int,
productDescription varchar(255),
productStatus bit
);

insert into products(productCode,productName,productPrice,productAmount,productDescription,productStatus) values
("p01","quần jean",20000,10,"thịnh hành",1),
("p02","áo dài",50000,15,"thịnh hành",1),
("p03","quần xẻ tà",40000,23,"thịnh hành",1),
("p04","đầm",560000,36,"thịnh hành",1),
("p05","váy sexy",130000,21,"thịnh hành",1);


-- tạo unique index trên bảng products ( sử dụng cột productcode để tạo chỉ mục)
create unique index pCode
on products(productCode);
-- tạo composite index trên bảng product ( sử dụng 2 cột productName, productPrice)
create index ComIndex
on products(productName,productPrice);
-- sử dụng explain để quan sát sql chạy thế nào
explain select *from products where productCode="p03";
-- tạo view với các thông tin:  productCode, productName, productPrice, productStatus
create view product_views as
select productCode, productName, productPrice, productStatus 
from products;
-- sửa đổi view 
create or replace view product_views as
select id, productCode, productName,productPrice,productAmount,productDescription
from products;
-- gọi bảng ảo
select * from product_views;
-- xóa view
drop view product_views;
-- store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure getProductInfor()
begin 
select * from products;
end //
delimiter ;
-- gọi procedure 
call getProductInfor();
-- 	Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure createProduct(
productCode varchar(5),
productName varchar(20),
productPrice float,
productAmount int,
productDescription varchar(255),
productStatus bit
)
begin
insert into products(productCode,productName,productPrice,productAmount,productDescription,productStatus)values
(productCode,productCode,productPrice,productAmount,productDescription,productStatus);
end //
delimiter ;
call createProduct("p08","ủng",16000,15,"phân tầng",0);
-- 	Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure updateById(
idUp int
)
begin 
update products set productName = "quần âu" where id= idUp;
end //
delimiter ;
call updatebyid(6);
-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure deleteById(
idDel int
)
begin 
delete from products where id=idDel;
end //
delimiter ;
call deleteById(6);
