CREATE DATABASE global_ds_salary;
USE global_ds_salary;


CREATE TABLE salaries (
	s_No INT,
    work_year INT,
    experience_level VARCHAR(5),
    employment_type VARCHAR(5),
    job_title VARCHAR(100),
    salary NUMERIC,
    salary_currency VARCHAR(10),
    salary_in_usd NUMERIC,
    employee_residence VARCHAR(5),
    remote_ratio INT,
    company_location VARCHAR(5),
    company_size VARCHAR(5)
);


SHOW VARIABLES LIKE "secure_file_priv";


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ds_salaries.csv'
INTO TABLE salaries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*) FROM salaries;
SELECT * FROM salaries LIMIT 10;


CREATE VIEW salaries_cleaned AS
SELECT
    work_year,
    CASE experience_level
        WHEN 'EN' THEN 'Entry Level'
        WHEN 'MI' THEN 'Mid Level'
        WHEN 'SE' THEN 'Senior Level'
        WHEN 'EX' THEN 'Executive Level'
    END AS experience_level,
    CASE employment_type
        WHEN 'FT' THEN 'Full-Time'
        WHEN 'PT' THEN 'Part-Time'
        WHEN 'CT' THEN 'Contract'
        WHEN 'FL' THEN 'Freelance'
    END AS employment_type,
    job_title,
    salary,
    salary_currency,
    salary_in_usd,
    employee_residence,
    CASE remote_ratio
        WHEN 0 THEN 'On-Site'
        WHEN 50 THEN 'Hybrid'
        WHEN 100 THEN 'Fully Remote'
    END AS work_mode,
    company_location,
    CASE company_size
        WHEN 'S' THEN 'Small'
        WHEN 'M' THEN 'Medium'
        WHEN 'L' THEN 'Large'
    END AS company_size
FROM salaries;


SELECT
    job_title,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    COUNT(*) AS total_roles
FROM salaries_cleaned
GROUP BY job_title
HAVING COUNT(*) > 5
ORDER BY avg_salary DESC;


SELECT
    experience_level,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM salaries_cleaned
GROUP BY experience_level
ORDER BY avg_salary DESC;


WITH exp_salary AS (
    SELECT
        experience_level,
        AVG(salary_in_usd) AS avg_salary
    FROM salaries_cleaned
    GROUP BY experience_level
)
SELECT
    experience_level,
    ROUND(avg_salary,0) AS avg_salary,
    ROUND(
        (avg_salary - LAG(avg_salary) OVER (ORDER BY avg_salary))
        / LAG(avg_salary) OVER (ORDER BY avg_salary) * 100,
    2) AS percent_increase
FROM exp_salary;


SELECT
    company_location,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    COUNT(*) AS total_jobs
FROM salaries_cleaned
GROUP BY company_location
HAVING COUNT(*) >= 10
ORDER BY avg_salary DESC;


SELECT
    work_mode,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    COUNT(*) AS total_roles
FROM salaries_cleaned
GROUP BY work_mode
ORDER BY avg_salary DESC;


SELECT
    company_size,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    COUNT(*) AS total_roles
FROM salaries_cleaned
GROUP BY company_size
ORDER BY avg_salary DESC;


SELECT
    work_year,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    ROUND(
        (AVG(salary_in_usd) -
        LAG(AVG(salary_in_usd)) OVER (ORDER BY work_year))
        / LAG(AVG(salary_in_usd)) OVER (ORDER BY work_year) * 100,
    2) AS yoy_growth_percent
FROM salaries_cleaned
GROUP BY work_year
ORDER BY work_year;


SELECT *
FROM (
    SELECT
        work_year,
        job_title,
        salary_in_usd,
        RANK() OVER (
            PARTITION BY work_year
            ORDER BY salary_in_usd DESC
        ) AS salary_rank
    FROM salaries_cleaned
) ranked
WHERE salary_rank <= 3;


SELECT
    job_title,
    salary_in_usd,
    PERCENT_RANK() OVER (
        PARTITION BY job_title
        ORDER BY salary_in_usd
    ) AS salary_percentile
FROM salaries_cleaned;


CREATE INDEX idx_salary_usd ON salaries(salary_in_usd);
CREATE INDEX idx_job_title ON salaries(job_title);
CREATE INDEX idx_work_year ON salaries(work_year);


CREATE VIEW executive_summary AS
SELECT
    work_year,
    COUNT(*) AS total_jobs,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    ROUND(MAX(salary_in_usd),0) AS highest_salary
FROM salaries_cleaned
GROUP BY work_year;


CREATE VIEW v_salary_by_experience AS
SELECT
    experience_level,
    ROUND(AVG(salary_in_usd),0) AS avg_salary,
    COUNT(*) AS total_roles
FROM salaries
GROUP BY experience_level;


CREATE OR REPLACE VIEW v_overall_kpis AS
SELECT
    COUNT(*) AS total_roles,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary_global,
    ROUND(MIN(salary_in_usd), 0) AS min_salary_global,
    ROUND(MAX(salary_in_usd), 0) AS max_salary_global,
    COUNT(DISTINCT job_title) AS total_unique_roles,
    COUNT(DISTINCT company_location) AS total_countries
FROM salaries;


CREATE OR REPLACE VIEW v_salary_by_experience AS
SELECT
    CASE experience_level
        WHEN 'EN' THEN 'Entry Level'
        WHEN 'MI' THEN 'Mid Level'
        WHEN 'SE' THEN 'Senior Level'
        WHEN 'EX' THEN 'Executive Level'
    END AS experience_level,
    COUNT(*) AS total_roles,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary,
    ROUND(MIN(salary_in_usd), 0) AS min_salary,
    ROUND(MAX(salary_in_usd), 0) AS max_salary
FROM salaries
GROUP BY experience_level
ORDER BY avg_salary DESC;


CREATE OR REPLACE VIEW v_salary_by_country AS
SELECT
    company_location,
    COUNT(*) AS total_roles,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary
FROM salaries
GROUP BY company_location
HAVING COUNT(*) >= 5
ORDER BY avg_salary DESC;


CREATE OR REPLACE VIEW v_salary_by_year AS
SELECT
    work_year,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary,
    ROUND(
        (AVG(salary_in_usd) -
        LAG(AVG(salary_in_usd)) OVER (ORDER BY work_year))
        / LAG(AVG(salary_in_usd)) OVER (ORDER BY work_year) * 100,
    2) AS yoy_growth_percent
FROM salaries
GROUP BY work_year
ORDER BY work_year;


CREATE OR REPLACE VIEW v_salary_by_company_size AS
SELECT
    CASE company_size
        WHEN 'S' THEN 'Small'
        WHEN 'M' THEN 'Medium'
        WHEN 'L' THEN 'Large'
    END AS company_size,
    COUNT(*) AS total_roles,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary
FROM salaries
GROUP BY company_size
ORDER BY avg_salary DESC;


CREATE OR REPLACE VIEW v_remote_impact AS
SELECT
    CASE remote_ratio
        WHEN 0 THEN 'On-Site'
        WHEN 50 THEN 'Hybrid'
        WHEN 100 THEN 'Fully Remote'
    END AS work_mode,
    COUNT(*) AS total_roles,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary
FROM salaries
GROUP BY remote_ratio
ORDER BY avg_salary DESC;


CREATE OR REPLACE VIEW v_top_paying_roles AS
SELECT
    job_title,
    COUNT(*) AS total_roles,
    ROUND(AVG(salary_in_usd), 0) AS avg_salary
FROM salaries
GROUP BY job_title
HAVING COUNT(*) >= 5
ORDER BY avg_salary DESC;


CREATE OR REPLACE VIEW v_salary_percentiles AS
SELECT
    job_title,
    salary_in_usd,
    PERCENT_RANK() OVER (
        PARTITION BY job_title
        ORDER BY salary_in_usd
    ) AS salary_percentile
FROM salaries;


SHOW FULL TABLES
WHERE table_type = 'VIEW';

SELECT * FROM v_overall_kpis;
SELECT * FROM v_salary_by_experience;
SELECT * FROM v_salary_by_year;