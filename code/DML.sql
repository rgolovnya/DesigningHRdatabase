--Import Data From Staging Table

/* Following DML SQL commands will help you to populate the physical database
 which is being created for managing the employee's data on a DBMS supporting
 posgres. */

/* Populating Education table */

INSERT INTO Education(education_level)
    SELECT DISTINCT education_lvl
    FROM proj_stg;

/* Populating Job table */

INSERT INTO Job(job_title)
    SELECT DISTINCT job_title
    FROM proj_stg;

/* Populating Department table */

INSERT INTO Department(department_name)
    SELECT DISTINCT department_nm
    FROM proj_stg;

/* Populating Salary table */

INSERT INTO Salary(salary_amount)
    SELECT DISTINCT salary
    FROM proj_stg;

/* Populating Location table */

INSERT into Location(Location_name)
  SELECT DISTINCT location
  FROM proj_stg;


/* Populating State table */

  INSERT into State(state_name, location_id)
    SELECT DISTINCT s.state, loc.location_id
    FROM proj_stg as s
    JOIN Location as loc
    ON s.location = loc.Location_name;

/* Populating City table */

INSERT into City(city_name, state_id)
  SELECT DISTINCT s.city, st.state_id
  FROM proj_stg as s
  JOIN State as st
  ON s.state = st.state_name;

/* Populating Address table */

INSERT into Address(address, city_id)
  SELECT DISTINCT s.address, ct.city_id
  FROM proj_stg as s
  JOIN City as ct
  ON s.city = ct.city_name;

/* Populating Employee table */

INSERT into Employee(employee_id, employee_name, email, hire_date, education_id)
  SELECT DISTINCT s.Emp_ID, s.Emp_NM, s.Email, s.hire_dt, ed.education_id
  FROM proj_stg as s
  JOIN Education as ed
  ON s.education_lvl = ed.education_level;

/* Populating EmployeeStatus table */

INSERT into Employeejob(employee_id, job_id, department_id, manager_id, start_date, end_date, address_id, salary_id)
  SELECT emp.employee_id, job.job_id, dep.department_id,
         (SELECT employee_id from Employee WHERE employee_name = s.manager),
         s.start_dt, s.end_dt, addr.address_id, sal.salary_id
  FROM proj_stg as s
  JOIN Employee as emp
  ON s.Emp_ID = emp.employee_id
  JOIN Job as job
  ON s.job_title = job.job_title
  JOIN Department as dep
  ON s.department_nm = dep.department_name
  JOIN Address as addr
  ON s.address = addr.address
  JOIN Salary as sal
  ON s.salary = sal.salary_amount;
