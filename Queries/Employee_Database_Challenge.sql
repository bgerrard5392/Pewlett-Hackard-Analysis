-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;


-- Module 7 Challenge
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	tl.titles,
	tl.from_date,
	tl.to_date
INTO public."retirement_titles"
FROM public."Employees" as e
INNER JOIN public."Titles" as tl
ON e.emp_no = tl.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC;


-- Module 7 Challenge step 1, part 2
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
	rt.last_name,
	rt.titles,
	rt.to_date
INTO "unique_titles"
FROM public."retirement_titles" as rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Module 7, step 9
SELECT COUNT (emp_no) emp_no,
titles
INTO public."retiring_titles"
FROM public."unique_titles"
GROUP BY titles
ORDER BY emp_no DESC;

-- Module 7, Deliverable 2
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tl.titles
INTO public."mentorship_eligibilty"
FROM public."Employees" as e
INNER JOIN public."dept_emp" as de
ON (e.emp_no = de.emp_no)
INNER JOIN public."Titles" as tl
ON (e.emp_no = tl.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC; 







