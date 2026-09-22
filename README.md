# Healthcare Cost Analytics & Predictive Modelling

This project analyses healthcare insurance data to understand the main factors affecting hospitalisation costs and to build a machine learning model that can predict those costs.

I used Python for data cleaning, exploratory analysis, statistical testing and machine learning, PostgreSQL for SQL analysis, and Tableau to present the findings through an interactive dashboard.

## Project Overview

Healthcare costs are an important concern for both patients and insurance providers. Being able to understand and estimate future hospitalisation costs can help insurers with risk assessment, financial planning and decision-making.

The main objectives of this project were to:

- Clean and combine data from multiple sources
- Understand the factors associated with hospitalisation costs
- Perform exploratory data analysis
- Test important relationships using statistical methods
- Analyse the data using SQL
- Build and compare regression models
- Identify the most important cost predictors
- Present the findings using Tableau

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- SciPy
- Jupyter Notebook
- SQL
- PostgreSQL
- Tableau

## Dataset

The project uses three source datasets.

### Hospitalisation Details

Contains information such as:

- Customer ID
- Date of birth
- Number of children
- Hospitalisation charges
- Hospital tier
- City tier
- State ID

### Medical Examinations

Contains patient health information such as:

- BMI
- HbA1c
- Heart issues
- Transplant history
- Cancer history
- Number of major surgeries
- Smoking status

### Names

Contains:

- Customer ID
- Beneficiary name

The three datasets were connected using `Customer ID`.

After cleaning and merging the datasets, the final dataset contained **2,325 rows and 17 columns**.

## Data Cleaning and Preparation

I first checked the datasets for data quality issues before starting the analysis.

The main cleaning steps included:

- Identifying invalid `?` placeholder values
- Removing rows containing invalid values where appropriate
- Checking for missing values and duplicates
- Cleaning the `NumberOfMajorSurgeries` column
- Converting birth year, month and date into date information
- Calculating patient age
- Deriving gender from the patient's salutation
- Grouping State IDs into R1011, R1012, R1013 and Other
- Merging all three datasets using Customer ID

The final analysis-ready dataset contained **2,325 patient records**.

## Exploratory Data Analysis

I explored the data to understand how hospitalisation costs vary across different patient and hospital characteristics.

The analysis included:

- Distribution of hospitalisation costs
- Hospital tier comparison
- City tier comparison
- Gender-based analysis
- Smoking status analysis
- Age and cost analysis
- BMI and cost analysis
- Correlation analysis

Hospitalisation costs were strongly right-skewed, meaning that most patients had moderate costs while a smaller number had much higher costs.

BMI and Age showed the strongest linear relationships with charges among the numerical predictors, with correlations of approximately **0.35 and 0.30** respectively.

## Statistical Hypothesis Testing

I used statistical tests to check whether some of the patterns found during exploratory analysis were statistically significant.

### Hospital Tier and Hospitalisation Cost

An ANOVA test was performed.

**Result:**

- F-statistic: 493.99
- p-value: approximately 1.8 × 10^-179

The null hypothesis was rejected, showing a statistically significant difference in hospitalisation costs between hospital tiers.

### City Tier and Hospitalisation Cost

An ANOVA test was performed.

**Result:**

- F-statistic: 1.45
- p-value: 0.234

The null hypothesis was not rejected. The data did not provide evidence of a significant difference in hospitalisation costs across city tiers.

### Smoking Status and Hospitalisation Cost

An independent t-test was performed.

**Result:**

- t-statistic: 74.16
- p-value: approximately 0

The null hypothesis was rejected.

Smokers had an average hospitalisation cost of approximately **£32,867**, compared with approximately **£8,409** for non-smokers in this dataset.

### Smoking Status and Heart Issues

A Chi-square test was performed.

**Result:**

- Chi-square statistic: 0.086
- p-value: 0.769

The null hypothesis was not rejected. There was no statistically significant association between smoking status and heart issues in this dataset.

## SQL Analysis

I used PostgreSQL to answer additional business questions directly from the data.

The SQL analysis included:

- Joining hospitalisation and medical examination data
- Adding primary key constraints
- Analysing diabetic patients with heart issues
- Calculating average hospitalisation costs by hospital tier
- Calculating average costs by city tier
- Identifying patients with major surgery and cancer history
- Analysing Tier-1 hospital distribution across states

One of the SQL analyses found that patients who were diabetic and had heart issues had:

- Average hospitalisation cost: **£16,475.22**
- Average age: **53.3 years**
- Average number of children: **1.02**
- Average BMI: **31.37**

The analysis also identified **391 patients** who had undergone major surgery and had a history of cancer.

The complete SQL analysis is available in:

`healthcare_capstone.sql`

## Machine Learning

The machine learning objective was to predict hospitalisation cost.

The target variable was:

`charges`

The main predictors included:

- Age
- BMI
- HbA1c
- Number of children
- Number of major surgeries
- Smoking status
- Heart issues
- Transplant history
- Cancer history
- Hospital tier
- City tier
- Gender
- State group

Categorical variables were converted into dummy variables before modelling.

The data was divided into training and testing sets using an 80/20 split.

## Models Evaluated

Three main regression approaches were compared:

### Linear Regression

Used as the baseline regression model.

### Ridge Regression

Used to introduce L2 regularisation and reduce the risk of overfitting.

### Gradient Boosting Regression

Used to capture more complex and non-linear relationships between patient characteristics and hospitalisation costs.

## Model Performance

| Model | R² | RMSE |
| --- | ---: | ---: |
| Linear Regression | 0.840 | £4,771.45 |
| Ridge Regression (α = 1.0) | 0.840 | £4,771.42 |
| Gradient Boosting (Default) | 0.890 | £4,029.88 |
| Gradient Boosting (Reduced Features) | **0.890** | **£4,029.74** |
| Gradient Boosting (Tuned) | 0.886 | £4,038.02 |

The **Gradient Boosting model with reduced features** produced the strongest performance on the held-out test set.

It achieved an **R² of approximately 0.89**, meaning the model explained around 89% of the variation in hospitalisation costs in the test data.

The RMSE was approximately **£4,029.74**.

## Cross-Validation

Cross-validation was used to check how well the model generalised.

An initial cross-validation attempt without shuffling produced poor results because the source data was ordered by cost.

After introducing shuffled folds, the average cross-validation R² improved to approximately **0.86**.

This was an important part of the project because it showed how the way cross-validation folds are created can significantly affect model evaluation.

## Feature Importance

Feature importance from the Gradient Boosting model was used to understand which factors contributed most to cost prediction.

The three strongest predictors were:

| Feature | Importance |
| --- | ---: |
| Smoking Status | 75.6% |
| BMI | 12.1% |
| Age | 8.8% |

Smoking status was the strongest predictor by a large margin in this dataset.

BMI and Age were the next most important variables.

## Key Business Insights

The analysis produced several useful findings:

- Smoking status was strongly associated with higher hospitalisation costs in this dataset.
- Smokers had average costs of approximately £32,867 compared with £8,409 for non-smokers.
- Hospital tier showed a statistically significant relationship with hospitalisation cost.
- Tier 1 hospitals had a median cost of approximately £32,097 compared with £7,169 for Tier 2 and £10,677 for Tier 3.
- City tier did not show a statistically significant difference in hospitalisation costs.
- BMI and Age were important secondary predictors of hospitalisation cost.
- Gradient Boosting performed better than Linear and Ridge Regression on the held-out test data.

These results show statistical relationships within this dataset and should not be interpreted as evidence that any individual factor directly causes higher healthcare costs.

## Tableau Dashboard

I created an interactive Tableau dashboard to present the results in a format that can be easily understood by non-technical stakeholders.

The dashboard includes:

- Average hospitalisation cost by age category
- Average hospitalisation cost by city tier
- Average hospitalisation cost by cancer history
- Average hospitalisation cost by hospital tier
- Average hospitalisation cost by smoking status
- Gender filter
- Smoking status filter

The packaged Tableau workbook is available in:

`Healthcare Insurance Capstone.twbx`

## Repository Structure

```text
healthcare-cost-analytics-predictive-modelling/
│
├── dataset/
│   └── raw/
│       ├── Hospitalisation details.csv
│       ├── Medical Examinations.csv
│       └── Names.xlsx
│
├── Healthcare_Insurance_Analysis.ipynb
├── healthcare_capstone.sql
├── Healthcare Insurance Capstone.twbx
├── Healthcare_Insurance_Capstone_Presentation_1.pptx
└── README.md
```

## Key Skills Demonstrated

- Python
- Data cleaning and preprocessing
- Data integration
- Exploratory data analysis
- Statistical hypothesis testing
- Feature engineering
- Linear Regression
- Ridge Regression
- Gradient Boosting
- Cross-validation
- Hyperparameter tuning
- Model evaluation
- Feature importance analysis
- SQL
- PostgreSQL
- Tableau
- Data visualisation
- Business insight generation
- Data storytelling

## Future Improvements

The project could be extended by:

- Comparing additional regression models such as XGBoost
- Using SHAP to provide more detailed model explanations
- Deploying the prediction model through Streamlit or an API
- Adding automated data validation
- Adding model monitoring for future data

## Author

**Akash Ramesh Sujatha**

MSc Data Science & Analytics
