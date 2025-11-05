use quanlysinhvien;

select * from student;
select * from class;
select * from mark;
select * from subject;
-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student where StudentName like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from class where month(startdate) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from subject where Credit between 3 and 5;

-- 	Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student
set classid = 2
where studentid = (
    select sid from (
        select studentid as sid from student where studentname = 'Hung'
    ) as t
);

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT s.studentname, sub.subname, m.mark
FROM student AS s
JOIN mark AS m ON s.studentid = m.studentid
JOIN subject AS sub ON m.subid = sub.subid
ORDER BY m.mark DESC, s.studentname ASC;