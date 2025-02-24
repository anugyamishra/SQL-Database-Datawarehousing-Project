-- DimCustomer

SELECT
	DenverZoo.dbo.Customer.CustomerID AS Customer_BK,
	DenverZoo.dbo.Customer.FirstName AS CustomerFirstName,
	DenverZoo.dbo.Customer.LastName AS CustomerLastName,
	DenverZoo.dbo.Customer.DateofBirth AS CustomerDateofBirth,
	DenverZoo.dbo.Customer.IsMember AS CustomerIsMember,
	DATEDIFF(YY, DenverZoo.dbo.Customer.DateofBirth, GETDATE()) AS CustomerAge,
	CASE 
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 1901 AND 1927 THEN N'Greatest Generation'
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 1928 AND 1945 THEN N'Silent Genearation'
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 1946 AND 1964 THEN N'Boomer'
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 1965 AND 1979 THEN N'Gen X'
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 1980 AND 1996 THEN N'Millenial'
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 1997 AND 2012 THEN N'Gen Z'
	WHEN YEAR(DenverZoo.dbo.Customer.DateofBirth) BETWEEN 2013 AND 2025 THEN N'Gen Alpha'
	END AS CustomerAgeGroup,
	CASE WHEN IsMember = 1 THEN N'Member' ELSE N'Not a Member' END AS CustomerIsMember
FROM	
	DenverZoo.dbo.Customer