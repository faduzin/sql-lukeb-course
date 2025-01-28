-- 3. What are the most in-demand skills for my role?
-- This is also the answer for problem 7, but it was done doing CTE there
-- R: SQL, Excel, Python, Tableau and Power BI are the top 5 most in demand skills 

SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY 
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;