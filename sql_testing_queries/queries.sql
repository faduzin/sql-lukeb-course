-- Checking if all data was properly loaded:
SELECT * 
FROM company_dim 
LIMIT 5;

SELECT * 
FROM job_postings_fact 
LIMIT 5;

SELECT * 
FROM skills_dim 
LIMIT 5;

SELECT * 
FROM skills_job_dim 
LIMIT 5;

-- How to cast value types
SELECT 
    '10-10-2001'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;

SELECT
    job_title AS title,
    job_location AS location,
    job_posted_date AS date --No need to cast as DATE as I created the table casting it, losing the timestamp value, which is not good
FROM
    job_postings_fact
LIMIT 100;

-- To convert timestamp you use AT TIME ZONE 'actual timezone' AT TIME ZONE 'the time zone you aim'

-- To EXTRACT month/year from a date
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS year_month
FROM
    job_postings_fact
LIMIT 5;

-- How is that useful?
-- Analysing this query shows that the first 3 months of the year have higher amount of jobs posted
SELECT
    COUNT(job_id) as job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) as date_month
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
    job_posted_count DESC;

-- How to create a table with selected data
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Checking if it worked as intended
SELECT *
FROM january_jobs
LIMIT 10;    

-- How to use CASE
SELECT
    job_title_short AS title,
    job_location AS location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Tampa, FL' OR job_location = 'Atlanta, GA' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact;

-- How to use GROUP BY effectively
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Tampa, FL' OR job_location = 'Atlanta, GA' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE job_title_short = 'Data Analyst'    
GROUP BY location_category;


