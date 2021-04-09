-- -- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- -- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


-- CREATE TABLE "Departments" (
--     "dept_no" varchar   NOT NULL,
--     "dept_name" varchar   NOT NULL,
--     CONSTRAINT "pk_Departments" PRIMARY KEY (
--         "dept_no"
--      )
-- );

-- CREATE TABLE "Employees" (
--     "emp_no" varchar   NOT NULL,
--     "birth_date" date   NOT NULL,
--     "first_name" varchar   NOT NULL,
--     "last_name" varchar   NOT NULL,
--     "gender" varchar   NOT NULL,
--     "hire_date" date   NOT NULL,
--     CONSTRAINT "pk_Employees" PRIMARY KEY (
--         "emp_no"
--      )
-- );

-- CREATE TABLE "Managers" (
--     "dept_no" varchar   NOT NULL,
--     "emp_no" varchar   NOT NULL,
--     "from_date" date   NOT NULL,
--     "to_date" date   NOT NULL,
--     CONSTRAINT "pk_Managers" PRIMARY KEY (
--         "dept_no","emp_no"
--      )
-- );

-- CREATE TABLE "dept_emp" (
--     "emp_no" varchar   NOT NULL,
--     "dept_no" varchar   NOT NULL,
--     "from_date" date   NOT NULL,
--     "to_date" date   NOT NULL,
--     CONSTRAINT "pk_dept_emp" PRIMARY KEY (
--         "emp_no","dept_no"
--      )
-- );

-- CREATE TABLE "Salaries" (
--     "emp_no" varchar   NOT NULL,
--     "salary" int   NOT NULL,
--     "from_date" date   NOT NULL,
--     "to_date" date   NOT NULL,
--     CONSTRAINT "pk_Salaries" PRIMARY KEY (
--         "emp_no"
--      )
-- );

-- CREATE TABLE "Titles" (
--     "emp_no" varchar   NOT NULL,
--     "titles" varchar   NOT NULL,
--     "from_date" date   NOT NULL,
--     "to_date" date   NOT NULL,
--     CONSTRAINT "pk_Titles" PRIMARY KEY (
--         "emp_no","titles","from_date"
--      )
-- );

-- ALTER TABLE "Managers" ADD CONSTRAINT "fk_Managers_dept_no" FOREIGN KEY("dept_no")
-- REFERENCES "Departments" ("dept_no");

-- ALTER TABLE "Managers" ADD CONSTRAINT "fk_Managers_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "Employees" ("emp_no");

-- ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "Employees" ("emp_no");

-- ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
-- REFERENCES "Departments" ("dept_no");

-- ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "Employees" ("emp_no");

-- ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "Employees" ("emp_no");


SELECT * FROM public."Departments"
SELECT * FROM public."Employees"


SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- employees born in 1953
SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- employees born in 1954
SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- employees born in 1955
SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO public."retirement_info"
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM public."retirement_info";

DROP TABLE public."retirement_info";

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO public."retirement_info"
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM public."retirement_info";

-- Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM public."Departments" as d
INNER JOIN public."Managers" as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT public."retirement_info".emp_no,
    public."retirement_info".first_name,
public."retirement_info".last_name,
    public."dept_emp".to_date
FROM public."retirement_info"
LEFT JOIN public."dept_emp"
ON public."retirement_info".emp_no = public."dept_emp".emp_no;


-- using aliases to shorten the retirement_info join we just ran 
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM public."retirement_info" as ri 
LEFT JOIN public."dept_emp" as de
ON ri.emp_no = de.emp_no;


SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO public."current_emp"
FROM public."retirement_info" as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO public."employee_department"
FROM public."current_emp" as ce
LEFT JOIN public."dept_emp" as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM public.employee_department;

SELECT * FROM public."Salaries"
ORDER BY to_date DESC;


SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO public."emp_info"
FROM public."Employees" as e
INNER JOIN public."Salaries" as s
ON (e.emp_no = s.emp_no)
INNER JOIN public."dept_emp" as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');

SELECT * FROM public."emp_info";

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO public."manager_info"
FROM public."Managers" AS dm
    INNER JOIN public."Departments" AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN public."current_emp" AS ce
        ON (dm.emp_no = ce.emp_no);

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO public."dept_info"
FROM public."current_emp" as ce
INNER JOIN public."dept_emp" AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN public."Departments" AS d
ON (de.dept_no = d.dept_no);