SELECT *
FROM crash_data$


-- FIRST we replace the necessary blanks in the data given 

UPDATE crash_data$
SET [Road Feature] = 'NO SPECIAL FEATURE' 
WHERE [Road Feature] IS NULL;


SELECT [Road Feature]
FROM crash_data$
WHERE [Road Feature] IS NULL

--Total injuries in accident Versus the total accidents
SELECT COUNT( Injuries) AS total_accidents,
	   SUM(CASE WHEN Injuries = 'Yes' THEN 1 ELSE 0 END  ) AS total_injuries
FROM crash_data$
ORDER BY 1


--Total accidents with the respect to top 10 vehicles
SELECT TOP 10 [Vehicle 1] 
      ,COUNT ([Vehicle 1]) + COUNT ([Vehicle 2]) +
	  COUNT([Vehicle 3]) + COUNT ([Vehicle 4]) + COUNT ([Vehicle 5]) AS vehicles
FROM crash_data$
WHERE [Vehicle 1] IS NOT NULL
GROUP BY [Vehicle 1]
ORDER by 2 DESC

--How does the road type influence accidents
-- ROAD CONDITIONS

SELECT    [Road Conditions],
	   [Road Surface],
       COUNT([Road Conditions]) AS Accidents_per_conditions
	  -- ,COUNT ([Road Surface]) AS Accidents_per_surface
FROM crash_data$
WHERE [Road Conditions] IS NOT NULL AND [Road Surface] IS NOT NULL
GROUP BY [Road Conditions] , [Road Surface]
ORDER BY Accidents_per_conditions--Accidents_per_surface ASC



-- Total accidents by Road surface
SELECT [Road Surface],
       COUNT ([Road Surface]) AS Accident_per_surface
FROM crash_data$
WHERE [Road Surface] IS NOT NULL
GROUP BY [Road Surface]


--RELATION between accidents by day and night

SELECT [Light Condition] 
       ,COUNT([Light Condition]) AS  total_accidents
	   --,COUNT ([Weather])
FROM crash_data$
WHERE [Light Condition] IS NOT NULL
GROUP BY [Light Condition]
ORDER BY 2 DESC

--Which day had the most accidents
SELECT DATENAME(DW,TA_Date) AS day_of_week
	  ,COUNT(TA_Date) AS total_accidents
FROM crash_data$
GROUP BY   DATENAME(DW,TA_Date) 
ORDER BY 1 DESC


-- how road feature influences accidents
SELECT [Road Feature],
      COUNT([Road Feature]) 
FROM [dbo].[crash_data$]
GROUP BY [Road Feature]


--WHICH ROADS HAVE MOST ACCIDENTS
SELECT [Road Class]
       ,count([Road Class]) AS total_accidents
FROM crash_data$
WHERE  [Road Class] IS NOT NULL
GROUP BY [Road Class]

--Accidents that happen in different work areas
SELECT [Work Area],
      COUNT([Work Area])AS total_accidents
FROM [dbo].[crash_data$]
WHERE [Work Area] IS NOT NULL
GROUP BY [Work Area]


--DOES WEATHER INFLUENCE NUMBER OF ACCIDENTS
SELECT [Weather],
      COUNT([Weather]) AS total_accidents
FROM crash_data$
WHERE [Weather] IS NOT NULL
GROUP BY [Weather]

