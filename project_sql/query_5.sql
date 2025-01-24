-- 5. What are the most optimal skills to learn?
/*
    In the remote Data Analyst job, the skills to learn indicate some insights:
    Most Relevant Overall:

Python and R dominate demand, with competitive salaries, making them the most relevant for general data analyst roles.
Tools like Tableau and Snowflake balance strong demand and above-average pay.
Specialized Tools for High Pay:

Skills like Go, Hadoop, and Azure offer higher salaries for specialized roles but have lower demand compared to generalist tools.
Emerging Trends:

Cloud skills (AWS, Azure, Snowflake) and big data tools (Hadoop, Spark) are becoming increasingly integral to analytics roles.
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- Luke's Solution:
WITH skills_avg_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills AS skill_name,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' 
        AND job_postings_fact.salary_year_avg IS NOT NULL 
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
), skills_demand_count AS (
    SELECT
        skills_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL 
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
)
SELECT 
    skills_avg_salary.skill_id,
    skills_avg_salary.skill_name,
    skills_demand_count.demand_count,
    skills_avg_salary.avg_salary
FROM 
    skills_avg_salary
INNER JOIN skills_demand_count ON skills_demand_count.skill_id = skills_avg_salary.skill_id
WHERE
    skills_demand_count.demand_count > 10
ORDER BY
    skills_avg_salary.avg_salary DESC,
    skills_demand_count.demand_count DESC
LIMIT 25;