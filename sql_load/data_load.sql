-- To import the database you must go into pgAdmin4 and access the database
-- Then right-click on the name of the database
-- Select PSQL Tool
-- Change the file path in the following commands
-- Copy and paste it in the PSQL Tool terminal

\COPY company_dim FROM '[file_path]\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF-8');

\COPY job_postings_fact FROM '[file_path]\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF-8');

\COPY skills_dim FROM '[file_path]\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF-8');

\COPY skills_job_dim FROM '[file_path]\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF-8');
