use quanlybanhang;

insert into customer values (1,'Minh Quan',10),(2,'Ngoc Anh',20),(3,'Hong Ha',50);
insert into `order` values (1, 1, '2006-03-21', null),(2, 2, '2006-03-23', null),(3, 1, '2006-03-16', null);
insert into product values (1,'May Giat',3),(2,'Tu Lanh',5),(3,'Dieu Hoa',7),(4,'Quat',1),(5,'Bep Dien',2);
insert into orderdetail values (1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);

select * from customer;
select * from `order`;
select * from product;
select * from orderdetail;

