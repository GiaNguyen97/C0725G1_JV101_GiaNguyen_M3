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
	so_pn int auto_increment primary key,
    ngay_nhap date not null
);

create table vat_tu(
	ma_vat_tu int auto_increment primary key,
    ten_vat_tu varchar(45) not null
);

create table don_dat_hang(
	so_dh int auto_increment primary key,
    ngay_dh date not null,
    ma_nha_cc int,
    foreign key (ma_nha_cc) references nha_cc(ma_nha_cc)
);

create table chi_tiet_phieu_xuat(
	don_gia_xuat double not null,
    so_luong_xuat int default 0,
    so_px int,
    ma_vat_tu int,
    primary key (so_px,ma_vat_tu),
    foreign key (so_px) references phieu_xuat(so_px),
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu)
);

create table chi_tiet_phieu_nhap(
	don_gia_nhap double not null,
    so_luong_nhap int default 0,
    ma_vat_tu int,
    so_pn int,
    primary key (ma_vat_tu,so_pn),
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu),
	foreign key (so_pn) references phieu_nhap(so_pn)
);

create table chi_tiet_don_dat_hang(
	ma_vat_tu int,
    so_dh int,
    primary key (ma_vat_tu,so_dh),
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu),
    foreign key (so_dh) references don_dat_hang(so_dh)
);
