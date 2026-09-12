-- NSCLC Drug Analytics — Analyst Query Pack

SELECT COUNT(*) AS decisions,
       COUNT(DISTINCT patient_key) AS patients,
       COUNT(DISTINCT regimen_key) AS regimens,
       ROUND(100.0*AVG(label_objective_response),2) AS objective_response_pct,
       ROUND(100.0*AVG(label_disease_control),2) AS disease_control_pct
FROM fact_treatment_decision;

SELECT decision_line, COUNT(*) AS decisions,
       COUNT(DISTINCT patient_key) AS patients,
       ROUND(100.0*AVG(label_objective_response),2) AS objective_response_pct,
       ROUND(100.0*AVG(label_disease_control),2) AS disease_control_pct
FROM fact_treatment_decision
GROUP BY decision_line ORDER BY decision_line;

SELECT r.regimen_name, r.regimen_class, COUNT(*) AS decisions,
       COUNT(DISTINCT f.patient_key) AS patients,
       ROUND(100.0*AVG(f.label_disease_control),2) AS disease_control_pct
FROM fact_treatment_decision f
JOIN dim_regimen r USING(regimen_key)
GROUP BY r.regimen_name, r.regimen_class
ORDER BY decisions DESC;

SELECT p.stage_initial, COUNT(*) AS decisions,
       COUNT(DISTINCT f.patient_key) AS patients,
       ROUND(100.0*AVG(f.label_objective_response),2) AS objective_response_pct
FROM fact_treatment_decision f
JOIN dim_patient p USING(patient_key)
GROUP BY p.stage_initial ORDER BY decisions DESC;

WITH seq AS (
  SELECT f.*,
         LAG(regimen_key) OVER(
           PARTITION BY patient_key
           ORDER BY decision_line, t_decision, decision_id
         ) AS previous_regimen_key
  FROM fact_treatment_decision f
)
SELECT patient_key, decision_line, regimen_key, previous_regimen_key
FROM seq
WHERE previous_regimen_key IS NOT NULL;

WITH edge_ends AS (
  SELECT drugA_key AS drug_key FROM fact_ddi
  UNION ALL
  SELECT drugB_key AS drug_key FROM fact_ddi
)
SELECT d.drug_name, COUNT(*) AS ddi_connections
FROM edge_ends e JOIN dim_drug d USING(drug_key)
GROUP BY d.drug_name ORDER BY ddi_connections DESC;

SELECT CASE WHEN progression_before_decision > 0
            THEN 'Prior progression'
            ELSE 'No recorded prior progression' END AS cohort,
       COUNT(*) AS decisions,
       ROUND(100.0*AVG(label_disease_control),2) AS disease_control_pct
FROM fact_treatment_decision
GROUP BY 1;
