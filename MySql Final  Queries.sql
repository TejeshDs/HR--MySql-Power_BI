-- To create Database

create database projects;

-- To Use Database

use projects;


select * from hr;


-- To do modifications in tha Dataset

alter table hr change column ï»¿id emp_id varchar(30);

set autocommit =0;

savepoint a;

set sql_safe_updates =0;

update hr set birthdate = case
   when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
   when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
   else null 
end;


update hr set hire_date = case
   when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
   when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
   else null 
end;


set sql_mode='allow_invalid_dates';

update hr set termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != ' ';


select * from hr;

-- To check all the data types

describe hr;

-- To Modify all the Datatypes

alter table hr modify column birthdate date;

alter table hr modify column hire_date date;

alter table hr modify column termdate date;

describe hr;

select * from hr;

-- To Add age column

alter table hr add column age int;


-- To update age column

update hr set age = timestampdiff(year,birthdate,curdate());

-- To check the employees under age 18 

select count(*) from hr where age<=18;

select * from hr;

select count(*) from hr;

savepoint b;

-- To delete  Employees whose having age less than 18

delete from hr where age <=18;




select * from hr;

describe hr;



-- QUESTIONS--

-- 1. What is the gender breakdown of employees in the company?

select gender,count(*) as count from hr group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
 
 select race,count(*) as count from hr group by race;
 
-- 3. What is the age distribution of employees in the company?

select case
    when age>=21 and age<=30 then '21-30' 
    when age>=31 and age<=40 then '31-40'
    when age>=41 and age<=50 then '41-50'
    when age>=51 and age<=60 then '51-60'
    else '60+'
end as age_group, count(*) from hr group by age_group order by age_group;

-- 4. what is the age group and gender distribution in  the company?

select case
    when age>=21 and age<=30 then '21-30' 
    when age>=31 and age<=40 then '31-40'
    when age>=41 and age<=50 then '41-50'
    when age>=51 and age<=60 then '51-60'
    else '60+'
end as age_group ,gender,count(*) from hr group by age_group,gender order by age_group;

-- 5. How many employees work at headquarters versus remote locations?

select location,count(*) from hr group by location;

-- 6. What is the average length of employment for employees who have been terminated?

select avg(datediff(termdate,hire_date)/365) from hr where termdate<=curdate();

-- 7. How does the gender distribution vary across departments?

select department,gender,count(*) from hr group by department ,gender order by department,gender;

-- 8. How does the gender distribution vary across job titles?

select jobtitle ,gender,count(*) from hr group by jobtitle ,gender order by jobtitle,gender asc;

-- 9. What is the distribution of job titles across the company?

select jobtitle,count(*) from hr group by jobtitle order by jobtitle asc;

-- 10. What is the distribution of employees across locations by state?

select location_state, count(*) from hr group by location_state;

-- 11. What is the distribution of employees across locations by city?

select location_city,count(*) from hr group by location_city;

-- 12. What is the tenure distribution for each department?

select department, avg(datediff(curdate(),termdate)/365) as avg_tenure from hr where termdate<=curdate() group by department;