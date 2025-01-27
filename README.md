# SQL Data Analysis Project

Discover insights from the data job market! This project dives into 📈 top-paying data analyst roles, 🔑 in-demand skills, and 🌍 where high demand meets lucrative opportunities in data analytics.

Inspired by a step-by-step video tutorial by [Luke Barousse](https://www.youtube.com/@LukeBarousse), this project recreates and expands upon his analysis.

Check out SQL queries here: [project_sql folder](/practice_project_sql/)

---

## Table of Contents

1. [Background](#background)
2. [Folder Structure](#folder-structure)
3. [Tools I Used](#tools-i-used)
4. [The Analysis](#the-analysis)
5. [Future Plans](#future-plans)
6. [Contact](#contact)

---

## Background

The rise of data analytics has made data analyst roles some of the most sought-after in the job market. With a focus on the intersection of high demand and high salary, this project analyzes key questions about the data job market, such as:

1. What are the top-paying jobs for Data Analysts?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for Data Analysts?
4. What are the top skills based on salary for Data Analysts?
5. What are the most optimal skills to learn?

By answering these questions, this project provides valuable insights for anyone looking to enter or grow in the data analytics field.

---

## Tools I Used

To bring this project to life, I utilized a set of powerful tools:

- **SQL**: The foundation of my analysis, enabling detailed data exploration and query-building.
- **PostgreSQL**: A robust database management system for efficiently organizing and querying the dataset.
- **Visual Studio Code**: My preferred environment for writing and executing SQL scripts.
- **Git & GitHub**: Essential for version control and sharing my work with clarity and organization.

---

## The Analysis

This project focused on uncovering key insights about the data analyst job market. Each query was designed to address specific questions, shedding light on trends, opportunities, and essential skills. Here’s how I tackled each aspect of the analysis:

### *1. What are the top-paying jobs for Data Analysts?*

To identify the highest-paying roles, I focused on Data Analyst positions with non-null average yearly salaries. The query highlights remote opportunities ("Anywhere") and ranks them by salary, showcasing the top 10 highest-paying roles in the field.

```sql
SELECT
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg,
    company_dim.name as company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL AND
    job_postings_fact.job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

The query reveals the top 10 highest-paying Data Analyst roles in the market, including their job titles, companies, and average yearly salaries.

| Rank | Job Title                                   | Company                        | Average Yearly Salary ($) |
|------|--------------------------------------------|--------------------------------|---------------------------|
| 1    | Data Analyst                               | Mantys                         | 650,000                  |
| 2    | Director of Analytics                      | Meta                           | 336,500                  |
| 3    | Associate Director- Data Insights          | AT&T                           | 255,829                |
| 4    | Data Analyst, Marketing                    | Pinterest Job Advertisements   | 232,423                  |
| 5    | Data Analyst (Hybrid/Remote)               | Uclahealthcareers              | 217,000                  |
| 6    | Principal Data Analyst (Remote)            | SmartAsset                     | 205,000                  |
| 7    | Director, Data Analyst - HYBRID            | Inclusively                    | 189,309                  |
| 8    | Principal Data Analyst, AV Performance     | Motional                       | 189,000                  |
| 9    | Principal Data Analyst                     | SmartAsset                     | 186,000                  |
| 10   | ERM Data Analyst                           | Get It Recruit - IT            | 184,000                  |

The top 10 data analyst jobs in 2023 indicates that:
- **Salaries Fall Within a Consistent Range:** The average yearly salaries for these top-paying roles range from $184,000 to $650,000, indicating a significant but manageable disparity. This suggests a relatively competitive market for leadership roles in data analytics.

- **Diverse Employers:** The jobs are offered by a variety of employers, such as Mantys, Meta, and AT&T, reflecting a broad demand for high-level data professionals across industries.

- **Variety in Job Titles:** While all roles are senior-level, the titles vary significantly, including Director, Principal Data Analyst, and Associate Director. This diversity indicates that leadership and high-paying roles in data analytics are not confined to a single standard title, offering flexibility in career paths.

### *2. What are the skills required for these top-paying roles?*

This query builds upon the top-paying Data Analyst jobs identified earlier by incorporating the specific skills required for each of those roles. It retrieves the job details, including titles, salaries, and company names, along with a list of associated skills, providing deeper insight into what makes these roles valuable. The results are ordered by salary, ensuring the highest-paying roles are highlighted first.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        job_postings_fact.salary_year_avg,
        company_dim.name as company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL AND
        job_postings_fact.job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;
```
The bar chart showcases the Top 5 Most In-Demand Skills among the 10 highest-paying Data Analyst roles. These skills are frequently mentioned across job postings, highlighting their importance in securing lucrative positions in the field.

![Top 5 Most In-Demand Skills among the 10 highest-paying Data Analyst roles](<assets\Top 5 Most In-Demand Skills.png>)<figcaption>*Bar graph visualizing the top 5 most in-demand skills for the highest-paying data analyst roles; ChatGPT generated this graph from my SQL query results.*</figcaption>

Here are some key insights based on the data for the most in-demand skills among the highest-paying Data Analyst roles:

- **SQL Dominates the Field:** SQL is the most frequently mentioned skill, appearing in almost all of the top-paying roles, underlining its fundamental importance in data analysis.

- **Python and Tableau Lead Supporting Skills:** Python and Tableau are close contenders, reinforcing their role as essential tools for analysis and visualization in high-paying positions.

- **Diverse Skill Sets Are Valued:** While technical skills like R and Snowflake are critical, the variety of tools listed across the roles highlights the value of diverse expertise in securing top-paying jobs.

### *3. What are the most in-demand skills for Data Analysts?*



### *4. What are the top skills based on salary for Data Analysts?*



### *5. What are the most optimal skills to learn?*




## Future Plans

- Add and answer more data analysis questions beyond those covered in the video.
- Optimize and refine queries for better performance.
- Explore potential visualizations based on the SQL analysis results.

---

## Contact

If you have any questions or feedback, feel free to reach out:\
[GitHub](https://github.com/faduzin) | [LinkedIn](https://www.linkedin.com/in/ericfadul/) | [eric.fadul@gmail.com](mailto\:eric.fadul@gmail.com)

