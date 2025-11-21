create database project;
use project;
select * from salary;

-- 1. Average Salary by Industry and Gender
select industry,Gender,round(avg(salary_usd),2) AS Average_Salary
from salary
group by Industry,gender ;



-- 2.Total Salary Compensation by Job Title 

SELECT 
    `Job Title`,
    ROUND(SUM(Salary_USD),2) AS total_salary
FROM salary
GROUP BY `Job Title`;




-- 3.Salary Distribution by Education Level 

select 
`Highest Level of Education Completed` as Education_level,
round(avg(salary_usd),2) as average_salary,
round(min(salary_usd),2) as minimum_salary,
round(max(salary_usd),2) as maximum_salary
from salary
group by Education_level;


-- 4.Number of Employees by Industry and Years of Experience
SELECT 
    Industry,
    `Years of Professional Experience Overall` AS Experience_Years,
    COUNT(*) AS Employee_Count
FROM salary
GROUP BY Industry, `Years of Professional Experience Overall`;



ALTER TABLE salary 
RENAME COLUMN `ï»¿Age Range` TO Age_Range;

-- 5.Median Salary by Age Range and Gender
SELECT 
    Age_Range,
    Gender,
    AVG(middle_salaries.Salary_USD) AS median_salary
FROM (
    SELECT 
        Age_Range,
        Gender,
        Salary_USD,
        ROW_NUMBER() OVER (PARTITION BY Age_Range, Gender ORDER BY Salary_USD) AS row_num,
        COUNT(*) OVER (PARTITION BY Age_Range, Gender) AS total_count
    FROM salary
) AS middle_salaries
WHERE 
    row_num IN ((total_count + 1) DIV 2, (total_count + 2) DIV 2)
GROUP BY Age_Range, Gender;



-- 6.Job Titles with the Highest Salary in Each Country

select country,
`Job Title`,
max(salary_usd) as hightest_salary
from salary
group by `Job Title`,country
order by hightest_salary desc;


-- 7.Average Salary by City and Industry
select city,industry,
round(avg(salary_usd),2) as Average_salary
from salary 
group by city,industry;


-- 8.Percentage of Employees with Additional Monetary Compensation by Gender
select gender,round(count(`Additional Monetary Compensation`)*100/
(select count(*) from salary),2) as percentage
from salary
group by gender;



-- 9.Total Compensation by Job Title and Years of Experience

select `Job Title`,
`Years of Professional Experience in Field`  as Experience,
round(sum(salary_usd),2) as total_salary
from salary
group by `Job Title`,experience;


-- 10.Average Salary by Industry, Gender, and Education Level
select industry,
gender,
`Highest Level of Education Completed` as Education_level,
round(avg(salary_usd),2) as Average_Salary
from salary
group by Industry,gender,Education_level;
