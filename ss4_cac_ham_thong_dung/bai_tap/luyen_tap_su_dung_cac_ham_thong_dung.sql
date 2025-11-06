use quanlysinhvien;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from subject where Credit = (select max(Credit) from subject);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select sub.SubId, sub.SubName, sub.Credit, sub.Status, m.Mark 
from subject as sub
join mark as m on m.SubId = sub.SubId
where m.Mark = (select max(Mark) from mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.StudentId, s.StudentName, s.Address, s.Phone,s.Status, avg(m.Mark) as diem_trung_binh 
from student as s
join mark as m on m.StudentId = s.StudentId
group by s.StudentId;