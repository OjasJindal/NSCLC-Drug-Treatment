# NSCLC Drug Treatment Analytics

End-to-end Data Analytics portfolio project built around an NSCLC drug-recommendation research capstone.

## 📊 Live Dashboard

**[View the Power BI Dashboard](https://app.powerbi.com/groups/me/reports/a0d0c846-52d4-4792-a003-127656f138d5/b45757afca32adcd895a?experience=power-bi&clientSideAuth=0)**

Interactive Power BI report with six pages:

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
NSCLC Capstone
      ↓
Data Audit & QA
      ↓
Relational Analytical Model
      ↓
Python EDA + Statistical Analysis
      ↓
SQL Analytics
      ↓
Power BI / DAX Dashboard
      ↓
Recommendation & Model Evaluation
```

## Repository structure

```text
.
├── analytics/        # Dashboard-ready aggregate analytical outputs
├── data/             # Public-safe dimensions and aggregate tables
├── docs/             # Findings and Power BI specification
├── model/            # Model evaluation outputs
├── scripts/          # Reproducible Python analysis
└── sql/              # Analyst query pack
```

## Key analytical questions

- How does treatment volume change across later treatment lines?
- Which regimen classes dominate treatment?
- How do observed outcomes vary by treatment line, stage and molecular status?
- Which candidate drugs are most frequently represented?
- Which drugs are structurally central in the DDI network?
- Where are data-quality and missingness limitations concentrated?
- How can model-derived interaction signals be surfaced without presenting them as confirmed clinical harm?

## Key findings

The later-line observational dataset contains 637 treatment decisions across 391 patients. The observed objective-response rate is 46.71% and observed disease-control rate is 70.49%. Treatment-line and molecular-status analyses are available as aggregate tables under `analytics/`.

These are descriptive associations, not causal treatment-effect estimates.

## Methodology guardrails

- `progression_before_decision` is count-like; a prior-progression decision is defined as **value > 0**, not by summing the field.
- Patient-level splitting is required for predictive evaluation to reduce leakage.
- Response-derived features such as `has_response` / `Resp_*` must be excluded when predicting the response label itself.
- Recommendation/model outputs are not causal or individualized clinical-benefit claims.
- Predicted DDI links are model/graph signals, not confirmed adverse events.

## Privacy

This public repository intentionally excludes raw patient-level healthcare records and other sensitive source tables. Public artifacts are aggregated, anonymized, or structural/model outputs suitable for portfolio demonstration.

## Tools

**Python · Pandas · SQL · Power BI · DAX · Knowledge Graphs · Drug Interaction Analytics · Statistical EDA**
