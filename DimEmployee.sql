-- DimEmployee

SELECT
	DenverZoo.dbo.Employee.EmployeeID AS Employee_BK,
	DenverZoo.dbo.Employee.FirstName AS EmployeeFirstName,
	DenverZoo.dbo.Employee.LastName AS EmployeeLastName,
	DenverZoo.dbo.JobProfile.PositionName AS EmployeePositionName,
	DenverZoo.dbo.Department.DepartmentName AS EmployeeDepartment,
	DenverZoo.dbo.Employee.Gender AS EmployeeGender,
	DenverZoo.dbo.Employee.DateofBirth AS EmployeeDateofBirth,
	DATEDIFF(YY, DenverZoo.dbo.Employee.DateofBirth, GETDATE()) AS EmployeeAge,
	CASE WHEN IsSalaried = 1 THEN N'Salaried Position' ELSE N'Hourly Position' END AS EmployeeIsSalaried
FROM	
	DenverZoo.dbo.Employee
INNER JOIN
	DenverZoo.dbo.JobProfile
ON
	DenverZoo.dbo.Employee.JobID = DenverZoo.dbo.[JobProfile].JobID
LEFT JOIN
	DenverZoo.dbo.Department
ON
	DenverZoo.dbo.JobProfile.DepartmentID = DenverZoo.dbo.Department.DepartmentID