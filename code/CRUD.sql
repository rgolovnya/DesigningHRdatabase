/* Question 1: Return a list of employees with Job Titles and Department Names */

SELECT emp.employee_name, job.job_title, dep.department_name
    FROM Employeejob as ej
    JOIN Employee as emp
    ON ej.employee_id = emp.employee_id
    JOIN Job as job
    ON ej.job_id = job.job_id
    JOIN Department as dep
    ON ej.department_id = dep.department_id;

/* Question 2: Insert Web Programmer as a new job title */

INSERT into Job (job_title)
    VALUES ('Web Programmer');

/* Question 3: Correct the job title from web programmer to web developer */

UPDATE Job
    SET job_title = 'Web Developer'
    WHERE job_title = 'Web Programmer';

/* Question 4: Delete the job title Web Developer from the database */

DELETE from Job
    WHERE job_title = 'Web Developer';

/* Question 5: How many employees are in each department? */

SELECT dep.department_name, count(emp.employee_name)
    FROM Employeejob as ej
    JOIN Employee as emp
    ON ej.employee_id = emp.employee_id
    JOIN Department as dep
    ON ej.department_id = dep.department_id
    GROUP BY dep.department_name;

/* Question 6: Write a query that returns current and past jobs (include
   employee name, job title, department, manager name, start and end date
   for position) for employee Toni Lembeck. */

SELECT emp.employee_name, job.job_title, dep.department_name,
       (SELECT employee_name from Employee WHERE employee_id = ej.manager_id),
       ej.start_date, ej.end_date
    FROM Employeejob as ej
    JOIN Employee as emp
    ON ej.employee_id = emp.employee_id
    JOIN Job as job
    ON ej.job_id = job.job_id
    JOIN Department as dep
    ON ej.department_id = dep.department_id
    WHERE emp.employee_name = 'Toni Lembeck';
