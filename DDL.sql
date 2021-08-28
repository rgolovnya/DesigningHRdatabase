create schema HR;
set schema 'HR';

/* Following DDL SQL commands will help you to create a physical database for managing the employee's data on a DBMS supporting posgres. */

   -- Drop Tables if Exists
 DROP TABLE IF EXISTS Education;
 DROP TABLE IF EXISTS Salary;
 DROP TABLE IF EXISTS Department;
 DROP TABLE IF EXISTS Employee;
 DROP TABLE IF EXISTS EployeeJob;
 DROP TABLE IF EXISTS Job;
 DROP TABLE IF EXISTS Address;
 DROP TABLE IF EXISTS City;
 DROP TABLE IF EXISTS State;

-- Create Tables

/* Creating Education table (primary key - education id) */

CREATE table Education(
    education_id serial primary key,
    education_level varchar(50)
);

/* Creating Department table (primary key - department id) */

CREATE table Department(
    department_id serial primary key,
    department_name varchar(50)
);

/* Creating Salary table so as to provide  flexibility in provisioning security (primary key - salary id) */

CREATE table Salary(
    salary_id serial primary key,
    salary_amount int
);

/* Creating Job table (primary key - job id) */

CREATE table Job(
    job_id serial primary key,
    job_title varchar(100)
);

/* Creating Location table (primary key - location id id) */

CREATE table Location(
    location_id serial primary key,
    Location_name varchar(50)
);

/* Creating State table (primary key - state id) */

CREATE table State(
    state_id serial primary key,
    state_name varchar(25),
    location_id int references Location(location_id)
);

/* Creating City table (primary key - city id) */

CREATE table City(
    city_id serial primary key,
    city_name varchar(50),
    state_id int references State(state_id)
);

/* Creating Address table (primary key - address id) */

CREATE table Address(
    address_id serial primary key,
    address varchar(100),
    city_id int references City(city_id)
);

/* Creating Employee table (primary key - employee id) */

CREATE table Employee(
    employee_id varchar(10) primary key,
    employee_name varchar(50),
    email varchar(100),
    hire_date date,
    education_id int references Education(education_id)
);

/* Creating EmployeeStatus table as there is    many to many relationship across emp_id and
   job_id. So this table acts as pivot point */

CREATE table Employeejob(
    employee_id varchar(10) references Employee(employee_id),
    job_id int references Job(job_id),
    department_id int references Department(department_id),
    manager_id varchar(50) references Employee(employee_id),
    start_date date,
    end_date date,
    address_id int references Address(address_id),
    salary_id int references Salary(salary_id)
);


/* Creating primary key in Employeejob table (primary key - [employee id, job id]) */

ALTER table Employeejob
    ADD CONSTRAINT employeejob_pk
        primary key (employee_id, job_id);
