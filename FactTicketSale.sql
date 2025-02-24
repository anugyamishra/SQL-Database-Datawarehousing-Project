-- DenverZoo FactOrder Table
SELECT
	DenverZoo.dbo.TicketSaleType.TicketSaleTypeID,
	DenverZoo.dbo.TicketSaleType.TicketSaleID,
	DenverZooDM.dbo.DimDate.Date_SK AS TransactionDate,
	DenverZooDM.dbo.DimCustomer.Customer_SK,
	DenverZooDM.dbo.DimEmployee.Employee_SK,
	DenverZooDM.dbo.DimTicketType.TicketType_SK,
	DenverZoo.dbo.TicketType.Price AS UnitTicketPrice,
	DenverZoo.dbo.TicketSaleType.Quantity AS SaleQuantity,
	DenverZoo.dbo.TicketType.Price * DenverZoo.dbo.TicketSaleType.Quantity AS LineOrderTotal
FROM
	DenverZoo.dbo.TicketSaleType
INNER JOIN
	DenverZoo.dbo.TicketSale
ON
	DenverZoo.dbo.TicketSaleType.TicketSaleID = DenverZoo.dbo.TicketSale.TicketSaleID
INNER JOIN
	DenverZoo.dbo.TicketType
ON
	DenverZoo.dbo.TicketSaleType.TicketTypeID = DenverZoo.dbo.TicketType.TicketTypeID
INNER JOIN
	DenverZooDM.dbo.DimDate
ON
	DenverZooDM.dbo.DimDate.Date = DenverZoo.dbo.TicketSale.TransactionDate
INNER JOIN
	DenverZooDM.dbo.DimCustomer
ON
	DenverZooDM.dbo.DimCustomer.Customer_BK = DenverZoo.dbo.TicketSale.CustomerID
INNER JOIN
	DenverZooDM.dbo.DimEmployee
ON
	DenverZooDM.dbo.DimEmployee.Employee_BK = DenverZoo.dbo.[TicketSale].EmployeeID
INNER JOIN
	DenverZooDM.dbo.DimTicketType
ON
	DenverZooDM.dbo.DimTicketType.TicketType_BK = DenverZoo.dbo.TicketType.TicketTypeID