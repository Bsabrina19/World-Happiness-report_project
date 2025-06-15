# 😀 **Happiness Analysis Project**  

## 📌 **Project Overview**  
This project explores **global happiness trends** from 2015 to 2019, using **data analysis, visualization, and SQL-based queries** to examine socio-economic factors influencing well-being. It investigates correlations between happiness scores and elements such as **GDP per capita, life expectancy, freedom, and government transparency**.  

## 📂 **Datasets Used**  
- **World Happiness Report (2015-2019)**  
- **Structured MySQL Database (`whr`)**  

## ⚙ **Tech Stack**  
- Python 🐍  
- Pandas 📊  
- NumPy 🔢  
- Matplotlib 📈  
- Seaborn 🎨  
- MySQL 🗄️  

## 🏗 **Project Structure**  
### **1️⃣ Data Cleaning & Standardization (Python)**  
✅ **Dataset Loading & Preparation**  
- Import **CSV files** for happiness metrics from 2015 to 2019  

✅ **Data Standardization**  
- Unify column names across years  
- Fill **missing values** where necessary  

### **2️⃣ Happiness Analysis & Trends**  
✅ **Yearly Comparisons**  
- Track **top 5 happiest countries** over time  
- Identify **happiness score fluctuations**   

### **3️⃣ Hypothesis Testing**  
✅ **H1: Countries with higher life expectancy tend to enjoy greater freedom**  
✅ **H2: More freedom in a country correlates positively with corruption perception**  
✅ **H3: Lower government corruption levels are associated with higher happiness scores**  
✅ **H4: Stronger family and community support is linked to higher GDP in low-income countries**  
✅ **H5: A high GDP does not necessarily guarantee a high happiness score**  

### **4️⃣ Visualizations & Reporting**  
✅ **Charts & Graphs**  
- **Line plots** to track happiness over time  
- **Bar charts** comparing socio-economic factors  
- **Scatter plots** for hypothesis testing  

✅ **Export & Data Storage**  
- Save **processed datasets** as CSV for further analysis  

---

## 🗄️ **Database Structure & SQL Queries**  
This project includes a **structured SQL database** (`whr`) to manage happiness-related data across multiple years.  

### **📌 Database Schema**  
The database consists of **two tables**:  
- **`country`**: Stores country names with unique identifiers.  
- **`factors`**: Contains yearly happiness-related indicators such as GDP per capita, life expectancy, freedom, and corruption levels.  

### **📌 Key SQL Queries**  
✅ **Which countries are happiest over time?**  
Extracts the **top 5 happiest countries** per year based on happiness score.  

✅ **Which socio-economic factors correlate with happiness?**  
Computes **average GDP, family support, freedom, and transparency per year**.  

✅ **Hypothesis Testing (SQL-based validation)**  
- **H1:** Higher life expectancy correlates with **greater freedom**.  
- **H2:** Countries with more freedom tend to have **lower corruption perception**.  
- **H3:** Government transparency improves **overall happiness**.  
- **H4:** Strong family/community support **impacts GDP in low-income countries**.  
- **H5:** A high GDP **does not guarantee a high happiness score**.  

### **📌 Exported Data**  
All processed queries are **exported to CSV files** in the `/Queries` folder for further analysis.  
Examples:  
- `Queries/top_5_happy_countries_year.csv` (Happiest countries per year)  
- `Queries/average_factors_by_year.csv` (Average socio-economic indicators per year)  

## 📚 Resources & References  
This project leverages various datasets, reports, and documentation for analysis.  

### **📌 Data Sources**  
- [World Happiness Report](https://worldhappiness.report/)
- [World Happiness Report:DATA](https://www.kaggle.com/datasets/unsdsn/world-happiness)  
- [Pandas Documentation](https://pandas.pydata.org/docs/)  
- [Matplotlib Guide](https://matplotlib.org/stable/contents.html)  
- [Seaborn Official Documentation](https://seaborn.pydata.org/)  
- [MySQL Documentation](https://dev.mysql.com/doc/)   
- [Presentation link](https://www.canva.com/design/DAGpSwS4j6g/0RX-Z-UFU15TJTi8xDd5Gg/edit)

## 🏁 **How to Run the Project (Python & SQL)**  
### **Python Analysis**  
1️⃣ Install dependencies:  
```bash  
pip install pandas numpy seaborn matplotlib  