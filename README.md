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

#### Key Insights based on results:
- **Salaries Fall Within a Consistent Range:** The average yearly salaries for these top-paying roles range from $184,000 to $650,000, indicating a significant but manageable disparity. This suggests a relatively competitive market for leadership roles in data analytics.

- **Diverse Employers:** The jobs are offered by a variety of employers, such as Mantys, Meta, and AT&T, reflecting a broad demand for high-level data professionals across industries.

- **Variety in Job Titles:** While all roles are senior-level, the titles vary significantly, including Director, Principal Data Analyst, and Associate Director. This diversity indicates that leadership and high-paying roles in data analytics are not confined to a single standard title, offering flexibility in career paths.

#### Answer to the Question

The analysis reveals the top-paying jobs for Data Analysts, with salaries ranging from $184,000 to an exceptional $650,000. The highest-paying role, a "Data Analyst" at Mantys, significantly outpaces other positions, indicating unique market demand. Leadership roles like Directors and Associate Directors also rank among the highest-paying, highlighting the value of strategic and managerial expertise in the data analytics field.

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

![Top 5 Most In-Demand Skills among the 10 highest-paying Data Analyst roles](<assets/top-5-in-demand-skills.png>)<figcaption>*Bar graph visualizing the top 5 most in-demand skills for the highest-paying data analyst roles; ChatGPT generated this graph from my SQL query results.*</figcaption>

#### Key Insights based on results:

- **SQL Dominates the Field:** SQL is the most frequently mentioned skill, appearing in almost all of the top-paying roles, underlining its fundamental importance in data analysis.

- **Python and Tableau Lead Supporting Skills:** Python and Tableau are close contenders, reinforcing their role as essential tools for analysis and visualization in high-paying positions.

- **Diverse Skill Sets Are Valued:** While technical skills like R and Snowflake are critical, the variety of tools listed across the roles highlights the value of diverse expertise in securing top-paying jobs.

#### Answer to the Question

The top-paying Data Analyst roles require a mix of technical and analytical skills, with SQL leading the pack, followed by Python, Tableau, R, and Snowflake. These tools dominate the skill sets demanded by the highest-paying positions, underscoring their importance in securing lucrative jobs in the data analytics field.

### *3. What are the most in-demand skills for Data Analysts?*

This query identifies the most in-demand skills for the role of Data Analyst. It counts how frequently each skill appears across all Data Analyst job postings, orders them by demand, and retrieves the top 5 skills that are most sought after in the job market.

```sql
SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
The table below lists the top 5 most in-demand skills for Data Analyst positions based on their frequency in job postings:
| Skill Name | Demand Count |
|------------|--------------|
| SQL        | 92,628       |
| Excel      | 67,031       |
| Python     | 57,326       |
| Tableau    | 46,554       |
| Power BI   | 39,468       |

I then applied a filter to focus exclusively on remote jobs, and here are the results:
| Skill Name | Demand Count |
|------------|--------------|
| SQL        | 7291         |
| Excel      | 4611         |
| Python     | 4330         |
| Tableau    | 3745         |
| Power BI   | 2609         |

##### Key Insights based on the results:

- **SQL Is the Undisputed Leader:**
SQL dominates both categories, appearing in 92,628 general job postings and 7,291 remote job postings. Its consistent demand highlights its essential role across all Data Analyst positions.

- **Excel Remains a Key Tool:** 
Despite advancements in data technologies, Excel is highly in-demand, with 67,031 general mentions and 4,611 remote mentions, reflecting its adaptability for data management and analysis tasks.

- **Python's Flexibility Is Valued:**
Python ranks third in both general (57,326 mentions) and remote (4,330 mentions) job postings, showcasing its importance for data manipulation, automation, and advanced analytics.

- **Visualization Skills Are Critical:**
Tools like Tableau (46,554 general; 3,745 remote mentions) and Power BI (39,468 general; 2,609 remote mentions) remain vital for presenting data insights effectively, especially in roles that involve reporting and stakeholder communication.

- **Remote Roles Have a Similar Skill Profile:**
The remote job data reflects a similar skill hierarchy to general roles, suggesting that the core technical requirements remain the same, regardless of the work environment.

#### Answer to the Question

The most in-demand skills for Data Analysts are SQL, Excel, Python, Tableau, and Power BI, appearing most frequently across job postings. These skills represent the core competencies employers seek, ensuring versatility and effectiveness in managing, analyzing, and visualizing data.

### *4. What are the top skills based on salary for Data Analysts?*

This query identifies the top skills based on average salary for Data Analyst roles. It calculates the average salary for each skill across job postings, filters for skills with at least 3 mentions, and retrieves the top 25 skills ranked by their average salary.

```sql
SELECT
    skills_dim.skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,
    COUNT(salary_year_avg)
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
HAVING
    COUNT(salary_year_avg) > 3
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here is a grouped bar chart comparing the average salaries for skills across all jobs and remote jobs. It highlights differences in compensation for each skill based on job type.

![Comparison of Average Salaries for All Jobs vs Remote Jobs by Skill](<assets/comparison-of-average-salaries-per-skill.png>)<figcaption>Bar graph comparing the average salaries for all jobs versus remote jobs by skill; ChatGPT generated this graph using merged SQL query results.</figcaption>

#### Key Insights based on the results:

- **Skill-Based Salary Variance:**
Certain skills, such as Pandas and NumPy, command significantly higher average salaries in remote roles compared to all jobs. For example, Pandas averages $151,821 in remote jobs, far exceeding most skills in all jobs.

- **Databricks Stands Out in Both Categories:**
Databricks appears as one of the top-paying skills in both all jobs ($112,881) and remote jobs ($141,907), showcasing its relevance and demand across job types.

- **Snowflake's Consistent Value:**
Snowflake remains a high-paying and widely in-demand skill in both categories, maintaining average salaries of around $111,578 (all jobs) and $112,948 (remote jobs).

- **Remote Jobs Favor Specialized Tools:**
Remote roles show a preference for specialized tools like Pandas, NumPy, and PostgreSQL, which have higher average salaries compared to their general counterparts.

#### Answer to the Question
The top skills based on salary for Data Analyst roles vary slightly between all jobs and remote jobs. For all jobs, GitLab, Kafka, and PyTorch dominate the top-paying skills. In remote jobs, skills like Pandas, NumPy, and Databricks lead the pack.

This analysis highlights that while some skills are universally valuable, certain tools and frameworks command a premium specifically in remote job markets. This could be due to the specialized nature of remote work environments requiring more advanced or niche technical expertise.


### *5. What are the most optimal skills to learn?*




## Future Plans

- Add and answer more data analysis questions beyond those covered in the video.
- Optimize and refine queries for better performance.
- Explore potential visualizations based on the SQL analysis results.

---

## Contact

If you have any questions or feedback, feel free to reach out:\
[GitHub](https://github.com/faduzin) | [LinkedIn](https://www.linkedin.com/in/ericfadul/) | [eric.fadul@gmail.com](mailto\:eric.fadul@gmail.com)

