CREATE DATABASE whr;
USE whr;

DROP TABLE IF EXISTS country;
CREATE TABLE country (
	country_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50)
);

DROP TABLE IF EXISTS factors;
CREATE TABLE factors (
   country_id INT  ,
   year YEAR,
   family FLOAT,
   life_expectancy FLOAT,
   freedom FLOAT,
   government_corruption FLOAT,
   generosity FLOAT,
   dystopia_residual FLOAT,
   gdp_per_capita FLOAT,
   happiness_rank INT,
   happiness_score FLOAT,
   FOREIGN KEY (country_id) REFERENCES country(country_id)
);
   SELECT * FROM country;
   SELECT * FROM factors;

## which countries are Happier over time?
(
  SELECT c.country, f.year, f.happiness_score, f.life_expectancy
  FROM factors f
  JOIN country c ON f.country_id = c.country_id
  WHERE f.year = 2015
  ORDER BY f.happiness_score DESC
  LIMIT 5
)
UNION ALL
(
  SELECT c.country, f.year, f.happiness_score, f.life_expectancy
  FROM factors f
  JOIN country c ON f.country_id = c.country_id
  WHERE f.year = 2016
  ORDER BY f.happiness_score DESC
  LIMIT 5
)
UNION ALL
(
  SELECT c.country, f.year, f.happiness_score, f.life_expectancy
  FROM factors f
  JOIN country c ON f.country_id = c.country_id
  WHERE f.year = 2017
  ORDER BY f.happiness_score DESC
  LIMIT 5
)
UNION ALL
(
  SELECT c.country, f.year, f.happiness_score, f.life_expectancy
  FROM factors f
  JOIN country c ON f.country_id = c.country_id
  WHERE f.year = 2018
  ORDER BY f.happiness_score DESC
  LIMIT 5
)
UNION ALL
(
  SELECT c.country, f.year, f.happiness_score, f.life_expectancy
  FROM factors f
  JOIN country c ON f.country_id = c.country_id
  WHERE f.year = 2019
  ORDER BY f.happiness_score DESC
  LIMIT 5
)
;# The data is being exported to Queries/top_5_happy_countries_year.csv

## What are the factors most strongly correlated with happiness in a country?

-- finding averages of each column by year
-- average factors by year
SELECT year,
ROUND(AVG(gdp_per_capita),3) AS avg_gdp,
ROUND(AVG(family),3) AS avg_fam,
ROUND(AVG(life_expectancy),3) AS avg_le,
ROUND(AVG(freedom),3) AS avg_free,
ROUND(AVG(government_corruption),3) AS avg_govcorr,
ROUND(AVG(generosity),3) AS avg_gen
FROM FACTORS
GROUP BY year; #The data is being exported to Queries/average_factors_by_year.csv

## H1: Countries with higher life expectancy (proxy for healthcare quality) tend to enjoy greater FREEDOM
  SELECT  
    factors.year,  
    CASE  
        WHEN freedom >= (SELECT ROUND(AVG(freedom), 2) FROM factors WHERE factors.year = factors.year)  
        THEN 'High Freedom'  
        ELSE 'Low Freedom'  
    END AS freedom_group,  
    ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy  
FROM factors  
GROUP BY factors.year, freedom_group  
ORDER BY factors.year, avg_life_expectancy DESC; #The data is being exported to Queries/H1_5years.csv 

  SELECT 
    country.country,
    ROUND(AVG(life_expectancy),2) AS avg_life_expectancy,
    ROUND(AVG(freedom),2) AS avg_freedom
FROM factors
JOIN country ON factors.country_id = country.country_id
GROUP BY country.country
ORDER BY avg_life_expectancy DESC; #The data is being exported to Queries/H1.csv

## H2: more freedom in a country correlates positively with corruption perception, meaning personal and political freedoms significantly impact the transparacy of the government
SELECT
  c.country AS country_name,
  ROUND(AVG(f.government_corruption), 3) AS avg_corruption,
  ROUND(AVG(f.freedom), 3) AS avg_freedom
FROM factors f
JOIN country c ON f.country_id = c.country_id
GROUP BY country_name
ORDER BY avg_corruption DESC
LIMIT 20; # The data is being exported to Queries/corrp_freedom.csv

## H3: Lower government corruption levels are associated with higher happiness score, suggesting that transparency and good governance improve well-being
SELECT
	c.country AS country_name,
    ROUND(AVG(f.government_corruption), 3) AS avg_government_corruption,
    ROUND(AVG(f.happiness_score), 3) AS avg_happiness_score
FROM factors AS f
JOIN country AS c ON f.country_id = c.country_id
GROUP BY country_name
HAVING avg_government_corruption > 0.3 AND avg_happiness_score > 6
ORDER BY avg_happiness_score DESC; # The data is being exported to Queries/gov_corruption_vs_happiness.csv

## H4: Stronger family and community support is linked to higher GDP in low-income countries, suggesting that social cohesion can play a role in development

-- top 10 countries with high family score and low gdp
SELECT c.country,
ROUND(AVG(f.gdp_per_capita),3) AS avg_gdp,
ROUND(AVG(f.family),3) AS avg_fam
FROM FACTORS AS F
LEFT JOIN COUNTRY AS C
ON f.country_id = c.country_id
GROUP BY C.country
ORDER BY avg_fam DESC
LIMIT 10 ; # The data is being exported to Queries/GDP_FAMILY_by_country.csv

-- top 10 countries with low family score and high gdp
SELECT c.country,
ROUND(AVG(f.gdp_per_capita),3) AS avg_gdp,
ROUND(AVG(f.family),3) AS avg_fam
FROM FACTORS AS F
LEFT JOIN COUNTRY AS C
ON f.country_id = c.country_id
GROUP BY C.country
ORDER BY avg_fam asc
LIMIT 10 ;# The data is being exported to Queries/GDP_FAMILY_ASC_by_country.csv

## H5: A high GDP does not necessarily guarantee a high happiness score
SELECT 
    country.country, 
    ROUND(AVG(factors.happiness_score), 2) AS avg_happiness, 
    ROUND(AVG(factors.gdp_per_capita), 2) AS avg_gdp
FROM factors
JOIN country ON factors.country_id = country.country_id
WHERE 
    factors.happiness_score < (SELECT AVG(happiness_score) FROM factors) 
    AND factors.gdp_per_capita > (SELECT AVG(gdp_per_capita) FROM factors)
GROUP BY country.country
ORDER BY avg_gdp DESC; # The data is being exported to Queries/H5.csv

SELECT 
    country.country,
    ROUND(AVG(factors.happiness_score), 2) AS avg_happiness,
    ROUND(AVG(factors.gdp_per_capita), 2) AS avg_gdp
FROM 
    factors
JOIN 
    country ON factors.country_id = country.country_id
WHERE 
    factors.happiness_score > (SELECT ROUND(AVG(happiness_score), 2) FROM factors)
    AND factors.gdp_per_capita < (SELECT ROUND(AVG(gdp_per_capita), 2) FROM factors)
GROUP BY 
    country.country
ORDER BY 
    avg_happiness DESC; # The data is being exported to Queries/happinessVSGDP.csv