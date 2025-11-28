drop database if exists quan_ly_thuong_mai_codegym;
create database if not exists quan_ly_thuong_mai_codegym;

use quan_ly_thuong_mai_codegym;
 
create table san_pham(
id_san_pham int primary key auto_increment,
ten_san_pham varchar(50),
gia_san_pham int,
muc_giam_gia int,
so_luong_ton_kho int
);

create table nhan_vien(
id_nhan_vien int primary key auto_increment,
ten_nhan_vien varchar(50),
ngay_sinh date,
dia_chi varchar(100)
);

create table khach_hang(
id_khach_hang int primary key auto_increment,
ten_khach_hang varchar(50),
ngay_sinh date,
so_dien_thoai varchar(10),
dia_chi varchar(100),
email varchar(100)
);


create table don_hang(
id_don_hang int primary key auto_increment,
phuong_thuc_thanh_toan varchar(50),
id_khach_hang int,
id_nhan_vien int,
ngay_dat_hang date,
ngay_giao_hang date,
dia_chi_giao_hang varchar(100),
foreign key (id_khach_hang) references khach_hang(id_khach_hang),
foreign key (id_nhan_vien) references nhan_vien(id_nhan_vien)
);

create table gio_hang (
id_don_hang int,
id_san_pham int,
primary key (id_don_hang,id_san_pham),
foreign key (id_don_hang) references don_hang(id_don_hang),
foreign key (id_san_pham) references san_pham(id_san_pham)
);

insert into san_pham(ten_san_pham,gia_san_pham,muc_giam_gia,so_luong_ton_kho) values 
	("Sản phẩm A",1000000,10,50),
	("Sản phẩm B",2000000,5,60),
	("Sản phẩm C",3000000,6,70),
	("Sản phẩm D",4000000,5,80),
	("Sản phẩm E",5000000,2,90),
	("Sản phẩm F",6000000,10,10),
	("Sản phẩm G",7000000,6,11),
	("Sản phẩm H",8000000,4,40),
	("Sản phẩm I",9000000,3,30),
	("Sản phẩm J",10000000,7,10);
    
insert into nhan_vien(ten_nhan_vien,ngay_sinh,dia_chi) values
	("Nhân viên A",'1997-10-20',"Đà Nẵng"),
	("Nhân viên B",'1991-09-21',"Đà Nẵng"),
	("Nhân viên C",'1992-08-22',"Đà Nẵng"),
	("Nhân viên D",'1993-07-23',"Đà Nẵng"),
	("Nhân viên E",'1994-06-24',"Đà Nẵng"),
	("Nhân viên F",'1995-05-25',"Đà Nẵng"),
	("Nhân viên G",'1996-04-26',"Đà Nẵng"),
	("Nhân viên H",'1998-03-27',"Đà Nẵng"),
	("Nhân viên I",'1999-02-28',"Đà Nẵng"),
	("Nhân viên J",'1990-01-29',"Đà Nẵng");
    
insert into khach_hang(ten_khach_hang,ngay_sinh,so_dien_thoai,dia_chi,email) values
	('Khách hàng A','1990-01-01','0905111111','Hà Nội','khachhanga@gmail.com'),
	('Khách hàng B','1991-02-01','0905222222','Đà Nẵng','khachhangb@gmail.com'),
	('Khách hàng C','1992-03-01','0905333333','Gia Lai','khachhangc@gmail.com'),
	('Khách hàng D','1993-04-01','0905444444','Quảng Nam','khachhangd@gmail.com'),
	('Khách hàng E','1994-05-01','0905555555','Quảng Trị','khachhange@gmail.com'),
	('Khách hàng F','1995-06-01','0905666666','Nghệ An','khachhangf@gmail.com'),
	('Khách hàng G','1996-07-01','0905777777','Đà Nẵng','khachhangg@gmail.com'),
	('Khách hàng H','1997-08-01','0905888888','Hà Nội','khachhangh@gmail.com'),
	('Khách hàng I','1998-09-01','0905999999','Hà Nội','khachhangi@gmail.com'),
	('Khách hàng J','1999-11-01','0905123456','Hà Nội','khachhangj@gmail.com');

insert into don_hang(phuong_thuc_thanh_toan,id_khach_hang,id_nhan_vien,ngay_dat_hang,ngay_giao_hang,dia_chi_giao_hang) values
	('Tiền mặt',1,1,'2025-01-01','2025-02-02','Số 1, đường A'),
	('Chuyển khoản',2,2,'2025-02-02','2025-03-03','Số 2, đường B'),
	('Tiền mặt',3,1,'2025-03-03','2025-04-04','Số 3, đường C'),
	('Chuyển khoản',4,3,'2025-04-04','2025-05-05','Số 4, đường D'),
	('Tiền mặt',5,5,'2025-05-05','2025-06-06','Số 5, đường F'),
	('Chuyển khoản',6,7,'2025-06-06','2025-07-07','Số 6, đường G'),
	('Chuyển khoản',7,3,'2025-07-07','2025-08-08','Số 7, đường H'),
	('Tiền mặt',8,2,'2025-08-08','2025-09-09','Số 8, đường I'),
	('Tiền mặt',9,4,'2025-09-09','2025-10-10','Số 9, đường J'),
	('Tiền mặt',10,6,'2025-10-10','2025-11-11','Số 10, đường K');
    
insert into gio_hang values 
(1,1),
(1,2),
(1,3);

insert into gio_hang values 
(2,2),
(2,3),
(2,4);

insert into gio_hang values 
(3,1),
(3,2),
(3,3);

insert into gio_hang values 
(4,4),
(4,5),
(4,6);

insert into gio_hang values 
(5,1),
(5,2),
(5,3);

insert into gio_hang values 
(6,6),
(6,7),
(6,8);

insert into gio_hang values 
(7,1),
(7,2),
(7,3);

insert into gio_hang values 
(8,1),
(8,4),
(8,3);

insert into gio_hang values 
(9,10),
(9,2),
(9,9);

insert into gio_hang values 
(10,8),
(10,9),
(10,5);