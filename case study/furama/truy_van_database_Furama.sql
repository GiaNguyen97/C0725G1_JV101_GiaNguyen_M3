use database_furama;

-- câu 2 : Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
select *
from nhan_vien nv
where (nv.ho_ten like 'H% %' or nv.ho_ten like 'T% %' or nv.ho_ten like 'K% %')
  and char_length(nv.ho_ten) <= 15;

-- câu 3: Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select *
from khach_hang kh
where ((year(kh.ngay_sinh) <= year(curdate()) - 17 and month(kh.ngay_sinh) <= month(curdate()) and
        day(kh.ngay_sinh) <= day(curdate()))
    or year(kh.ngay_sinh) <= year(curdate()) - 18)
  and ((year(kh.ngay_sinh) >= year(curdate()) - 49 and month(kh.ngay_sinh) >= month(curdate()) and
        day(kh.ngay_sinh) >= day(curdate()))
    or year(kh.ngay_sinh) >= year(curdate()) - 50)
  and (kh.dia_chi like '%, Đà Nẵng' or kh.dia_chi like '%, Quảng Trị');

/* câu 4: Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”. */
select kh.ma_khach_hang, kh.ho_ten, count(hd.ngay_lam_hop_dong) as so_lan_dat_phong
from khach_hang as kh
         join hop_dong as hd on kh.ma_khach_hang = hd.ma_khach_hang
         join loai_khach as lk on kh.ma_loai_khach = lk.ma_loai_khach
where lk.ten_loai_khach = 'Diamond'
group by kh.ma_khach_hang
order by so_lan_dat_phong asc;

/* Câu 5: Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
(Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, 
với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. 
(những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra). */
select kh.ma_khach_hang,
       kh.ho_ten,
       lk.ten_loai_khach,
       hd.ma_hop_dong,
       dv.ten_dich_vu,
       hd.ngay_lam_hop_dong,
       hd.ngay_ket_thuc,
       sum(dv.chi_phi_thue + coalesce(hdct.so_luong * dvdk.gia, 0)) as tong_tien
from khach_hang as kh
         left join hop_dong as hd on kh.ma_khach_hang = hd.ma_khach_hang
         left join loai_khach as lk on kh.ma_loai_khach = lk.ma_loai_khach
         left join dich_vu as dv on hd.ma_dich_vu = dv.ma_dich_vu
         left join hop_dong_chi_tiet as hdct on hd.ma_hop_dong = hdct.ma_hop_dong
         left join dich_vu_di_kem as dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by kh.ma_khach_hang, hd.ma_hop_dong;

/* Câu 6: Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3). */
select dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue, ldv.ten_loai_dich_vu
from dich_vu as dv
         left join loai_dich_vu as ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where dv.ma_dich_vu not in
      (select dv.ma_dich_vu
       from dich_vu as dv
                left join loai_dich_vu as ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
                left join hop_dong as hd on dv.ma_dich_vu = hd.ma_dich_vu
                left join khach_hang as kh on hd.ma_khach_hang = kh.ma_khach_hang
       where month(hd.ngay_lam_hop_dong) <= 3
          or month(hd.ngay_ket_thuc) <= 3)
group by dv.ma_dich_vu;

/* Câu 7: Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu 
của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021. */
select dv.ma_dich_vu,
       dv.ten_dich_vu,
       dv.dien_tich,
       dv.so_nguoi_toi_da,
       dv.chi_phi_thue,
       ldv.ten_loai_dich_vu
from dich_vu as dv
         join loai_dich_vu as ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where dv.ma_dich_vu in (select ma_dich_vu
                        from hop_dong
                        where year(ngay_lam_hop_dong) = 2020)
  and dv.ma_dich_vu not in (select ma_dich_vu
                            from hop_dong
                            where year(ngay_lam_hop_dong) = 2021);


/* Câu 8: Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau. 
Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên. */
-- Cách 1 dùng distinct
select distinct kh.ho_ten
from khach_hang as kh
         join hop_dong as hd on kh.ma_khach_hang = hd.ma_khach_hang;

-- Cách 2 dùng group by
select kh.ho_ten
from khach_hang as kh
         join hop_dong as hd on kh.ma_khach_hang = hd.ma_khach_hang
group by kh.ma_khach_hang;

-- Cách 3 dùng subquery
select ho_ten
from khach_hang
where ma_khach_hang in (select ma_khach_hang from hop_dong);

/* Câu 9: Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 
thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng. */

select month(bang_tong_tien.ngay_lam_hop_dong) as thang,
       count(bang_tong_tien.ho_ten)            as so_khach_dat_dich_vu,
       sum(bang_tong_tien.tong_tien)           as doanh_thu
from (select kh.ho_ten,
             hd.ngay_lam_hop_dong,
             sum(dv.chi_phi_thue + coalesce(hdct.so_luong * dvdk.gia, 0)) as tong_tien
      from hop_dong as hd
               left join khach_hang as kh on hd.ma_khach_hang = kh.ma_khach_hang
               left join loai_khach as lk on kh.ma_loai_khach = lk.ma_loai_khach
               left join dich_vu as dv on hd.ma_dich_vu = dv.ma_dich_vu
               left join hop_dong_chi_tiet as hdct on hd.ma_hop_dong = hdct.ma_hop_dong
               left join dich_vu_di_kem as dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
      where year(hd.ngay_lam_hop_dong) = 2021
      group by hd.ma_hop_dong) as bang_tong_tien
group by thang
order by thang;

/* Câu 10: Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm.
   Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem
   (được tính dựa trên việc sum so_luong ở dich_vu_di_kem). */
select hd.ma_hop_dong,
       hd.ngay_lam_hop_dong,
       hd.ngay_ket_thuc,
       hd.tien_dat_coc,
       coalesce(sum(hdct.so_luong), 0) as so_luong_dich_vu_di_kem
from hop_dong as hd
         left join hop_dong_chi_tiet as hdct on hd.ma_hop_dong = hdct.ma_hop_dong
group by hd.ma_hop_dong;

/* Câu 11: Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng
   có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”. */
select dvdk.ma_dich_vu_di_kem, dvdk.ten_dich_vu_di_kem
from dich_vu_di_kem as dvdk
         join hop_dong_chi_tiet as hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
         join hop_dong as hd on hdct.ma_hop_dong = hd.ma_hop_dong
         join khach_hang as kh on hd.ma_khach_hang = kh.ma_khach_hang
         join loai_khach as lk on kh.ma_loai_khach = lk.ma_loai_khach
where lk.ten_loai_khach = 'Diamond'
  and (kh.dia_chi like '%Vinh' or kh.dia_chi like '%Quảng Ngãi');

/* Câu 12: Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng),
   ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc
   của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được
   khách hàng đặt vào 6 tháng đầu năm 2021. */
select hd.ma_hop_dong,
       nv.ho_ten                       as nhan_vien,
       kh.ho_ten                       as khach_hang,
       kh.so_dien_thoai,
       dv.ten_dich_vu,
       coalesce(sum(hdct.so_luong), 0) as so_luong_dich_vu_di_kem,
       hd.tien_dat_coc
from hop_dong as hd
         left join khach_hang as kh on hd.ma_khach_hang = kh.ma_khach_hang
         left join nhan_vien as nv on hd.ma_nhan_vien = nv.ma_nhan_vien
         left join dich_vu as dv on hd.ma_dich_vu = dv.ma_dich_vu
         left join hop_dong_chi_tiet as hdct on hd.ma_hop_dong = hdct.ma_hop_dong
where hd.ma_hop_dong in (select ma_hop_dong
                         from hop_dong
                         where year(ngay_lam_hop_dong) = 2020
                           and month(ngay_lam_hop_dong) >= 10)
  and hd.ma_hop_dong not in (select ma_hop_dong
                             from hop_dong
                             where year(ngay_lam_hop_dong) = 2021
                               and month(ngay_lam_hop_dong) <= 6)
group by hd.ma_hop_dong;

/* Câu 13:  Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
   (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau). */
select dvdk.ma_dich_vu_di_kem, ten_dich_vu_di_kem, sum(so_luong) as max
from dich_vu_di_kem dvdk
         join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
         join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
         join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
group by dvdk.ma_dich_vu_di_kem, ten_dich_vu_di_kem
having sum(hdct.so_luong) = (select max(t.so_luong)
                             from (select sum(hdct2.so_luong) as so_luong
                                   from dich_vu_di_kem dvdk2
                                            join hop_dong_chi_tiet hdct2
                                                 on dvdk2.ma_dich_vu_di_kem = hdct2.ma_dich_vu_di_kem
                                   group by dvdk2.ma_dich_vu_di_kem) t);

/* Câu 14:  Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
   Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung
   (được tính dựa trên việc count các ma_dich_vu_di_kem).  */
select hdct.ma_hop_dong,
       ldv.ten_loai_dich_vu,
       dvdk.ten_dich_vu_di_kem,
       count(hdct.ma_dich_vu_di_kem) as so_lan_su_dung
from loai_dich_vu ldv
         join dich_vu dv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
         join hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu
         join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
         join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
where hdct.ma_dich_vu_di_kem in (select ma_dich_vu_di_kem
                                 from hop_dong_chi_tiet
                                 group by ma_dich_vu_di_kem
                                 having COUNT(*) = 1)
group by hdct.ma_hop_dong, ldv.ten_loai_dich_vu, dvdk.ten_dich_vu_di_kem
order by hdct.ma_hop_dong, ldv.ten_loai_dich_vu, dvdk.ten_dich_vu_di_kem;
/* Câu 15: Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan,
   so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021. */
select nv.ma_nhan_vien, ho_ten, so_dien_thoai, dia_chi, coalesce(count(hd.ma_nhan_vien), 0) as so_luong
from nhan_vien nv
         left join hop_dong hd on nv.ma_nhan_vien = hd.ma_nhan_vien
where (year(ngay_lam_hop_dong) between 2020 and 2021)
group by nv.ma_nhan_vien, ho_ten, so_dien_thoai, dia_chi
having count(hd.ma_nhan_vien) <= 3;
/*Câu 16: Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.alter */
-- thay select bằng delete
select nv.ma_nhan_vien
from nhan_vien nv
         left join hop_dong hd on hd.ma_nhan_vien = nv.ma_nhan_vien
where hd.ma_hop_dong is null;

/* Câu 17: Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
   chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ. */
update khach_hang
set ma_loai_khach = 1
where ma_khach_hang in (select *
                        from (select kh.ma_khach_hang
                              from loai_khach lk
                                       join khach_hang kh on lk.ma_loai_khach = kh.ma_loai_khach
                                       join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
                                       join hop_dong_chi_tiet hdct on hdct.ma_hop_dong = hd.ma_hop_dong
                                       join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
                                       join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
                              where lk.ten_loai_khach like 'Platinium'
                              group by kh.ma_khach_hang
                              having sum(ifnull(chi_phi_thue, 0) + ifnull(so_luong, 0) * ifnull(gia, 0)) > 10000000) t);
/* Câu 18: Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng). */
SET SQL_SAFE_UPDATES = 0;
delete khach_hang
from khach_hang
where khach_hang.ma_khach_hang in (select temp.ma_khach_hang
                                   from (select kh.ma_khach_hang
                                         from khach_hang kh
                                                  join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
                                         where year(hd.ngay_lam_hop_dong) < 2021)
                                            as temp);
SET SQL_SAFE_UPDATES = 1;
/* Câu 19: Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi. */
select dvdk.ma_dich_vu_di_kem, ten_dich_vu_di_kem, sum(hdct.so_luong), gia
from dich_vu_di_kem dvdk
         left join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
group by dvdk.ma_dich_vu_di_kem, ten_dich_vu_di_kem, gia;
SET SQL_SAFE_UPDATES = 0;
update dich_vu_di_kem as dvdk
set dvdk.gia = dvdk.gia * 2
where dvdk.ma_dich_vu_di_kem in (select ma_dich_vu_di_kem
                                 from (select ma_dich_vu_di_kem, sum(hdct.so_luong)
                                       from hop_dong_chi_tiet hdct
                                       group by ma_dich_vu_di_kem
                                       having sum(hdct.so_luong) > 10) as t);
SET SQL_SAFE_UPDATES = 1;
/* Câu 20: Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống,
   thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi. */
select ma_khach_hang, ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi
from khach_hang
union all
select ma_nhan_vien, nhan_vien.ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi
from nhan_vien;
