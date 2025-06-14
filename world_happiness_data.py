import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import os

# **1. Data cleaning**

df_2015 = pd.read_csv("Raw_Datasets/2015.csv")
#print(df_2015.head())
#print(df_2015.columns)
df_2015.columns = df_2015.columns.str.lower()
#print(df_2015.columns)
df_2015 = df_2015.rename(columns={
    "happiness rank" : "happiness_rank",
    "happiness score" : "happiness_score",
    "standard error": "standard_error",
    "economy (gdp per capita)" : "gdp_per_capita",
    "health (life expectancy)" : "life_expectancy",
    "trust (government corruption)": "government_corruption",
    "dystopia residual" : "dystopia_residual"
})

null_values_2015 = df_2015.isnull().sum()
#print(null_values_2015)
df_2015.head()

df_2016 = pd.read_csv("Raw_Datasets/2016.csv")
#print(df_2016.head())
#print(df_2016.columns)
df_2016 = df_2016.rename(columns={
    "Country" : "country",
    "Region" : "region",
    "Happiness Rank" : "happiness_rank",
    "Happiness Score" : "happiness_score",
    "Lower Confidence Interval" : "lower_confidence_interval",
    "Upper Confidence Interval" : "upper_confidence_interval",
    "Economy (GDP per Capita)" : "gdp_per_capita",
    "Family" : "family",
    "Health (Life Expectancy)" : "life_expectancy",
    "Freedom" : "freedom",
    "Trust (Government Corruption)": "government_corruption",
    "Generosity": "generosity",
    "Dystopia Residual" : "dystopia_residual"
})
null_values_2016 = df_2016.isnull().sum()
#print(null_values_2016)
df_2016.head()

df_2017 = pd.read_csv("Raw_Datasets/2017.csv")
#print(df_2017.head())
df_2017 = df_2017.rename(columns={
    "Country" : "country",
    "Happiness.Rank" : "happiness_rank",
    "Happiness.Score" : "happiness_score",
    "Whisker.high" : "whisker.high",
    "Whisker.low" : "whisker.low",
    "Economy..GDP.per.Capita." : "gdp_per_capita",
    "Family" : "family",
    "Health..Life.Expectancy." : "life_expectancy",
    "Freedom" : "freedom",
    "Trust..Government.Corruption.": "government_corruption",
    "Generosity": "generosity",
    "Dystopia.Residual" : "dystopia_residual"
})

null_values_2017 = df_2017.isnull().sum()
#print(null_values_2017)
df_2017.head()

df_2018 = pd.read_csv("Raw_Datasets/2018.csv")
#print(df_2018.head())
df_2018 = df_2018.rename(columns={
    "Country or region" : "country",
    "Overall rank" : "happiness_rank",
    "Score" : "happiness_score",
    "GDP per capita" : "gdp_per_capita",
    "Social support" : "family",
    "Healthy life expectancy" : "life_expectancy",
    "Freedom to make life choices" : "freedom",
    "Perceptions of corruption": "government_corruption",
    "Generosity": "generosity",
})

null_values_2018 = df_2018.isnull().sum()
#print(null_values_2018)
df_2018.head()

df_2019 = pd.read_csv("Raw_Datasets/2019.csv")
#print(df_2019.head())
df_2019 = df_2019.rename(columns={
    "Country or region" : "country",
    "Overall rank" : "happiness_rank",
    "Score" : "happiness_score",
    "GDP per capita" : "gdp_per_capita",
    "Social support" : "family",
    "Healthy life expectancy" : "life_expectancy",
    "Freedom to make life choices" : "freedom",
    "Perceptions of corruption": "government_corruption",
    "Generosity": "generosity",
})

null_values_2019 = df_2019.isnull().sum()
#print(null_values_2019)
df_2019.head()

# function to reorder the columns so that we concat everything will be in place
def reorder_columns(df, column_order):
    # Insures that every column exists (if there is something missing adds NaN
    for col in column_order:
        if col not in df.columns:
            df[col] = None  

    # Reorders the columns
    return df[column_order]

# Standard column order
standard_columns = [
    'country', 'happiness_rank', 'happiness_score',
    'gdp_per_capita', 'family', 'life_expectancy', 'freedom',
    'government_corruption', 'generosity', 'dystopia_residual', 'year'  # Include 'year' column
]

# List of DataFrames and respective years
dfs = [df_2015, df_2016, df_2017, df_2018, df_2019]
years = [2015, 2016, 2017, 2018, 2019]

# Loop to reorder columns and add the 'year' column
for df, year in zip(dfs, years):
    df["year"] = year  # Add year column
    df = reorder_columns(df, standard_columns)  # Ensure standardized column order


# **2.  Saving the 5 datasets as csv files**

# adding a new folder named Clean_Datasets
output_folder = "Clean_Datasets"
os.makedirs(output_folder, exist_ok=True)
dfs_by_year = {
    2015: df_2015,
    2016: df_2016,
    2017: df_2017,
    2018: df_2018,
    2019: df_2019
}

# Saves each dataset in to csv files in a specific folder
for year, df in dfs_by_year.items():
    output_path = os.path.join(output_folder, f"clean_{year}.csv")
    df.to_csv(output_path, index=False)
    #print(f"Saved: {output_path}")


# **3. Merging the datasets in one**

final_df = pd.concat([df_2015, df_2016, df_2017, df_2018, df_2019], ignore_index=True)

cols = final_df.columns.tolist()
cols.remove('year')
final_df = final_df[['year'] + cols]

final_df.to_csv("world_happyiness_5_years.csv", index=False)

final_df.head()

final_df[final_df['dystopia_residual'].isnull()]

df_countries = final_df[['country']].drop_duplicates().reset_index(drop=True)
df_countries['country_id'] = df_countries.index + 1  
final_df = final_df.merge(df_countries, on='country', how='left')
final_df['dystopia_residual'] = final_df['happiness_score'] - (
    final_df['gdp_per_capita'] +
    final_df['family'] +
    final_df['life_expectancy'] +
    final_df['freedom'] +
    final_df['government_corruption'] +
    final_df['generosity']
    
)
df_factors = final_df[[
    'year', 'family', 'life_expectancy', 'freedom',
    'government_corruption', 'generosity', 'dystopia_residual',
    'gdp_per_capita', 'happiness_rank', 'happiness_score', 'country_id'
]]
df_factors.to_csv("factors_ready.csv", index=False)
df_countries.to_csv("countries.csv", index=False)

