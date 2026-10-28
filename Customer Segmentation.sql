USE DataDB

SELECT * FROM [Customer Segmentation analysis]

-- COUNT THE TOTAL NUMBER OF CUSTOMERS

SELECT COUNT(*) AS Total_Customers
FROM [Customer Segmentation analysis];

-- WHAT IS THE AVERAGE AGE OF CUSTOMERS IN THE DATASET?

SELECT ROUND( AVG(Age),1) AS Average_age
FROM [Customer Segmentation analysis];

-- HOW MANY MALE AND FEMALE CUSTOMERS ARE IN THE DATASET?

SELECT Gender, COUNT(*) AS Total_Customers
FROM [Customer Segmentation analysis]
GROUP BY Gender
ORDER BY Total_Customers DESC;

-- WHICH GENDER HAS THE HIGHER AVERAGE SPENDING SCORE

SELECT Gender,ROUND(AVG(Spending_Score_1_100),2) AS Averge_Spending_Score
FROM [Customer Segmentation analysis]
GROUP BY Gender
ORDER BY Averge_Spending_Score DESC;

-- AVERAGE SPENDNG BY PROFESSION

SELECT Profession, ROUND(AVG(Spending_Score_1_100),2) AS Averge_Spending_Score
FROM [Customer Segmentation analysis]
WHERE Profession IS NOT NULL
GROUP BY Profession
ORDER BY Averge_Spending_Score DESC;

-- AVERAGE INCOME BY PROFESSION

SELECT Profession, ROUND(AVG(Annual_Income),2) AS Average_Annual_Income
FROM [Customer Segmentation analysis]
WHERE Profession IS NOT NULL
GROUP BY Profession
ORDER BY Average_Annual_Income DESC;

-- WHICH AGE GROUP HAS THE HIGHEST SPENDING SCORE?

SELECT
CASE 
WHEN Age < 20 THEN 'Under 20'
WHEN Age BETWEEN 20 AND 29 THEN '20-29'
WHEN Age BETWEEN 30 AND 39 THEN '30-39'
WHEN Age BETWEEN 40 AND 49 THEN '40-49'
WHEN Age BETWEEN 50 AND 59 THEN '50-59'
ELSE '60 and above'
END AS Age_Group,
COUNT(*) AS Total_Customers,
ROUND(AVG(Spending_score_1_100),2) AS Average_Spending_score
FROM [Customer Segmentation analysis]
GROUP BY CASE 
WHEN Age < 20 THEN 'Under 20'
WHEN Age BETWEEN 20 AND 29 THEN '20-29'
WHEN Age BETWEEN 30 AND 39 THEN '30-39'
WHEN Age BETWEEN 40 AND 49 THEN '40-49'
WHEN Age BETWEEN 50 AND 59 THEN '50-59'
ELSE '60 and above'
END 
ORDER BY Average_Spending_score DESC;

-- COMPARE ANNUAL INCOME WITH SPENDING SCORE

SELECT 
CASE
WHEN Annual_Income < 4000 THEN 'Low Income'
WHEN Annual_Income BETWEEN 4000 AND 7000 THEN 'Medium Income'
ELSE 'High Income' 
END AS Income_Group,
COUNT(*) AS Total_Customers, 
ROUND(AVG(Spending_Score_1_100),2) AS Average_Spending_Score
FROM [Customer Segmentation analysis]
GROUP BY CASE
WHEN Annual_Income < 4000 THEN 'Low Income'
WHEN Annual_Income BETWEEN 4000 AND 7000 THEN 'Medium Income'
ELSE 'High Income' 
END
ORDER BY Average_Spending_Score DESC;

-- LET CHECK THE DATA QUALITY

SELECT
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_ID,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Missing_Gender,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Missing_Age,
    SUM(CASE WHEN Annual_Income IS NULL THEN 1 ELSE 0 END) AS Missing_Income,
    SUM(CASE WHEN Spending_Score_1_100 IS NULL THEN 1 ELSE 0 END) AS Missing_Spending,
    SUM(CASE WHEN Profession IS NULL THEN 1 ELSE 0 END) AS Missing_Profession
FROM [Customer Segmentation analysis]

-- CHECK DUPLICATE ID

SELECT CustomerID, COUNT(*) AS Number_Of_Records
FROM [Customer Segmentation analysis]
GROUP BY CustomerID
HAVING COUNT(*) > 1;