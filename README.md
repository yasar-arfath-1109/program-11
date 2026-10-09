# RDBMS Program 11 - Creating a View

## Objective

Create Student, Department, Course and Enrollment tables, insert suitable sample records, and create a view named `StudentDetails`.

The view must display:

* Student Name
* Course Name
* Department Name

## Tables

### Student

| StudentID | StudentName | DepartmentID |
| --------- | ----------- | ------------ |
| 1001      | Arun        | 10           |
| 1002      | Priya       | 20           |
| 1003      | Kumar       | 10           |

### Department

| DepartmentID | DepartmentName   |
| ------------ | ---------------- |
| 10           | Computer Science |
| 20           | Mathematics      |

### Course

| CourseID | CourseName       |
| -------- | ---------------- |
| 201      | Database Systems |
| 202      | Data Structures  |
| 203      | Mathematics      |

### Enrollment

| EnrollmentID | StudentID | CourseID |
| ------------ | --------- | -------- |
| 1            | 1001      | 201      |
| 2            | 1001      | 202      |
| 3            | 1002      | 203      |
| 4            | 1003      | 201      |

## Student Task

Students must:

1. Create the `CollegeDB` database.
2. Create the `Student` table.
3. Insert the Student records.
4. Create the `Department` table.
5. Insert the Department records.
6. Create the `Course` table.
7. Insert the Course records.
8. Create the `Enrollment` table.
9. Insert the Enrollment records.
10. Create a view named `StudentDetails`.
11. Use the required joins to connect the four tables.
12. Display Student Name, Course Name and Department Name.

## View Requirement

The view must be named:

`StudentDetails`

The view should be created using:

```sql
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
```

Then display the view using:

```sql
SELECT * FROM StudentDetails;
```

## Expected Output

| StudentName | CourseName       | DepartmentName   |
| ----------- | ---------------- | ---------------- |
| Arun        | Database Systems | Computer Science |
| Arun        | Data Structures  | Computer Science |
| Priya       | Mathematics      | Mathematics      |
| Kumar       | Database Systems | Computer Science |

## Submission Instructions

1. Complete `student_solution.sql`.
2. Save the file.
3. Commit the changes.
4. Push the changes to GitHub.
5. Open the **Actions** tab.
6. Check the autograding result.
7. The expected score is **10/10** when all requirements are satisfied.

## Important

* Do not modify `test.sh`.
* Do not modify `.github/workflows/autograding.yml`.
* Only modify `student_solution.sql`.
* The view name must be exactly `StudentDetails`.
* Table and column names must be written correctly.

## Total Marks

**10 Marks**
