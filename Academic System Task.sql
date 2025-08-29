-- Create schemas
CREATE SCHEMA school;
CREATE SCHEMA academic;

-- Create table: Groups
CREATE TABLE school.groups (
    group_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create table: Students
CREATE TABLE school.students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES school.groups (group_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create table: Teachers
CREATE TABLE academic.teachers (
    teacher_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Create table: Subjects
CREATE TABLE academic.subjects (
    subject_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Create table: Subject_Teacher
CREATE TABLE academic.subject_teacher (
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    group_id INT NOT NULL,
    PRIMARY KEY (subject_id, teacher_id, group_id),
    FOREIGN KEY (subject_id) REFERENCES academic.subjects (subject_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES academic.teachers (teacher_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (group_id) REFERENCES school.groups (group_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create table: Marks
CREATE TABLE academic.marks (
    mark_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mark INT CHECK (mark >= 0 AND mark <= 100),
    FOREIGN KEY (student_id) REFERENCES school.students (student_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES academic.subjects (subject_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);