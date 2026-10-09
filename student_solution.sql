CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

CREATE TABLE Student (
    StudentID INT,
    StudentName VARCHAR(100),
    DepartmentID INT
);

INSERT INTO Student VALUES
(1001, 'Arun', 10),
(1002, 'Priya', 20),
(1003, 'Kumar', 10);

CREATE TABLE Department (
    DepartmentID INT,
    DepartmentName VARCHAR(100)
);

INSERT INTO Department VALUES
(10, 'Computer Science'),
(20, 'Mathematics');

CREATE TABLE Course (
    CourseID INT,
    CourseName VARCHAR(100)
);

INSERT INTO Course VALUES
(201, 'Database Systems'),
(202, 'Data Structures'),
(203, 'Mathematics');

CREATE TABLE Enrollment (
    EnrollmentID INT,
    StudentID INT,
    CourseID INT
);

INSERT INTO Enrollment VALUES
(1, 1001, 201),
(2, 1001, 202),
(3, 1002, 203),
(4, 1003, 201);

CREATE VIEW StudentDetails AS
SELECT
    Student.StudentName,
    Course.CourseName,
    Department.DepartmentName
FROM Student
INNER JOIN Enrollment
    ON Student.StudentID = Enrollment.StudentID
INNER JOIN Course
    ON Enrollment.CourseID = Course.CourseID
INNER JOIN Department
    ON Student.DepartmentID = Department.DepartmentID;

SELECT * FROM StudentDetails;
