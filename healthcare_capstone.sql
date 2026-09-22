-- Healthcare Insurance Capstone Project
-- SQL Queries


-- Creating hospitalisation table

CREATE TABLE hospitalisation (
    customer_id VARCHAR(20),
    year VARCHAR(10),
    month VARCHAR(10),
    date INT,
    children INT,
    charges NUMERIC(10,2),
    hospital_tier VARCHAR(20),
    city_tier VARCHAR(20),
    state_id VARCHAR(20)
);


-- Creating medical examination table

CREATE TABLE medical_examinations (
    customer_id VARCHAR(20),
    bmi NUMERIC(6,2),
    hba1c NUMERIC(6,2),
    heart_issues VARCHAR(10),
    any_transplants VARCHAR(10),
    cancer_history VARCHAR(10),
    number_of_major_surgeries VARCHAR(30),
    smoker VARCHAR(10)
);


-- Checking customer IDs in hospitalisation table

SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS non_null_ids,
    COUNT(DISTINCT customer_id) AS unique_ids
FROM hospitalisation;


-- Checking customer IDs in medical examination table

SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS non_null_ids,
    COUNT(DISTINCT customer_id) AS unique_ids
FROM medical_examinations;


-- Found 6 rows with ? as customer ID, so removing them

DELETE FROM hospitalisation
WHERE customer_id = '?';


-- Adding customer ID as primary key

ALTER TABLE hospitalisation
ADD PRIMARY KEY (customer_id);

ALTER TABLE medical_examinations
ADD PRIMARY KEY (customer_id);


-- Finding average age, children, BMI and hospitalisation cost
-- for diabetic patients who also have heart issues

SELECT
    ROUND(AVG(EXTRACT(YEAR FROM CURRENT_DATE) - CAST(h.year AS INT)), 2) AS avg_age,
    ROUND(AVG(h.children), 2) AS avg_children,
    ROUND(AVG(m.bmi), 2) AS avg_bmi,
    ROUND(AVG(h.charges), 2) AS avg_hospitalisation_cost
FROM hospitalisation h
JOIN medical_examinations m
    ON h.customer_id = m.customer_id
WHERE m.hba1c > 6.5
  AND m.heart_issues = 'yes'
  AND h.year <> '?';

-- Result
-- Average age = 53.30
-- Average children = 1.02
-- Average BMI = 31.37
-- Average hospitalisation cost = 16475.22


-- Finding average hospitalisation cost for each hospital and city tier

SELECT
    hospital_tier,
    city_tier,
    ROUND(AVG(charges), 2) AS average_cost
FROM hospitalisation
WHERE hospital_tier <> '?'
  AND city_tier <> '?'
GROUP BY hospital_tier, city_tier
ORDER BY hospital_tier, city_tier;

-- Result
-- Hospital tier 1 had the highest average hospitalisation costs


-- Finding number of patients who had major surgery
-- and also have cancer history

SELECT COUNT(*) AS patients_with_surgery_and_cancer
FROM medical_examinations
WHERE number_of_major_surgeries <> 'No major surgery'
  AND cancer_history = 'Yes';

-- Result = 391 patients


-- Finding Tier 1 hospitalisation records for each state

SELECT
    state_id,
    COUNT(*) AS tier1_hospital_count
FROM hospitalisation
WHERE hospital_tier = 'tier - 1'
  AND state_id <> '?'
GROUP BY state_id
ORDER BY tier1_hospital_count DESC;

-- Result
-- R1011 = 116
-- R1013 = 68
-- R1012 = 63
-- These were the top three states
