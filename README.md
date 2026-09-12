# NSCLC Drug Treatment Analytics

End-to-end Data Analytics portfolio project built around an NSCLC drug-recommendation research capstone.

## Dashboard

The Power BI report contains six pages:
1. Executive Overview
2. Patient & Disease Profile
3. Treatment Patterns
4. Response & Outcomes
5. Drug Interaction Analytics
6. Recommendation & Model Analytics

## Dataset profile

- 391 unique patients
- 637 treatment decision points
- 57 exact regimens
- 40 candidate drugs represented in decision records
- 493 DDI edges
- 6,290 knowledge-graph triples
- Treatment decisions spanning lines 2–4

## Architecture

```text
NSCLC Capstone → Data Audit → Analytical Data Model → Python EDA → SQL Analytics → Power BI
```

The project uses a treatment-decision fact grain with patient, regimen, outcome and drug dimensions.

## Analytical questions

- How does treatment volume change across later treatment lines?
- Which regimen classes dominate treatment?
- How do observed outcomes vary by treatment line, stage and molecular status?
- Which candidate drugs are most frequently represented?
- Which drugs are structurally central in the DDI network?
- Where are data-quality and missingness limitations concentrated?
- How can model-derived drug-interaction signals be surfaced without presenting them as confirmed clinical harm?

## Methodology notes

- `progression_before_decision` is treated as a count-like field; a prior-progression decision is defined as **value > 0**, not by summing the field.
- Patient-level splitting is required for predictive evaluation to reduce leakage.
- Response-derived features such as `has_response` / `Resp_*` must be excluded when predicting the response label itself.
- The recommendation extension is not a causal or individualized clinical-benefit claim.
- Predicted DDI links are analytical/model signals, not confirmed adverse events.

## Privacy

Raw patient-level healthcare data is intentionally **not published in this public repository**. Public artifacts should be anonymized/aggregated outputs, documentation and reproducible project materials.

## Tools

Python · Pandas · SQL · Power BI · DAX · Knowledge Graphs · Drug Interaction Analytics · Statistical EDA
