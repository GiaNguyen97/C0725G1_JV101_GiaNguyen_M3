--  Tạo CSDL và Bảng
drop database if exists company;
CREATE DATABASE if not exists company;

USE company;

CREATE TABLE employees (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      department VARCHAR(50) NOT NULL,
      salary DECIMAL(10,2) NOT NULL
);

-- tạo một trigger để tự động cập nhật trường "department" của bảng "employees" khi thêm 1 bản ghi. Trigger này sẽ kiểm tra mức lương của nhân viên và cập nhật phòng ban tương ứng.
DELIMITER //
CREATE TRIGGER update_department
before INSERT ON employees
FOR EACH ROW
BEGIN
     IF NEW.salary >= 5000 THEN
          SET new.department = 'Management';
     ELSEIF NEW.salary >= 3000 then
          SET new.department = 'Sales';
     ELSE
          SET new.department = 'Support';
     END IF;
END //
DELIMITER ;

-- Demo sử dụng trigger
INSERT INTO employees (name, department, salary) VALUES      
('John Doe', 'A', 3500),
('Jane Smith', 'A', 2000),
('David Johnson', 'A', 6000);

select * from employees;