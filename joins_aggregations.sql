-- ============================================================
-- Exercise 2: SQL Joins & Aggregations
-- Database: SQLite
-- Tables: employees, departments
-- ============================================================


-- Exercise 1: Employees and Department Budgets
-- Display employee name, department, salary, and department budget.

SELECT
    e.name AS employee_name,
    e.department AS department_name,
    e.salary,
    d.budget AS department_budget
FROM employees AS e
JOIN departments AS d
    ON e.department = d.name;


-- Exercise 2: Employees and Their Managers
-- Display each employee and their manager.
-- LEFT JOIN includes employees without a listed manager.

SELECT
    e.name AS employee_name,
    m.name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.id;


-- Exercise 3: Employee Count by Department
-- Count employees in each department.
-- Sort from highest employee count to lowest.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;


-- Exercise 4: Average Salary by Department
-- Calculate average salary and round to two decimal places.
-- Sort from highest average salary to lowest.

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;


-- Exercise 5: Salary Summary by Department
-- Calculate minimum, maximum, total salary, and employee count.

SELECT
    department,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    SUM(salary) AS total_salary,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- Exercise 6: Departments with More Than Two Employees
-- Use HAVING to filter departments with more than two employees.
-- Sort by employee count in descending order.

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2
ORDER BY employee_count DESC;


-- Exercise 7: Department Budget and Salary Comparison
-- Compare each department's budget with its total employee salary.
-- Budget difference = department budget - total employee salary.

SELECT
    d.name AS department_name,
    d.budget AS department_budget,
    COALESCE(SUM(e.salary), 0) AS total_salary,
    d.budget - COALESCE(SUM(e.salary), 0) AS budget_difference
FROM departments AS d
LEFT JOIN employees AS e
    ON e.department = d.name
GROUP BY
    d.id,
    d.name,
    d.budget
ORDER BY department_name;
