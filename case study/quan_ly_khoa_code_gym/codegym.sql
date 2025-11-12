Create DATABASE codegym;
Use codegym;

-- -----------------------------------------------------
-- 1. NHÓM QUẢN LÝ NGƯỜI DÙNG & VAI TRÒ
-- -----------------------------------------------------

-- Bảng lưu các vai trò (ADMIN, TEACHER, STUDENT, GIAO_VU)
CREATE TABLE Role (
                      role_id INT AUTO_INCREMENT PRIMARY KEY,
                      role_name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Tên vai trò'
);

-- Bảng tài khoản trung tâm để đăng nhập
CREATE TABLE User (
                      user_id INT AUTO_INCREMENT PRIMARY KEY,
                      email VARCHAR(255) NOT NULL UNIQUE,
                      password_hash VARCHAR(255) NOT NULL,
                      role_id INT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      FOREIGN KEY (role_id) REFERENCES Role(role_id) ON DELETE SET NULL
);

-- Bảng thông tin chi tiết cho Học viên
CREATE TABLE Student (
                         student_id INT AUTO_INCREMENT PRIMARY KEY,
                         user_id INT NOT NULL UNIQUE,
                         full_name VARCHAR(100) NOT NULL,
                         phone VARCHAR(15),
                         dob DATE,
                         FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Bảng thông tin chi tiết cho Nhân viên (Giáo viên, Giáo vụ, Admin)
CREATE TABLE Staff (
                       staff_id INT AUTO_INCREMENT PRIMARY KEY,
                       user_id INT NOT NULL UNIQUE,
                       full_name VARCHAR(100) NOT NULL,
                       position VARCHAR(100) COMMENT 'Chức vụ',
                       FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- 2. NHÓM QUẢN LÝ NỘI DUNG KHÓA HỌC
-- -----------------------------------------------------

-- Bảng lưu các khóa học (ví dụ: Fullstack Java)
CREATE TABLE Course (
                        course_id INT AUTO_INCREMENT PRIMARY KEY,
                        course_name VARCHAR(255) NOT NULL,
                        description TEXT
);

-- Bảng lưu các module/phần học trong một khóa
CREATE TABLE Module (
                        module_id INT AUTO_INCREMENT PRIMARY KEY,
                        course_id INT NOT NULL,
                        module_name VARCHAR(255) NOT NULL,
                        sort_order INT DEFAULT 0,
                        FOREIGN KEY (course_id) REFERENCES Course(course_id) ON DELETE CASCADE
);

-- Bảng lưu các bài học trong một module
CREATE TABLE Lesson (
                        lesson_id INT AUTO_INCREMENT PRIMARY KEY,
                        module_id INT NOT NULL,
                        lesson_name VARCHAR(255) NOT NULL,
                        sort_order INT DEFAULT 0,
                        FOREIGN KEY (module_id) REFERENCES Module(module_id) ON DELETE CASCADE
);

-- Bảng lưu nội dung chi tiết của bài học (text, video link...)
CREATE TABLE LessonContent (
                               content_id INT AUTO_INCREMENT PRIMARY KEY,
                               lesson_id INT NOT NULL,
                               content_type ENUM('text', 'video', 'quiz', 'markdown') NOT NULL,
                               content_data TEXT,
                               FOREIGN KEY (lesson_id) REFERENCES Lesson(lesson_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- 3. NHÓM QUẢN LÝ LỚP HỌC & TÁC NGHIỆP
-- -----------------------------------------------------

-- Bảng lưu các lớp học cụ thể (ví dụ: C072025)
CREATE TABLE Class (
                       class_id INT AUTO_INCREMENT PRIMARY KEY,
                       class_name VARCHAR(100) NOT NULL UNIQUE,
                       course_id INT NOT NULL,
                       teacher_id INT COMMENT 'Giáo viên phụ trách',
                       start_date DATE,
                       end_date DATE,
                       FOREIGN KEY (course_id) REFERENCES Course(course_id),
                       FOREIGN KEY (teacher_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- Bảng ghi danh (N-N): Học viên nào thuộc lớp nào
CREATE TABLE Enrolment (
                           student_id INT NOT NULL,
                           class_id INT NOT NULL,
                           enrol_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           status ENUM('studying', 'completed', 'dropped') DEFAULT 'studying',
                           PRIMARY KEY (student_id, class_id),
                           FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
                           FOREIGN KEY (class_id) REFERENCES Class(class_id) ON DELETE CASCADE
);

-- Bảng thời khóa biểu
CREATE TABLE Schedule (
                          schedule_id INT AUTO_INCREMENT PRIMARY KEY,
                          class_id INT NOT NULL,
                          lesson_id INT COMMENT 'Bài học dự kiến',
                          time_start DATETIME NOT NULL,
                          time_end DATETIME NOT NULL,
                          room VARCHAR(50),
                          FOREIGN KEY (class_id) REFERENCES Class(class_id) ON DELETE CASCADE,
                          FOREIGN KEY (lesson_id) REFERENCES Lesson(lesson_id) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- 4. NHÓM BẢNG THEO DÕI & GHI LOG
-- -----------------------------------------------------

-- Bảng điểm danh chi tiết
CREATE TABLE Attendance (
                            attendance_id INT AUTO_INCREMENT PRIMARY KEY,
                            schedule_id INT NOT NULL,
                            student_id INT NOT NULL,
                            status ENUM('present', 'absent', 'late', 'excused') NOT NULL,
                            note TEXT,
                            FOREIGN KEY (schedule_id) REFERENCES Schedule(schedule_id) ON DELETE CASCADE,
                            FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
                            UNIQUE(schedule_id, student_id) -- Một học viên chỉ có 1 trạng thái điểm danh / 1 buổi
);

-- Bảng điểm số (N-N): Điểm của học viên cho từng module
CREATE TABLE Grade (
                       student_id INT NOT NULL,
                       module_id INT NOT NULL,
                       score DECIMAL(5, 2) NOT NULL,
                       note TEXT,
                       last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       PRIMARY KEY (student_id, module_id),
                       FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
                       FOREIGN KEY (module_id) REFERENCES Module(module_id) ON DELETE CASCADE
);

-- Bảng theo dõi tiến độ học (N-N): Học viên đã hoàn thành bài nào
CREATE TABLE LessonProgress (
                                student_id INT NOT NULL,
                                lesson_id INT NOT NULL,
                                is_completed BOOLEAN DEFAULT false,
                                completed_at TIMESTAMP,
                                PRIMARY KEY (student_id, lesson_id),
                                FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
                                FOREIGN KEY (lesson_id) REFERENCES Lesson(lesson_id) ON DELETE CASCADE
);

-- Bảng nhật ký cho từng học viên
CREATE TABLE StudentLog (
                            log_id INT AUTO_INCREMENT PRIMARY KEY,
                            student_id INT NOT NULL,
                            author_staff_id INT NOT NULL COMMENT 'Người viết log (GV, Giáo vụ)',
                            content TEXT NOT NULL,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (student_id) REFERENCES Student(student_id) ON DELETE CASCADE,
                            FOREIGN KEY (author_staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

-- Bảng nhật ký chung của lớp học
CREATE TABLE ClassLog (
                          log_id INT AUTO_INCREMENT PRIMARY KEY,
                          class_id INT NOT NULL,
                          author_staff_id INT NOT NULL COMMENT 'Người viết log (GV)',
                          content TEXT NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (class_id) REFERENCES Class(class_id) ON DELETE CASCADE,
                          FOREIGN KEY (author_staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- 1. BẢNG KHÔNG PHỤ THUỘC (Độc lập)
-- -----------------------------------------------------

-- Thêm các vai trò
INSERT INTO Role (role_name) VALUES
                                 ('ADMIN'),
                                 ('TEACHER'),
                                 ('STUDENT'),
                                 ('GIAO_VU');
-- (ID 1: ADMIN, 2: TEACHER, 3: STUDENT, 4: GIAO_VU)

-- Thêm một khóa học
INSERT INTO Course (course_name, description) VALUES
    ('Fullstack Java Web', 'Khóa học lập trình Java web từ cơ bản đến nâng cao.');
-- (ID 1: Fullstack Java Web)

-- -----------------------------------------------------
-- 2. TÀI KHOẢN & NỘI DUNG (Phụ thuộc Role, Course)
-- -----------------------------------------------------

-- Thêm tài khoản người dùng (Giả sử mật khẩu đã được hash)
INSERT INTO User (email, password_hash, role_id) VALUES
                                                     ('hoang.lv@example.com', 'hashed_password_123', 1),   -- (User ID 1: Lê Văn Hoàng - ADMIN)
                                                     ('nguyen.tlg@example.com', 'hashed_password_123', 2), -- (User ID 2: Gia Nguyên - TEACHER)
                                                     ('tung.hv@example.com', 'hashed_password_123', 3),    -- (User ID 3: Viết Tùng - STUDENT)
                                                     ('khanh.nkq@example.com', 'hashed_password_123', 3),   -- (User ID 4: Quốc Khánh - STUDENT)
                                                     ('giaovu.nt@example.com', 'hashed_password_123', 4);  -- (User ID 5: Giáo Vụ - GIAO_VU)

-- Thêm module cho khóa học (Course ID 1)
INSERT INTO Module (course_id, module_name, sort_order) VALUES
                                                            (1, 'Module 1: Java Core', 1),    -- (Module ID 1)
                                                            (1, 'Module 2: HTML/CSS/JS', 2); -- (Module ID 2)

-- Thêm bài học cho Module 1 (Module ID 1)
INSERT INTO Lesson (module_id, lesson_name, sort_order) VALUES
                                                            (1, 'Bài 1: Giới thiệu Java', 1),            -- (Lesson ID 1)
                                                            (1, 'Bài 2: Biến và Kiểu dữ liệu', 2); -- (Lesson ID 2)

-- Thêm nội dung cho Bài 1 (Lesson ID 1)
INSERT INTO LessonContent (lesson_id, content_type, content_data) VALUES
                                                                      (1, 'text', 'Java là một ngôn ngữ lập trình đa nền tảng...'),
                                                                      (1, 'video', 'https://www.youtube.com/watch?v=some_video_id');

-- -----------------------------------------------------
-- 3. THÔNG TIN CHI TIẾT (Phụ thuộc User)
-- -----------------------------------------------------

-- Thêm thông tin cho nhân viên (Staff)
INSERT INTO Staff (user_id, full_name, position) VALUES
                                                     (1, 'Lê Văn Hoàng', 'System Admin'),          -- (Staff ID 1)
                                                     (2, 'Trần Lê Gia Nguyên', 'Lead Teacher'),    -- (Staff ID 2)
                                                     (5, 'Nguyễn Thị Giáo Vụ', 'Giáo vụ');        -- (Staff ID 3)

-- Thêm thông tin cho học viên (Student)
INSERT INTO Student (user_id, full_name, phone) VALUES
                                                    (3, 'Hồ Viết Tùng', '0905111222'),          -- (Student ID 1)
                                                    (4, 'Nguyễn Kim Quốc Khánh', '0905333444'); -- (Student ID 2)

-- -----------------------------------------------------
-- 4. QUẢN LÝ LỚP HỌC (Phụ thuộc Course, Staff)
-- -----------------------------------------------------

-- Thêm lớp học (Lớp 'C07', học Course 1, do Staff 2 dạy)
INSERT INTO Class (class_name, course_id, teacher_id, start_date) VALUES
    ('C07', 1, 2, '2025-11-15'); -- (Class ID 1)

-- Thêm học viên vào lớp (Ghi danh Student 1 và 2 vào Class 1)
INSERT INTO Enrolment (student_id, class_id, status) VALUES
                                                         (1, 1, 'studying'), -- (Tùng vào lớp C07)
                                                         (2, 1, 'studying'); -- (Khánh vào lớp C07)

-- Thêm thời khóa biểu (Buổi học đầu tiên của Lớp 1, học Bài 1)
INSERT INTO Schedule (class_id, lesson_id, time_start, time_end, room) VALUES
    (1, 1, '2025-11-15 08:00:00', '2025-11-15 11:30:00', 'Phòng A101'); -- (Schedule ID 1)

-- -----------------------------------------------------
-- 5. TÁC NGHIỆP & LOG (Phụ thuộc các bảng trên)
-- -----------------------------------------------------

-- (CN 18) Điểm danh cho buổi học (Schedule ID 1)
INSERT INTO Attendance (schedule_id, student_id, status, note) VALUES
                                                                   (1, 1, 'present', 'Đi học đúng giờ'),   -- (Tùng có mặt)
                                                                   (1, 2, 'absent', 'Xin nghỉ phép');      -- (Khánh vắng)

-- (CN 28) Nhập điểm cho học viên (Student 1, Module 1)
INSERT INTO Grade (student_id, module_id, score) VALUES
    (1, 1, 8.5); -- (Tùng 8.5 điểm Module 1)

-- (CN 30) Tick tiến độ học (Student 1 hoàn thành Lesson 1)
INSERT INTO LessonProgress (student_id, lesson_id, is_completed, completed_at) VALUES
    (1, 1, true, NOW());

-- (CN 19) Viết nhật ký lớp (Staff 2 viết cho Class 1)
INSERT INTO ClassLog (class_id, author_staff_id, content) VALUES
    (1, 2, 'Lớp C07 buổi đầu sĩ số 1/2. Học viên Khánh xin vắng.');

-- (CN 21) Viết nhật ký học viên (Staff 3 viết cho Student 2)
INSERT INTO StudentLog (student_id, author_staff_id, content) VALUES
    (2, 3, 'Giáo vụ đã liên hệ HV Khánh xác nhận lý do vắng. OK');