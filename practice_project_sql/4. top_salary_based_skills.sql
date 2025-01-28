-- 4. What are the top skills based on salary for my role?
/*
All Data Analyst Roles:
Top-Paying Skills:

GitLab ($134,126), Kafka ($129,999), and PyTorch ($125,226) are among the highest-paying skills, reflecting demand for collaboration tools, data streaming, and AI/ML frameworks.
High Demand Skills:

Spark (187 occurrences) and Snowflake (241 occurrences) dominate in demand but offer mid-range salaries (~$113,000) due to their widespread use.
Specialized Tools = Higher Pay:

Niche tools like Aurora ($113,394) and Unify ($112,317) have fewer occurrences but offer competitive salaries.
AI/ML and Data Engineering:

Tools like TensorFlow ($120,646), Airflow ($116,387), and Databricks ($112,881) highlight the value of expertise in machine learning and data pipeline automation.
Foundational Skills Are Essential:

Widely used tools like GCP, Git, MongoDB, and Pyspark are must-haves, with strong demand and salaries in the ~$110,000 range.

Remote Data Analyst Roles:
Top-Paying Skills:

Pandas ($151,821), NumPy ($143,513), and Databricks ($141,907) are the highest-paying skills, reflecting the premium for expertise in data manipulation, numerical computation, and advanced data engineering for remote roles.
High Demand Skills with Moderate Salaries:

Snowflake (37 occurrences), Azure (34 occurrences), and AWS (32 occurrences) are the most in-demand skills, with average salaries around $108,000–$113,000, showcasing their widespread use in remote data analytics and cloud-based roles.
Specialized Tools with Competitive Pay:

Skills like Airflow ($126,103), Scala ($124,903), and PostgreSQL ($123,879) offer solid salaries, though their counts (5 each) suggest they are more niche in remote roles.
Collaboration Tools in Remote Work:

Tools like Atlassian ($131,162), Confluence ($114,210), Jira ($104,918), and Git ($112,000) emphasize the importance of collaborative platforms for remote teams.
Traditional Skills with Lower Salaries:

Skills like Oracle ($104,534), SAP ($102,920), and Java ($106,906) still see demand but offer lower average salaries compared to modern or specialized tools.
*/


SELECT
    skills_dim.skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,
    COUNT(salary_year_avg)
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
HAVING
    COUNT(salary_year_avg) > 3
ORDER BY
    avg_salary DESC
LIMIT 25;