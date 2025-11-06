drop database if exists demo_ss5;
create database if not exists demo_ss5;

use demo_ss5;
-- tạo bảng
create table products(
	id int auto_increment primary key,
    product_code varchar(45) not null,
    product_name varchar(100) not null,
    product_price decimal(10,2) not null,
    product_amount int default 0,
    product_description text,
    product_status boolean default 1    
);

-- thêm dữ liệu
insert into products (product_code, product_name, product_price, product_amount, product_description, product_status)
values
('SP001', 'Laptop Dell Inspiron 15', 18500000, 10, 'Laptop 15 inch, i5 Gen 12, RAM 16GB, SSD 512GB', 1),
('SP002', 'Chuột Logitech M330', 450000, 25, 'Chuột không dây Logitech, kết nối USB, pin lâu', 1),
('SP003', 'Bàn phím cơ Akko 3098B', 2200000, 15, 'Bàn phím cơ Bluetooth, RGB, switch Jelly Pink', 1),
('SP004', 'Tai nghe Sony WH-1000XM5', 7900000, 8, 'Tai nghe chống ồn, Bluetooth 5.2, pin 30h', 1),
('SP005', 'Màn hình Samsung 27 inch', 4200000, 12, 'Màn hình Full HD, tần số quét 75Hz, IPS', 1),
('SP006', 'Ổ cứng SSD Kingston 1TB', 1950000, 20, 'SSD tốc độ cao, chuẩn SATA III', 1),
('SP007', 'Loa Bluetooth JBL Go 3', 990000, 18, 'Loa mini chống nước, âm thanh mạnh mẽ', 1),
('SP008', 'Bộ phát WiFi TP-Link Archer AX23', 1600000, 7, 'WiFi 6, tốc độ 1800 Mbps, 4 anten', 1),
('SP009', 'iPhone 15 Pro Max 256GB', 31990000, 5, 'Điện thoại cao cấp của Apple, chip A17 Pro', 1),
('SP010', 'Cáp sạc Anker PowerLine III', 350000, 30, 'Cáp sạc nhanh USB-C to Lightning', 1);

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index i_product_code on products(product_code);
drop index i_product_code on products;

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
create index i_product_name_and_price on products(product_name, product_price);
drop index i_product_name_and_price on products;

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where product_price = 450000 and product_name ='Chuột Logitech M330';
explain select * from products where product_code = 'SP003';

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view w_products as
select product_code, product_name, product_price, product_status 
from products;

select * from w_products;

-- sửa đổi view
update w_products set product_price = 3200000 where product_code = 'SP002';

-- xoá view
drop view w_products;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure display_all()
begin
select  * from products;
end //
delimiter ;

call display_all();

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure add_new_product(in p_product_code varchar(45),in p_product_name varchar(100),in  p_product_price decimal(10,2),in p_product_amount int,in p_product_description text,in  p_product_status boolean)
begin
insert into products (product_code, product_name, product_price, product_amount, product_description, product_status)
values
(p_product_code, p_product_name, p_product_price, p_product_amount, p_product_description, p_product_status);
end //
delimiter ;

call add_new_product( 'SP011', 'Máy in Canon LBP 2900', 3200000,9,'Máy in laser tốc độ cao, dùng hộp mực 303',1);

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure edit_product_by_id(in p_id int, in p_product_code varchar(45),in p_product_name varchar(100),in  p_product_price decimal(10,2),in p_product_amount int,in p_product_description text,in  p_product_status boolean)
begin
	update 	products set 
			product_code = p_product_code, 
			product_name = p_product_name,
			product_price = p_product_price,
			product_amount = p_product_amount,
		product_description = p_product_description, 
		product_status = p_product_status
	where id = p_id;
 end //
 delimiter ;
 
call edit_product_by_id(3,'SP003A','Bàn phím cơ Akko 3098B Plus',2300000,20,'Phiên bản nâng cấp, pin 3000mAh, RGB đẹp hơn',1);

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure delete_product_by_id(in p_id int)
begin
	delete from products
	where id = p_id;
 end //
 delimiter ;
 
 call delete_product_by_id(3);