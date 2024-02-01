-- select * from diabetes
-- select EmployeeName from diabetes
-- Select * from diabetes
Use Diabetes_prediction
-- Retrieve the Patient_id and ages of all patients.

SELECT Patient_id, age 
FROM patients

-- Select all female patients who are older than 40.

SELECT gender, age 
FROM patients 
WHERE gender='Female' and age >40

-- Calculate the average BMI of patients.

SELECT BMI, avg(BMI) as Average_BMI 
FROM patients
GROUP BY BMI

-- List patients in descending order of blood glucose levels.

SELECT *
FROM patients 
ORDER BY blood_glucose_level desc

-- Find patients who have hypertension and diabetes.
-- hypertension=1 and diabetes=1

SELECT *
FROM patients 
WHERE hypertension='1' and diabetes='1'

--Determine the number of patients with heart disease. heart_disease=1

SELECT * 
FROM patients
WHERE heart_disease='1'

--Group patients by smoking history and count how many smokers and nonsmokers there are.

SELECT smoking_history,count(*) AS patientscount
FROM patients
GROUP BY smoking_history

--Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.

SELECT patient_id
FROM patients
WHERE bmi >(select avg(bmi) from patients)

--Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.

SELECT max(Hba1c_level) as highest, min(HbA1c_level) as lowest 
FROM patients 

SELECT top 1 Patient_id, HbA1c_level 
FROM patients
ORDER BY HbA1c_level desc 

SELECT top 1 patient_id, HbA1c_level 
FROM patients
ORDER BY HbA1c_level asc

--Calculate the age of patients in years (assuming the current date as of now).

SELECT patient_id,Age, DATEADD(YEAR, -Age, '2024-01-31') AS CurrentDate
FROM patients

--Rank patients by blood glucose level within each gender group.

SELECT patient_id, blood_glucose_level, gender,
RANK() OVER (PARTITION BY gender order by blood_glucose_level desc) as GlucoseLevel
FROM patients

--Update the smoking history of patients who are older than 50 to "Ex-smoker."

UPDATE patients
SET Smoking_history='Ex-smoker'
WHERE age>50

--Checking the database if it is change or not.
SELECT age, Smoking_history
FROM patients

SELECT * FROM patients

-- Insert a new patient into the database with sample data.

INSERT INTO patients(EmployeeName,Patient_id,gender,age,hypertension,heart_disease,smoking_history,bmi,HbA1c_level,blood_glucose_level,diabetes)
VALUES 
('Rahul','PT1','Male',23,0,0,'never',23.25,0,80,0)
INSERT INTO patients(EmployeeName,Patient_id,gender,age,hypertension,heart_disease,smoking_history,bmi,HbA1c_level,blood_glucose_level,diabetes)
VALUES
('Alex','PT2','Male',51,1,0,'Ex-smoker',36.2,5.6,140,0),
('leenar','PT3','Male',26,0,1,'No Info',30.25,6.8,90,0),
('Rachna','PT4','Female',24,0,0,'never',50.6,3.5,100,0),
('Farhina','PT5','Female',25,0,0,'former',29.25,6.7,120,0)

--Delete all patients with heart disease from the database.

DELETE FROM patients
WHERE heart_disease=1

--Checking if it is deleted or not
select * from patients

--Find patients who have hypertension but not diabetes using the EXCEPT operator

SELECT patient_id FROM patients
WHERE hypertension=1 
EXCEPT
SELECT patient_id FROM patients
WHERE  diabetes= 0

--Define a unique constraint on the "patient_id" column to ensure its values are unique.

--Checking the duplicate value in column "patient_id" and count of duplicate
SELECT patient_id, COUNT(*)
FROM patients
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- With the help of Common Table Expression(CTE) Removing duplicates
WITH DuplicateCTE AS (
SELECT patient_id,
ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY (SELECT NULL)) AS RowNum
FROM patients
)
DELETE FROM DuplicateCTE WHERE RowNum > 1;

-- Updating Duplicate

wITH DuplicateCTE AS (
    SELECT patient_id,
           ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY (SELECT NULL)) AS RowNum
    FROM patients
)
UPDATE DuplicateCTE SET patient_id = patient_id + '_Duplicate' + CAST(RowNum AS VARCHAR);

-- Constraint Creation

ALTER TABLE patients
ADD CONSTRAINT UC_patient_id UNIQUE (patient_id);


