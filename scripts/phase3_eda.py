import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import chi2_contingency

fact = pd.read_csv("data/fact_treatment_decision.csv")
patients = pd.read_csv("data/dim_patient.csv")
regimens = pd.read_csv("data/dim_regimen.csv")
drugs = pd.read_csv("data/dim_drug.csv")
ddi = pd.read_csv("data/fact_ddi.csv")
bridge = pd.read_csv("data/fact_decision_drug.csv")

x = fact.merge(patients, on="patient_key").merge(regimens, on="regimen_key")

print(x.groupby("decision_line").agg(
    decisions=("decision_id","count"),
    patients=("patient_key","nunique"),
    objective_response_pct=("label_objective_response", lambda s: 100*s.mean()),
    disease_control_pct=("label_disease_control", lambda s: 100*s.mean())
))

print(x["candidate_regimen_class"].value_counts())
print(bridge.merge(drugs,on="drug_key")["drug_name"].value_counts().head(15))

for a in ["decision_line","stage_initial","candidate_regimen_class","smoking","egfr_status","alk_status"]:
    tab = pd.crosstab(x[a], x["resp_code"])
    if tab.shape[0] > 1 and tab.shape[1] > 1:
        print(a, "chi-square p =", chi2_contingency(tab)[1])
