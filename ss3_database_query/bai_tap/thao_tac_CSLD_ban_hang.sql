use quanlybanhang;

insert into customer values (1,'Minh Quan',10),(2,'Ngoc Anh',20),(3,'Hong Ha',50);
insert into `order` values (1, 1, '2006-03-21', null),(2, 2, '2006-03-23', null),(3, 1, '2006-03-16', null);
insert into product values (1,'May Giat',3),(2,'Tu Lanh',5),(3,'Dieu Hoa',7),(4,'Quat',1),(5,'Bep Dien',2);
insert into orderdetail values (1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);

select * from customer;
select * from `order`;
select * from product;
select * from orderdetail;

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select oID, oDate, oTotalPrice from `order`;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.cID, c.cName, c.cAge, GROUP_CONCAT( distinct p.pName) AS product_list from customer as c
join `order` as o on c.cID = o.cID
join orderdetail as od on o.oID = od.oID
join product as p on od.pID = p.pID
group by c.cID;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.cName from customer as c
left join `order` as o on c.cID = o.cID
where o.oID is null;

/* Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
(giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
Giá bán của từng loại được tính = odQTY*pPrice) */
select o.oID, oDate, sum(od.odQTY*p.pPrice) as tong_hoa_don
from `order` as o
join orderdetail as od on o.oID = od.oID
join product as p on od.pID = p.pID
group by o.oID;
