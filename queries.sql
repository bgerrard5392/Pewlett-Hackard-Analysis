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
