# Global Data Science Salary Analytics – MySQL Project

---

## 🏆 Project Overview

This project analyzes **global data science salaries** to identify trends across:

- Experience levels (Entry, Mid, Senior, Executive)  
- Job titles  
- Company size and location  
- Remote vs on-site work  

Built using **MySQL**, with **reporting views** and **dashboard-ready datasets**. The project demonstrates **advanced SQL skills**, **data modeling**, and **business insights extraction**.

---

## 🛠 Tech Stack

- **Database:** MySQL 8.0  
- **SQL Features:** Aggregations, Window Functions, Views, Indexing  
- **Visualization:** Power BI / Tableau / Excel  
- **Data Source:** Kaggle – Ruchi798 Data Science Job Salaries Dataset  

---

## 📂 Folder Structure


###Global-DS-Salary-Analytics/
      │
      ├── SQL/                     # All SQL scripts
      │   ├── 01_database_setup.sql          # Create DB & table
      │   ├── 02_load_data.sql               # CSV import scripts
      │   ├── 03_data_cleaning.sql           # Cleaning & transformations
      │   ├── 04_views_analysis.sql          # All reporting views
      │   ├── 05_advanced_queries.sql       # Window functions, percentiles
      │
      ├── Dashboard/               # Visualizations / screenshots
      │   ├── dashboard_overview.png
      │   ├── dashboard_experience.png
      │   ├── dashboard_country.png
      │
      ├── Diagrams/                # Data modeling / ER diagrams
      │   ├── EER_Diagram.png
      │
      ├── Data/                    # Optional, small sample CSV
      │   └── ds_salaries_sample.csv
      │
      ├── README.md                # Project overview, explanation, insights
      ├── Insights_Report.pdf      # Optional detailed analysis summary
      └── LICENSE                  # Open-source license (MIT recommended)



---

## 🔍 Key Insights

- **Senior-level roles earn ~40% more** than mid-level roles  
- **Fully remote roles pay slightly higher** than on-site roles  
- **US & European countries dominate** top-paying executive positions  
- **Large companies pay more** on average than small or medium companies  
- Salary trends **grew post-2021**, reflecting market demand  

---

## 🧠 Advanced SQL Used

- Aggregations with `GROUP BY`  
- **Window Functions:** `RANK()`, `PERCENT_RANK()`, `LAG()`  
- Views for reporting layer separation  
- Index optimization for performance  
- Derived metrics & KPIs for dashboarding  

---

## 📊 Dashboard Layout

### Page 1 — Executive Overview
- KPI cards: Avg Salary, Highest Salary, Total Roles, Total Countries  
- Salary trend over years (line chart)  
- Top paying countries (map / bar chart)  

### Page 2 — Workforce Analysis
- Salary by experience (bar chart)  
- Company size impact (bar chart)  
- Remote work impact (donut chart)  

### Page 3 — Advanced Analytics
- Top paying roles (bar chart)  
- Salary percentiles (top/bottom performers)  

---

## 📈 How to Run / Reproduce

1. Open **MySQL Workbench**  
2. Create database & table using `01_database_setup.sql`  
3. Load sample CSV with `02_load_data.sql`  
4. Run `03_data_cleaning.sql` to transform raw data  
5. Create views using `04_views_analysis.sql`  
6. Run advanced queries `05_advanced_queries.sql`  
7. Connect Power BI / Tableau to MySQL and use views for dashboards  

---

## 📌 Optional Tips

- Include **screenshots** of SQL queries and results in `Dashboard/`  
- Include **EER diagram** in `Diagrams/`  
- Provide **Insights_Report.pdf** summarizing key business takeaways  

---

## 💡 Why This Project Stands Out

- Shows **end-to-end capability**: raw data → database → analytical views → dashboards  
- Highlights **SQL expertise** (views, window functions, aggregation)  
- Demonstrates **business insights** & visualization skills  
- Makes your GitHub **portfolio-ready and recruiter-friendly**  

---

## 📚 References

- Kaggle Dataset: [Data Science Job Salaries](https://www.kaggle.com/datasets/ruchi798/data-science-job-salaries)  
- MySQL Workbench: [Official Documentation](https://dev.mysql.com/doc/workbench/en/)  
