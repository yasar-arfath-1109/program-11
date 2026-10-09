#!/bin/bash

DB="CollegeDB"
TOTAL=0
FAILED=0

MYSQL="mysql -h 127.0.0.1 -P 3306 -uroot -p${MYSQL_ROOT_PASSWORD}"

echo "=========================================="
echo "RDBMS PROGRAM 11 - AUTOGRADING"
echo "CREATE VIEW - StudentDetails"
echo "=========================================="

echo "Checking MySQL connection..."

if $MYSQL -e "SELECT 1;" >/dev/null 2>&1; then
    echo "MySQL connection successful."
else
    echo "ERROR: Cannot connect to MySQL."
    exit 1
fi

echo
echo "Creating fresh CollegeDB database..."

$MYSQL -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB;"

echo "Executing student_solution.sql..."

if $MYSQL < student_solution.sql >/dev/null 2>&1; then
    echo "SQL execution completed."
else
    echo "ERROR: SQL execution failed."
    exit 1
fi

run_test() {
    local num="$1"
    local description="$2"
    local query="$3"
    local expected="$4"

    result=$($MYSQL -N -B "$DB" -e "$query" 2>/dev/null | tr -d '\r')

    if [ "$result" = "$expected" ]; then
        echo "Test Case $num PASS: $description"
        TOTAL=$((TOTAL + 1))
    else
        echo "Test Case $num FAIL: $description"
        echo "Expected: $expected"
        echo "Got: $result"
        FAILED=$((FAILED + 1))
    fi
}

# Test Case 1
run_test 1 "Student table exists" \
"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB' AND table_name='Student';" \
"1"

# Test Case 2
run_test 2 "Department table exists" \
"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB' AND table_name='Department';" \
"1"

# Test Case 3
run_test 3 "Course table exists" \
"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB' AND table_name='Course';" \
"1"

# Test Case 4
run_test 4 "Enrollment table exists" \
"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB' AND table_name='Enrollment';" \
"1"

# Test Case 5
run_test 5 "Student table has 3 records" \
"SELECT COUNT(*) FROM Student;" \
"3"

# Test Case 6
run_test 6 "Course table has 3 records" \
"SELECT COUNT(*) FROM Course;" \
"3"

# Test Case 7
run_test 7 "Enrollment table has 4 records" \
"SELECT COUNT(*) FROM Enrollment;" \
"4"

# Test Case 8
run_test 8 "Department table has 2 records" \
"SELECT COUNT(*) FROM Department;" \
"2"

# Test Case 9
run_test 9 "StudentDetails view exists" \
"SELECT COUNT(*) FROM information_schema.views WHERE table_schema='$DB' AND table_name='StudentDetails';" \
"1"

# Test Case 10
run_test 10 "StudentDetails view returns 4 records" \
"SELECT COUNT(*) FROM StudentDetails;" \
"4"

echo
echo "=========================================="
echo "Total Marks: $TOTAL / 10"
echo "=========================================="

if [ "$FAILED" -eq 0 ]; then
    echo "All test cases passed."
    exit 0
else
    echo "$FAILED test case(s) failed."
    exit 1
fi
