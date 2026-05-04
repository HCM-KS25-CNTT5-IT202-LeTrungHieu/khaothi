CREATE DATABASE IF NOT EXISTS CenterManagament;

CREATE TABLE IF NOT EXISTS courses (
    id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    lecturer varchar(255) NOT NULL,
    tuition_fee decimal(10, 2) NOT NULL,
    duration int NOT NULL
);

CREATE TABLE IF NOT EXISTS students (
    id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    email varchar(255) UNIQUE,
    phone varchar(20) NOT NULL,
    birthday date NOT NULL
);

CREATE TABLE IF NOT EXISTS enrollments (
    id varchar(255) NOT NULL,
    student_id int NOT NULL,
    course_id int NOT NULL,
    enrollment_date date NOT NULL,
    payment_method varchar(50) CHECK (payment_method IN ('cash', 'bank_transfer')) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students (id),
    FOREIGN KEY (course_id) REFERENCES courses (id)
);

CREATE TABLE IF NOT EXISTS enrollment_details (
    course_id int NOT NULL,
    status varchar(20) CHECK (status IN ('reserve', 'studying')) NOT NULL,
    final_grade decimal(5, 2) NULL
);

ALTER TABLE enrollments
    ADD COLUMN note varchar(255) NULL;

ALTER TABLE courses RENAME COLUMN lecturer TO teacher;

DROP TABLE IF EXISTS enrollment_details;

DROP TABLE IF EXISTS enrollments;

INSERT INTO courses (name, teacher, tuition_fee, duration)
VALUES
    ('Mathematics', 'Dr. Smith', 500.00, 12),
    ('Physics', 'Dr. Johnson', 600.00, 10),
    ('Chemistry', 'Tran Anh', 550.00, 8),
    ('English', 'Tran Anh', 450.00, 6),
    ('Promgramming', 'Dr. Davis', 700.00, 14);

INSERT INTO students (name, email, phone, birthday)
VALUES
    ('Alice', 'alice@mail.com', '0123456789', '2000-01-15'),
    ('Bob', 'bob@mail.com', '0987654321', '1999-05-20'),
    ('Charlie', 'charlie@mail.com', '0112233445', '2001-03-10'),
    ('David', 'david@mail.com', '0223344556', '1998-07-25'),
    ('Eve', 'eve@mail.com', '0334455667', '2002-11-30');

INSERT INTO enrollments (student_id, course_id, enrollment_date, payment_method, note)
VALUES
    ('PDK001', 1, '2024-01-10', 'cash', 'First enrollment'),
    ('PDK002', 2, '2024-02-15', 'bank_transfer', 'Second enrollment'),
    ('PDK003', 3, '2024-03-20', 'cash', 'Third enrollment'),
    ('PDK004', 4, '2024-04-25', 'bank_transfer', 'Fourth enrollment'),
    ('PDK001', 5, '2024-05-30', 'cash', 'Fifth enrollment'));

INSERT INTO enrollment_details (course_id, status, final_grade)
VALUES
    (1, 'studying', 10),
    (2, 'reserve', 10),
    (3, 'studying', 10),
    (4, 'reserve', 10),
    (5, 'studying', 10);

UPDATE
    courses
SET
    tuition_fee = tuition_fee * 0.9
WHERE
    teacher = 'Tran Anh';

DELETE FROM students
WHERE email IS NULL;

SELECT
    *
FROM
    courses
WHERE
    tuition_fee BETWEEN 1000000 AND 3000000;

SELECT
    s.name,
    e.id
FROM
    students s
WHERE
    s.id IN (
        SELECT
            student_id
        FROM
            enrollments e
        WHERE
            e.enrollment_date LIKE '2026-07%');

SELECT
    name
FROM
    courses
WHERE
    id = 'PDK001';

SELECT
    name,
    phone,
    email
FROM
    students
WHERE
    id IN (
        SELECT
            student_id
        FROM
            enrollments
        WHERE
            name = 'IELTS 6.5');

SELECT
    id,
    name,
    teacher,
    final_grade
FROM
    courses
WHERE
    status = 'studying';

