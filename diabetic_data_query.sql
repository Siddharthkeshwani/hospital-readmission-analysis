CREATE DATABASE hospital_readmission;
use hospital_readmission;

-- create a table that matches every column in our cleaned CSV file
-- we define the column name and what type of data it holds

CREATE TABLE diabetic_patients (

    -- patient identifiers
    patient_nbr             BIGINT,         -- unique patient number
    
    -- demographic information
    race                    VARCHAR(50),    -- patient race/ethnicity
    gender                  VARCHAR(20),    -- patient gender
    age                     VARCHAR(20),    -- age bracket like [60-70)
    age_numeric             INT,            -- age converted to midpoint number

    -- admission details
    admission_type_id       INT,            -- type of admission (emergency, elective etc.)
    discharge_disposition_id INT,           -- how patient was discharged
    admission_source_id     INT,            -- where the patient came from

    -- hospital stay details
    time_in_hospital        INT,            -- number of days spent in hospital

    -- procedure and lab details
    num_lab_procedures      INT,            -- number of lab tests done
    num_procedures          INT,            -- number of procedures performed
    num_medications         INT,            -- number of medications prescribed

    -- prior visit history
    number_outpatient       INT,            -- outpatient visits before this stay
    number_emergency        INT,            -- emergency visits before this stay
    number_inpatient        INT,            -- inpatient visits before this stay

    -- diagnosis codes (ICD-9 format)
    diag_1                  VARCHAR(20),    -- primary diagnosis
    diag_2                  VARCHAR(20),    -- secondary diagnosis
    diag_3                  VARCHAR(20),    -- third diagnosis
    number_diagnoses        INT,            -- total number of diagnoses recorded

    -- blood sugar test results
    max_glu_serum           VARCHAR(20),    -- glucose serum test result
    A1Cresult               VARCHAR(20),    -- HbA1c test result

    -- diabetes medications (each column = one drug)
    -- values are: No / Steady / Up / Down
    metformin               VARCHAR(20),
    repaglinide             VARCHAR(20),
    nateglinide             VARCHAR(20),
    chlorpropamide          VARCHAR(20),
    glimepiride             VARCHAR(20),
    acetohexamide           VARCHAR(20),
    glipizide               VARCHAR(20),
    glyburide               VARCHAR(20),
    tolbutamide             VARCHAR(20),
    pioglitazone            VARCHAR(20),
    rosiglitazone           VARCHAR(20),
    acarbose                VARCHAR(20),
    miglitol                VARCHAR(20),
    troglitazone            VARCHAR(20),
    tolazamide              VARCHAR(20),
    examide                 VARCHAR(20),
    citoglipton             VARCHAR(20),
    insulin                 VARCHAR(20),
    `glyburide-metformin`   VARCHAR(20),    -- backticks because column has a hyphen
    `glipizide-metformin`   VARCHAR(20),
    `glimepiride-pioglitazone` VARCHAR(20),
    `metformin-rosiglitazone`  VARCHAR(20),
    `metformin-pioglitazone`   VARCHAR(20),

    -- medication and diabetes flags
    `change`                  VARCHAR(20),    -- was any medication changed? Yes/No
    diabetesMed             VARCHAR(20),    -- is patient on diabetes medication?

    -- original target column
    readmitted              VARCHAR(10),    -- original: <30, >30, NO

    -- engineered features we created in Python
    readmitted_30           INT,            -- our binary target: 1 = readmitted in <30 days
    total_visits            INT,            -- sum of all prior visits
    num_medications_changed INT,            -- number of medications with dose changes
    comorbidity_score       INT,            -- number of diagnoses present (max 3)
    prior_inpatient_capped  INT             -- prior inpatient visits capped at 6

);

-- Checking the Row count
select count(*) as total_rows
from diabetic_patients;

-- looking at the first 5 rows
select * from diabetic_patients
limit 5;

-- check for NULL values in a column
select count(*) from diabetic_patients
where A1Cresult is null;

-- Query 1: Basic count of readmission categories
select readmitted, count(*) as total
from diabetic_patients
group by readmitted
order by total desc;

-- Query 2: Overall 30-day readmission rate
select ROUND(AVG(readmitted_30)* 100,2) as readmission_rate
from diabetic_patients;

-- Query 3: Readmission rate by age group
select age,
	   count(*) as total,
       sum(readmitted_30) as readmitted,
       round(avg(readmitted_30)* 100,2) as rate_pct
from diabetic_patients
group by age
having count(*)>=100
order by rate_pct desc;

-- Query 4: Top 10 diagnoses with highest readmission rates
select diag_1,
	   count(*) as total,
       sum(readmitted_30) as readmitted,
       round(avg(readmitted_30)*100, 2) as rate_pct
from diabetic_patients
group by diag_1
having count(*)>= 50
order by rate_pct desc
limit 10;

-- Query 5: Average Hospital stay by discharge type
select discharge_disposition_id,
		count(*) as total,
		round(avg(time_in_hospital),2) as avg_stay_days,
		round(avg(readmitted_30)*100,2) as readmission_rate
from diabetic_patients
group by discharge_disposition_id
order by avg_stay_days desc;

-- Query 6: High-risk patients using a subquery
select count(*) as high_risk_patients
from
	(select patient_nbr from diabetic_patients
where number_inpatient >= 3 
) as high_risk;

-- Query 7: Patient profile comparison by readmission satus
select  readmitted_30,
	round(avg(num_medications), 2) as avg_medication,
    round(avg(time_in_hospital),2) as avg_stay_days,
    round(avg(number_diagnoses), 2) as avg_diagnoses,
    round(avg(age_numeric), 2) as avg_age
from diabetic_patients
group by readmitted_30;

-- Query 8: Readmission rate by insulin status
select insulin,
		count(*) as total_patients,
        round(avg(readmitted_30)*100, 2) as readmission_rate_pct
from diabetic_patients
group by insulin
order by readmission_rate_pct desc;

-- Query 9: Race equity check
select race,
	count(*) as total_patients,
    sum(readmitted_30),
    round(avg(readmitted_30)*100,2) as readmission_rate_pct
from diabetic_patients
group by race
order by readmission_rate_pct;

-- Query 10: window function - Rank admission types by readmission rate
select admission_type_id,
	   total_patients,
       readmission_rate_pct,
       rank() over (order by readmission_rate_pct desc) as risk_rank
from (
	   select admission_type_id,
			  count(*) as total_patients,
              round(avg(readmitted_30)*100,2) as readmission_rate_pct
		from diabetic_patients
        group by admission_type_id
	 ) as summary;
     


