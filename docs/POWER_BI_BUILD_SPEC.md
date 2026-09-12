# Power BI Build Specification

## Relationships
- dim_patient[patient_key] 1:* fact_treatment_decision[patient_key]
- dim_regimen[regimen_key] 1:* fact_treatment_decision[regimen_key]
- dim_outcome[outcome_key] 1:* fact_treatment_decision[outcome_key]
- fact_treatment_decision[decision_id] 1:* fact_decision_drug[decision_id]
- dim_drug[drug_key] 1:* fact_decision_drug[drug_key]
- dim_drug[drug_key] 1:* fact_ddi[drugA_key]
- dim_drug[drug_key] 1:* fact_ddi[drugB_key]

For DDI visuals, use a role-playing copy of dim_drug for Drug B if needed; keep relationship paths unambiguous.

## Measures
```DAX
Patients = DISTINCTCOUNT(fact_treatment_decision[patient_key])
Treatment Decisions = COUNTROWS(fact_treatment_decision)
Unique Regimens = DISTINCTCOUNT(fact_treatment_decision[regimen_key])
Objective Response Rate = DIVIDE(CALCULATE([Treatment Decisions], fact_treatment_decision[label_objective_response] = 1), [Treatment Decisions])
Disease Control Rate = DIVIDE(CALCULATE([Treatment Decisions], fact_treatment_decision[label_disease_control] = 1), [Treatment Decisions])
Prior Progression Decisions = CALCULATE([Treatment Decisions], fact_treatment_decision[progression_before_decision] > 0)
Prior Platinum Exposure % = DIVIDE(CALCULATE([Treatment Decisions], fact_treatment_decision[prior_platinum_exposed] = 1), [Treatment Decisions])
Prior IO Exposure % = DIVIDE(CALCULATE([Treatment Decisions], fact_treatment_decision[prior_io_exposed] = 1), [Treatment Decisions])
Average Prior Lines = AVERAGE(fact_treatment_decision[n_prior_lines])
DDI Edges = COUNTROWS(fact_ddi)
Candidate Drug Links = COUNTROWS(fact_decision_drug)
```

## Pages

1. **Executive Overview** — KPIs, decisions by line, response distribution, regimen-class ranking, yearly trend and slicers.
2. **Patient & Disease Profile** — age, gender, smoking, initial stage, histology, comorbidity, EGFR and ALK status.
3. **Treatment Patterns** — regimen/class ranking, candidate-drug frequency, line × class matrix and prior exposure indicators.
4. **Response & Outcomes** — response distribution, response by line/stage/regimen class, molecular status and prior progression.
5. **Drug Interaction Analytics** — DDI connections by drug, interaction type and direction.
6. **Recommendation & Model Analytics** — recommendation ranks, Top-K metrics, baselines, rule quality and DDI prediction outputs.

## Design rule
Always show sample size with subgroup rates where possible. Avoid causal/efficacy/safety claims.
