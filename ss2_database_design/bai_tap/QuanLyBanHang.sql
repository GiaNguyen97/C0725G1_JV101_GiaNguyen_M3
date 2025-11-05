drop database if exists quanlybanhang;
create database if not exists quanlybanhang;

use quanlybanhang;

create table customer(
	cID int not null auto_increment primary key,
    cName varchar(50)  not null,
    cAge int not null
);

create table `order`(
	oID int not null auto_increment primary key,
    cID int not null,
    oDate datetime not null,
    oTotalPrice float default 0,
    foreign key (cID) references customer (cID)
);

create table product(
	pID int auto_increment not null primary key,
    pName varchar(50) not null,
    pPrice float default 0
);

create table orderdetail(
	oID int not null,
    pID int not null,
    odQTY int default 0,
    primary key(oID,pID),
    foreign key (oID) references `order` (oID),
    foreign key (pID) references product (pID)    
);