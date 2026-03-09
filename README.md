# 🏥 Hospital Readmission Risk Analysis — Diabetic Patients

<div align="center">

![Python](https://img.shields.io/badge/Python-3.10-blue?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.0-150458?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-1.24-013243?style=for-the-badge&logo=numpy&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-3.7-11557c?style=for-the-badge)
![Seaborn](https://img.shields.io/badge/Seaborn-0.12-4c9be8?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-Workbench-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

<div align="center">

### 🔑 Key Results at a Glance

| Metric | Value |
|---|---|
| 📋 Raw Dataset | 101,766 rows × 50 columns |
| 🧹 After Cleaning | 71,518 rows × 51 columns |
| 🎯 30-Day Readmission Rate | **7.1%** |
| ⚠️ High-Risk Patients Identified | **1,973** (3+ prior inpatient stays) |
| 🧪 A1C Testing Gap | Only **17%** of patients were tested |
| 🗄️ SQL Queries Written | **10** (Basic → Window Functions) |
| 📊 EDA Charts Produced | **13** visualisations |

</div>

---

## 📌 Problem Statement

Hospital readmissions within **30 days of discharge** are one of the most expensive and preventable problems in modern healthcare.
In the United States, they cost the healthcare system over **$26 billion every year**.

This project analyses **101,766 real diabetic patient records** collected from 130 US hospitals (1999–2008) to identify which patients are at the highest risk of being readmitted within 30 days — helping hospital administrators allocate resources more effectively and reduce preventable readmissions.

---

## 🎯 Objectives

- Understand raw data from scratch — no assumptions, pure exploration first
- Clean the data carefully with clear reasoning behind every decision
- Engineer new features that better capture patient risk
- Explore patterns through 13 visualisations (EDA)
- Run 10 SQL queries in MySQL Workbench — from basic to advanced
- Deliver 7 actionable business recommendations backed by data

---

## 📂 Dataset

| Detail | Info |
|---|---|
| Source | [Kaggle — Diabetic Patient Readmission Dataset](https://www.kaggle.com/datasets/brandao/diabetes) |
| Original Size | 101,766 rows × 50 columns |
| Time Period | 1999 – 2008 |
| Hospitals Covered | 130 US hospitals |
| Target Column | `readmitted` → `<30` (readmitted within 30 days), `>30`, `NO` |

> ⚠️ **Note:** The raw `diabetic_data.csv` is not included here due to file size.
> Download it from the Kaggle link above and place it in the root folder before running the notebook.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| 🐍 Python 3 | Core programming language |
| 🐼 Pandas | Data loading, cleaning and manipulation |
| 🔢 NumPy | Numerical operations and array handling |
| 📊 Matplotlib | Base chart plotting |
| 🎨 Seaborn | Statistical visualisations |
| 🗄️ MySQL Workbench | SQL database creation and querying |
| 📓 Jupyter Notebook | Interactive code, charts and documentation |

---

## 📁 Repository Structure

```
hospital-readmission-analysis/
│
├── 📓 Hospital_Readmission.ipynb       ← Main notebook (complete analysis)
├── 🗄️  diabetic_data_query.sql          ← All 10 MySQL queries
├── 📄 diabetic_data_cleaned.csv        ← Cleaned dataset (import into MySQL)
├── 📄 diabetic_data.csv                ← Raw dataset (download from Kaggle)
├── 📘 README.md                        ← This file
│
└── 📁 images/
    ├── 01_missing_values.png
    ├── 02_readmission_distribution.png
    ├── 03_age_group_count.png
    ├── 04_age_group_rate.png
    ├── 05_gender_readmission.png
    ├── 06_a1c_readmission.png
    ├── 07_stay_vs_readmission.png
    ├── 08_insulin_readmission.png
    ├── 09_prior_visits_readmission.png
    ├── 10_diagnoses_readmission.png
    ├── 11_race_readmission.png
    ├── 12_correlation_heatmap.png
    └── 13_eda_summary_grid.png
```

---

## 🔄 Methodology

```
diabetic_data.csv  (raw)
        │
        ▼
┌──────────────────────────┐
│  1. Data Loading         │  shape, dtypes, describe, target column check
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  2. Data Exploration     │  find hidden '?' values, duplicates, distributions
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  3. Data Cleaning        │  replace '?'→NaN, drop columns, remove dupes, impute
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  4. Feature Engineering  │  5 new columns created from existing data
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  5. Export Cleaned CSV   │  diabetic_data_cleaned.csv
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  6. EDA  (13 charts)     │  age, gender, A1C, insulin, race, heatmap, grid
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  7. SQL — MySQL          │  10 queries, basic → window functions
└──────────┬───────────────┘
           ▼
┌──────────────────────────┐
│  8. Insights             │  7 actionable business recommendations
└──────────────────────────┘
```

---

## 🧹 Data Cleaning Decisions

> In healthcare data, a missing value does not always mean "unknown" — sometimes it means the test was never ordered.
> Every decision below has a clinical reasoning behind it.

| Column | Issue | Decision | Reason |
|---|---|---|---|
| `weight` | 97% missing | ❌ Dropped | Too sparse — only 3% of patients had weight recorded |
| `medical_specialty` | 49% missing | ❌ Dropped | Nearly half unknown — would mislead any grouping |
| `payer_code` | 40% missing | ❌ Dropped | Insurance type — not clinically relevant to readmission |
| `encounter_id` | Just an ID | ❌ Dropped | Row label only — not a meaningful feature |
| `'?'` characters | Used instead of NaN | ✅ Replaced | Converted to proper `NaN` so pandas can handle them |
| `race`, `diag_1/2/3` | Small % missing | ✅ Imputed | Filled with **mode** (most common value) |
| Duplicate visits | ~30K rows | ✅ Removed | Kept first visit per patient — prevents data leakage |

**Before cleaning:** 101,766 rows × 50 columns
**After cleaning:** 71,518 rows × 51 columns (including 5 new engineered features)

---

## ⚙️ Feature Engineering

Five new columns were built from the raw data to better capture patient risk:

| Feature | How It Was Built | Why It Matters |
|---|---|---|
| `readmitted_30` | 1 if `readmitted == '<30'` else 0 | Binary target — 7.1% of patients qualify |
| `total_visits` | outpatient + inpatient + emergency | Full hospital utilisation history in one number |
| `num_medications_changed` | Count of drugs with 'Up' or 'Down' | More changes = patient was clinically unstable |
| `age_numeric` | Age bracket → midpoint (e.g. `[60-70)` → 65) | Enables numeric correlations with age |
| `comorbidity_score` | Count of non-null diag_1 / diag_2 / diag_3 | More diagnoses = more simultaneous conditions |

---

## 📊 EDA — Charts & Findings

### Readmission Distribution
- **67%** not readmitted · **26%** readmitted after 30 days · **7.1%** readmitted within 30 days
- Dataset is **class-imbalanced** — important to account for in any future modelling

### Age Group Analysis
- Readmission rates are fairly **consistent across age groups** (~8–10%)
- Middle-aged (40–60) patients show rates as high as elderly patients — likely due to missed follow-ups and medication affordability

### HbA1c (A1C) Test Results
- Only **17% of patients** had the A1C test done — a major clinical gap
- Patients with `>8` result had **noticeably higher readmission rates**
- Poorly controlled blood sugar directly drives early readmission

### Hospital Stay Length — Box Plot
- Readmitted patients had a **slightly longer** average stay
- Early discharge is **not** the issue — what happens *after* discharge is the real problem

### Insulin Dose Status
- Patients with dose **increased ('Up')** had the highest readmission rate
- An increase signals the previous treatment was **not controlling blood sugar**

### Prior Inpatient Visits — Line Chart
- Readmission rate **rises sharply** with more prior hospital admissions
- **1,973 patients** with 3+ prior stays identified as chronic, high-risk group

### Correlation Heatmap
- `number_inpatient` → **strongest correlation** with `readmitted_30`
- `num_medications` and `number_diagnoses` → moderate positive correlation
- `time_in_hospital` → weak correlation — longer stays don't prevent return

---

## 🗄️ SQL Analysis (MySQL Workbench)

All 10 queries are in `diabetic_data_query.sql`.

| # | Query | Concepts Used |
|---|---|---|
| Q1 | Count of readmission categories | `GROUP BY`, `ORDER BY` |
| Q2 | Overall 30-day readmission rate | `AVG`, `ROUND` |
| Q3 | Readmission rate by age group | `GROUP BY`, `HAVING` |
| Q4 | Top 10 diagnoses by readmission rate | `GROUP BY`, `HAVING`, `LIMIT` |
| Q5 | Average hospital stay by discharge type | `GROUP BY`, `AVG` |
| Q6 | Count high-risk patients (3+ stays) | **Subquery** |
| Q7 | Patient profile by readmission status | Multiple `AVG`, `GROUP BY` |
| Q8 | Readmission rate by insulin status | `GROUP BY`, `ORDER BY` |
| Q9 | Race equity check | `GROUP BY`, `SUM`, `AVG` |
| Q10 | Rank admission types by risk | **Window Function** `RANK() OVER` |

---

## 💡 Key Business Insights & Recommendations

### 1️⃣ Readmission Rate Is Small but the Cost Is Enormous
7.1% sounds small — but across 100K+ admissions that is thousands of preventable hospitalisations.
**Action:** Even a 1% reduction saves millions in healthcare costs annually.

### 2️⃣ Prior Admissions Are the Strongest Predictor
Patients with 3+ prior inpatient visits are significantly more likely to return within 30 days.
**Action:** Build a **high-risk patient registry**. Assign dedicated care coordinators to the 1,973 flagged patients.

### 3️⃣ HbA1c Testing Is Critically Underused
Only 17% of diabetic patients had the A1C test done during their admission — a huge missed opportunity.
**Action:** Make **A1C testing mandatory** for all diabetic admissions. It directly measures blood sugar control.

### 4️⃣ Insulin Dose Increases Are an Early Warning Sign
Patients whose insulin was increased ('Up') had the highest readmission rate of any group.
**Action:** Flag all insulin dose increases at discharge. Schedule a **mandatory phone follow-up within 7 days**.

### 5️⃣ The Gap Is in Post-Discharge Care — Not Hospital Stays
Readmitted patients stayed slightly longer — so discharge timing is not the issue.
**Action:** Invest in structured discharge plans: booked follow-ups, medication confirmations, and transport support.

### 6️⃣ Multiple Medication Changes Signal Instability
Patients with 1–2 medication dose changes had above-average readmission rates.
**Action:** Every patient leaving with changed medications should receive **pharmacist counselling before discharge**.

### 7️⃣ Healthcare Equity Gaps Are Visible in the Data
Readmission rates differ across racial groups — indicating disparities in post-discharge access and affordability.
**Action:** Target **community health worker programmes** at underserved groups with disproportionately high rates.

---

## ⚠️ Limitations

1. `weight` (97% missing) — BMI is a key diabetes risk factor but could not be used
2. `medical_specialty` (49% missing) — Treating doctor's specialty could have added clinical context
3. ICD-9 codes were not mapped to clinical categories (cardiovascular, respiratory, etc.)
4. Dataset is from 1999–2008 — treatment protocols have changed significantly
5. Exploratory analysis only — no predictive model was built (next step: Logistic Regression / Random Forest)
6. Class imbalance (7.1% target) — future model would need SMOTE or class weighting

---

## 🚀 How to Run This Project

### 1 — Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/hospital-readmission-analysis.git
cd hospital-readmission-analysis
```

### 2 — Download the raw dataset
Visit https://www.kaggle.com/datasets/brandao/diabetes, download `diabetic_data.csv` and place it in the root folder.

### 3 — Install dependencies
```bash
pip install pandas numpy matplotlib seaborn jupyter
```

### 4 — Run the notebook
```bash
jupyter notebook Hospital_Readmission.ipynb
```
Run all cells top to bottom. The cleaned CSV is generated automatically.

### 5 — Run SQL in MySQL Workbench
```
1. Open MySQL Workbench
2. Run CREATE DATABASE and CREATE TABLE from diabetic_data_query.sql
3. Right-click 'diabetic_patients' → Table Data Import Wizard
4. Import diabetic_data_cleaned.csv
5. Run the 10 queries from diabetic_data_query.sql
```

---

## 🔮 Future Improvements

- [ ] Map ICD-9 diagnosis codes to clinical categories
- [ ] Build a Logistic Regression baseline model
- [ ] Handle class imbalance with SMOTE or `class_weight='balanced'`
- [ ] Add BMI data from an external source
- [ ] Build an interactive Power BI or Streamlit dashboard
- [ ] Validate findings using more recent hospital data (post-2010)

---

## 📦 Requirements

```
python >= 3.8
pandas
numpy
matplotlib
seaborn
jupyter
```

---

## 📬 Connect With Me

- 💼 **LinkedIn:** [your LinkedIn URL]
- 🐙 **GitHub:** [your GitHub profile URL]
- 📧 **Email:** [your email]

---

## 📄 License

This project is open source under the [MIT License](LICENSE).

---

<div align="center">
⭐ If this project helped you, please give it a star — it helps others find it too! ⭐
</div>
