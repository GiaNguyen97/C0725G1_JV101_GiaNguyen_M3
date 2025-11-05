drop database if exists quan_ly_nha_kho;
create database if not exists quan_ly_nha_kho;

use quan_ly_nha_kho;

create table phieu_xuat(
	so_px int auto_increment primary key,
    ngay_xuat datetime not null,
	chi_tiet_phieu_xuat_id int unique
);

create table nha_cc(
	ma_nha_cc int auto_increment primary key,
    ten_nha_cc varchar(50) not null,
    dia_chi varchar(100) not null
);

create table so_dien_thoai(
	sdt_id int primary key,
    so_dien_thoai varchar(10) not null,
    ma_nha_cc int,
    foreign key (ma_nha_cc) references nha_cc(ma_nha_cc)
);

create table phieu_nhap(
);
