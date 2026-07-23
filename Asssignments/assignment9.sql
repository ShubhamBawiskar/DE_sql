-- Active: 1783779183123@@127.0.0.1@3306@clinic_db
SELECT * FROM doctor;
SELECT * FROM patitent;
SELECT * FROM visit;
-- =================================================================================================================================
/*
1.  The clinic manager wants to know how many patients each doctor attended every day. Display only those 
    days where a doctor handled at least two visits. */
-- =================================================================================================================================
SELECT
    v.doctor_id AS doctor_id,
    d.full_name AS doctor_name,
    v.visit_date,
    COUNT(p.id) AS total_patient
FROM doctor d
INNER JOIN visit v
    ON d.id=v.doctor_id
INNER JOIN patitent p
    ON p.id=v.patient_id
GROUP BY v.doctor_id, d.full_name, v.visit_date
HAVING COUNT(p.id)>=2;

-- =================================================================================================================================
-- 2. Find the average rating of doctors who have treated at least 5 different patients.
-- =================================================================================================================================
SELECT 
    d.id AS doctor_id,
    d.full_name AS doctor_name,
    d.rating As avg_rating,
    COUNT(DISTINCT v.patient_id) AS unique_patients
FROM doctor d
INNER JOIN visit v
    ON d.id=v.doctor_id
INNER JOIN patitent p
    ON p.id=v.patient_id
GROUP BY  d.id, d.full_name, d.rating
HAVING COUNT(DISTINCT v.patient_id)>=5; 

SELECT 
    d.id AS doctor_id,
    d.full_name AS doctor_name,
    d.rating As avg_rating,
    COUNT(p.id) AS unique_patients
FROM doctor d
INNER JOIN visit v
    ON d.id=v.doctor_id
INNER JOIN patitent p
    ON p.id=v.patient_id
GROUP BY  d.id, d.full_name
HAVING COUNT(p.id)>=4;

-- =================================================================================================================================
-- 3. Identify the doctor who has treated the highest number of unique patients.
-- =================================================================================================================================
SELECT 
    d.id AS doctor_id,
    d.full_name AS doctor_name,
    COUNT(DISTINCT v.patient_id) as unique_patients
FROM doctor d
INNER JOIN visit v
    ON d.id=v.doctor_id
GROUP BY d.id, d.full_name
ORDER BY unique_patients DESC
LIMIT 1;

-- =================================================================================================================================
-- 4. Generate a report showing the total revenue earned by each doctor based on the number of visits and the consultation fee.
-- =================================================================================================================================
SELECT 
    d.id AS doctor_id,
    d.full_name AS doctor_name,
    -- d.price_per_visit AS consultation_fee,
    COUNT(*) AS total_visits,
    COUNT(v.id)*d.price_per_visit
FROM doctor d
LEFT JOIN visit v
    ON d.id=v.doctor_id
GROUP BY d.id, d.full_name, d.price_per_visit;

-- =================================================================================================================================
-- 5. Find patients who have consulted more than one doctor.
-- =================================================================================================================================
SELECT 
    p.id,
    p.full_name,
    COUNT(DISTINCT v.doctor_id) AS total_doctors
FROM patitent p
INNER JOIN visit v
    ON p.id=v.patient_id
GROUP BY p.id, p.full_name
HAVING COUNT(DISTINCT v.doctor_id)>1;


-- =================================================================================================================================
-- 6. Find the city where the highest number of doctors are currently practicing.
-- =================================================================================================================================
SELECT 
    city,
    COUNT(DISTINCT id)
FROM doctor 
GROUP BY city
ORDER BY COUNT(DISTINCT id) DESC
LIMIT 1;

-- =================================================================================================================================
-- 7. Generate a report of the Top 3 doctors who generated the highest revenue.
-- =================================================================================================================================
SELECT 
    d.id,
    d.full_name,
    d.price_per_visit*COUNT(v.id) AS revenue
FROM doctor d
INNER JOIN visit v
    ON d.id=v.doctor_id
GROUP BY
    d.id,
    d.full_name,
    d.price_per_visit
ORDER BY revenue DESC
LIMIT 3;

-- =================================================================================================================================
-- 8. Identify doctors who have never been visited by any patient.
-- =================================================================================================================================
SELECT 
    d.id,
    d.full_name
FROM doctor d
LEFT JOIN visit v
    ON d.id=v.doctor_id
WHERE v.id IS NULL;

-- =================================================================================================================================
-- 9. Find all patients who have not booked any appointment.
-- =================================================================================================================================
SELECT 
    * 
FROM patitent p
LEFT JOIN visit v
    ON  p.id=v.patient_id
WHERE v.id IS NULL;

-- =================================================================================================================================
-- 10. Display every doctor along with the number of unique patients they have treated.
-- =================================================================================================================================
SELECT
    d.id, 
    d.full_name,
    COUNT(DISTINCT v.patient_id) AS treated_patients
FROM doctor d
LEFT JOIN visit v
    ON d.id=v.doctor_id 
GROUP BY 
    d.id, d.full_name
ORDER BY treated_patients DESC;

-- =================================================================================================================================
/* 11. Classify doctors based on total visits.
        o Excellent (10 or more visits) 
        o Good (5–9 visits) 
        o Needs Improvement (Less than 5 visits)
*/
-- =================================================================================================================================
SELECT 
    d.id,
    d.full_name,
    COUNT(v.id) AS visit_count,
    CASE 
        WHEN COUNT(v.id)>=10 THEN  'Excellent'
        WHEN COUNT(v.id)>=5 THEN  'Good'
        ELSE  'Needs Improvement'
    END AS Remark
FROM doctor d
LEFT JOIN visit v
    ON d.id=v.doctor_id
GROUP BY d.id, d.full_name
ORDER BY visit_count DESC;


-- =================================================================================================================================
/* 12. Classify patients based on the number of visits.
        o Frequent Patient 
        o Regular Patient 
        o New Patient
*/
-- =================================================================================================================================
SELECT 
    p.id,
    p.full_name,
    COUNT(v.patient_id) AS visit_count,
    CASE 
        WHEN COUNT(v.patient_id)>=3 THEN  'Frequent Patient'
        WHEN COUNT(v.patient_id)>=2 THEN  'Regular Patient'
        ELSE  'New Patient'
    END AS Remark
FROM patitent p
LEFT JOIN visit v
    ON p.id=v.patient_id
GROUP BY p.id, p.full_name
ORDER BY visit_count DESC;

-- =================================================================================================================================
-- 13. Find the day when the clinic received the maximum number of patient visits.
-- =================================================================================================================================
SELECT 
    visit_date,
    COUNT(DISTINCT ) AS highest_patient_visits
FROM visit
GROUP BY visit_date
ORDER BY highest_patient_visits DESC
LIMIT 1;

-- =================================================================================================================================
-- 14. Find patients who visited the same doctor more than three times.
-- =================================================================================================================================
SELECT 
    p.id,
    p.full_name,
    v.doctor_id,
    COUNT(*) AS freq
FROM patitent p
INNER JOIN visit v
    ON p.id=v.patient_id
GROUP BY 
    p.id,
    p.full_name,
    v.doctor_id
HAVING COUNT(v.doctor_id) > 3;

-- =================================================================================================================================
/* 15. Build a single SQL query to generate the following KPIs:
        o Total Doctors 
        o Total Patients 
        o Total Visits 
        o Total Revenue 
        o Average Doctor Rating 
        o Average Revenue Per Visit 
        o Highest Revenue Doctor 
        o Most Visited Doctor
*/
-- =================================================================================================================================
SELECT 
    COUNT(DISTINCT d.id) AS Total_Doctors,
    COUNT(DISTINCT p.id) AS Total_Patients,
    COUNT(DISTINCT v.id) AS Total_Visits,
    COUNT(v.id)*d.price_per_visit AS revenue_per_doctor
FROM doctor d
LEFT JOIN visit v
    ON d.id=v.doctor_id
LEFT JOIN patitent p
    ON p.id=v.patient_id
GROUP BY d.id, d.price_per_visit

