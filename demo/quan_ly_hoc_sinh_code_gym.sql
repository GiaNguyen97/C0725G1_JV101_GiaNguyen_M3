-- Tạo database
drop database if exists quan_ly_hoc_sinh_codegym;
create database if not exists quan_ly_hoc_sinh_codegym;

use quan_ly_hoc_sinh_codegym;

CREATE TABLE class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    class_type VARCHAR(50) NOT NULL
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

INSERT INTO class (class_name, class_type)
VALUES 
('C0825G1', 'Java Fullstack'),
('C0825L1', 'Frontend'),
('C0725G1', 'Data Analyst');

INSERT INTO student (student_name, class_id)
VALUES
('Tien', 1),
('Toan', 1),
('An', 2),
('Binh', 3),
('Hieu', NULL), 
('Linh', 2);

select * from student;
select * from class;

-- Câu 1: Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào.
SELECT 
    student.student_id,
    student.student_name,
    class.class_name
FROM student
JOIN class ON student.class_id = class.class_id;

-- Câu 2:  Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào, lớp đó thuộc loại lớp nào.
SELECT 
    student.student_id,
    student.student_name,
    class.class_name,
    class.class_type
FROM student
JOIN class ON student.class_id = class.class_id;

-- Câu 3: Lấy ra thông tin các học viên đang theo học tại các lớp kể cả các học viên không theo học lớp nào.
SELECT 
    student.student_id,
    student.student_name,
    class.class_name,
    class.class_type
FROM student
LEFT JOIN class ON student.class_id = class.class_id;

-- Câu 4: Lấy thông tin của các học viên tên ‘Tien’ và ‘Toan’.
SELECT *
FROM student
WHERE student.student_name IN ('Tien', 'Toan');

-- Câu 5: Lấy ra số lượng học viên của từng lớp.
SELECT 
    class.class_id,
    class.class_name,
    COUNT(student.student_id) AS total_students
FROM class
LEFT JOIN student ON class.class_id = student.class_id
GROUP BY class.class_id, class.class_name;

-- Câu 6: Lấy ra danh sách học viên và sắp xếp tên theo alphabet.
SELECT *
FROM student
ORDER BY student.student_name ASC;