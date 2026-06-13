USE churn_analysis;
CREATE TABLE telecom_churn(
customerID VARCHAR(50),
gender VARCHAR(20),
SeniorCitizen INT,
Partner VARCHAR(10),
Dependents VARCHAR(10),
tenure INT,
PhoneService VARCHAR(10),
MultipleLines VARCHAR(50),
InternetService VARCHAR(50),
OnlineSecurity VARCHAR(50),
OnlineBackup VARCHAR(50),
DeviceProtection VARCHAR(50),
TechSupport VARCHAR(50),
StreamingTV VARCHAR(50),
StreamingMovies VARCHAR(50),
Contract VARCHAR(50),
PaperlessBilling VARCHAR(10),
PaymentMethod VARCHAR(100),
MonthlyCharges DECIMAL(10,2),
TotalCharges DECIMAL(10,2),
Churn VARCHAR(10)
);
SELECT COUNT(*)
FROM telecom_churn;
-- first 10 rows
SELECT *
FROM telecom_churn
LIMIT 10;
-- checking table structure
DESCRIBE telecom_churn;
-- Total Customers
SELECT COUNT(*) AS Total_Customers
FROM telecom_churn;
-- Churn rate

SELECT
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
*100.0/COUNT(*),
2
) AS Churn_Rate
FROM telecom_churn;

-- Revenue Lost

SELECT
ROUND(SUM(MonthlyCharges),2)
AS Revenue_Lost
FROM telecom_churn
WHERE Churn='Yes';

-- Churn by Contract

SELECT
Contract,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY Contract;

-- Churn by Payment Method

SELECT
PaymentMethod,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY PaymentMethod
ORDER BY Churned DESC;

-- Customer Segmentation

SELECT
CASE
WHEN tenure < 12
THEN 'New Customer'

WHEN tenure BETWEEN 12 AND 36
THEN 'Mid-Term Customer'

ELSE 'Loyal Customer'
END AS Customer_Segment,

COUNT(*) AS Total_Customers,

SUM(
CASE
WHEN Churn='Yes'
THEN 1
ELSE 0
END
) AS Churned_Customers

FROM telecom_churn

GROUP BY Customer_Segment;

-- Top Churn Drivers

SELECT
Contract,
InternetService,
PaymentMethod,

COUNT(*) AS Customers,

SUM(
CASE
WHEN Churn='Yes'
THEN 1
ELSE 0
END
) AS Churned

FROM telecom_churn

GROUP BY
Contract,
InternetService,
PaymentMethod

ORDER BY Churned DESC;


-- Gender wise Churn Analysis

SELECT
gender,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),
2
) AS Churn_Rate
FROM telecom_churn
GROUP BY gender;

-- Senior Churn Analysis

SELECT
SeniorCitizen,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY SeniorCitizen;

-- partner VS churn

SELECT
Partner,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY Partner;

-- Dependents VS Churn

SELECT
Dependents,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY Dependents;

-- Churn by Internet Service

SELECT
InternetService,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),
2
) AS Churn_Rate
FROM telecom_churn
GROUP BY InternetService;

-- Tech Support Impact on Churn

SELECT
TechSupport,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY TechSupport;

-- Online Security Impact

SELECT
OnlineSecurity,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY OnlineSecurity;

-- Average Monthly Analysis

SELECT
Churn,
ROUND(AVG(MonthlyCharges),2) AS Avg_Monthly_Charges
FROM telecom_churn
GROUP BY Churn;

-- Average Tenure by Churn

SELECT
Churn,
ROUND(AVG(tenure),2) AS Avg_Tenure
FROM telecom_churn
GROUP BY Churn;

-- Revenue by Contract

SELECT
Contract,
ROUND(SUM(MonthlyCharges),2) AS Revenue
FROM telecom_churn
GROUP BY Contract
ORDER BY Revenue DESC;

-- Top Revenue Generating Customers

SELECT
customerID,
MonthlyCharges,
Contract
FROM telecom_churn
ORDER BY MonthlyCharges DESC
LIMIT 20;

-- Revenue Lost by Contract Type

SELECT
Contract,
ROUND(SUM(MonthlyCharges),2) AS Revenue_Lost
FROM telecom_churn
WHERE Churn='Yes'
GROUP BY Contract;

-- Revenue Lost by Payment Method

SELECT
PaymentMethod,
ROUND(SUM(MonthlyCharges),2) AS Revenue_Lost
FROM telecom_churn
WHERE Churn='Yes'
GROUP BY PaymentMethod
ORDER BY Revenue_Lost DESC;

-- High-Risk Customer Segment

SELECT
CASE
WHEN tenure < 12 THEN 'New'
WHEN tenure BETWEEN 12 AND 36 THEN 'Mid-Term'
ELSE 'Loyal'
END AS Segment,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY Segment;

-- Month-to-Month Contract Churn
SELECT
COUNT(*) AS Churned_Customers
FROM telecom_churn
WHERE Contract='Month-to-month'
AND Churn='Yes';

-- Paperless Billing Impact

SELECT
PaperlessBilling,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY PaperlessBilling;

-- Multiple Lines Analysis
SELECT
MultipleLines,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY MultipleLines;

-- Streaming Services Impact

SELECT
StreamingTV,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM telecom_churn
GROUP BY StreamingTV;

-- Executive Summary Query
SELECT
COUNT(*) AS Total_Customers,

SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
AS Churned_Customers,

ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
*100/COUNT(*),
2
) AS Churn_Rate,

ROUND(SUM(MonthlyCharges),2)
AS Total_Revenue

FROM telecom_churn;


SHOW VARIABLES LIKE 'port';


