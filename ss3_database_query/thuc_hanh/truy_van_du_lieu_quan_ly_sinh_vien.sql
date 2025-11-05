USE QuanLySinhVien;

-- Bước 2: Sử dụng câu lệnh Select * và lấy dữ liệu học viên từ bảng Student để hiển thị danh sách tất cả các học viên như sau:
SELECT *
FROM Student;

-- Bước 3: Để hiển thị danh sách học viên đang theo học cần phải sử dụng câu lệnh select ... from kèm theo where để xét điều kiện truy vấn như sau:
SELECT *
FROM Student
WHERE Status = true;

-- Bước 4: Sử dụng điều kiện where Credit < 10 và from Subject để lấy ra danh sách các môn học có thời gian học nhỏ hơn 10:
SELECT *
FROM Subject
WHERE Credit < 10;

-- Bước 5: Sử dụng câu lệnh Join và where để hiển thị danh sách học viên lớp A1
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S join Class C on S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

-- Bước 6: Hiển thị điểm môn CF của các học viên
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';

