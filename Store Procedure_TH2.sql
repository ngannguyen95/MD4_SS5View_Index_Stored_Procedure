use classicmodels;
-- tạo procedure
DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
SELECT *FROM Customers;
END //

-- gọi procedure 
CALL findAllCustomers();
-- Xóa procedure

DROP PROCEDURE `findAllCustomers`;
DELIMITER //
create procedure findAllCustomers()
begin
select * from customers where customerNumber = 175;
end //
DELIMITER ;
call findAllCustomers();
