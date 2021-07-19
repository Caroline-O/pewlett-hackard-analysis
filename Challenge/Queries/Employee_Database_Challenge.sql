--Retirement Titles Table
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    tt.title,
	tt.from_date,
    tt.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)	
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Unique Titles Table
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Count of retiring employees by their most recent job title
SELECT count(ut.title) as "count",
ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

--Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
	de.to_date,
	tt.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;
	
	
	