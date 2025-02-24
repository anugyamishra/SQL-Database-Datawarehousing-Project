


-- Creating the data mart

IF NOT EXISTS(SELECT * 
	FROM sys.databases  
	WHERE name = N'DenverZooDM')
	CREATE DATABASE DenverZooDM
GO  
USE DenverZooDM;


-------------------------------------------------------------------------------------------------------------------------
-- Deleting existing tables

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'FactTicketSale'
       )
	DROP TABLE FactTicketSale;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimCustomer'
       )
	DROP TABLE DimCustomer;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimEmployee'
       )
	DROP TABLE DimEmployee;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimTicketType'
       )
	DROP TABLE DimTicketType;


IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'DimDate'
       )
	DROP TABLE DimDate;
	

-------------------------------------------------------------------------------------------------------------------------
--Creating the tables

CREATE TABLE DimDate
	(
	Date_SK							INT PRIMARY KEY, 
	Date							DATE,
	FullDate						NCHAR(10),-- Date in MM-dd-yyyy format
	DayOfMonth						INT, -- Field will hold day number of Month
	DayName							NVARCHAR(9), -- Contains name of the day, Sunday, Monday 
	DayOfWeek						INT,-- First Day Sunday=1 and Saturday=7
	DayOfWeekInMonth				INT, -- 1st Monday or 2nd Monday in Month
	DayOfWeekInYear					INT,
	DayOfQuarter					INT,
	DayOfYear						INT,
	WeekOfMonth						INT,-- Week Number of Month 
	WeekOfQuarter					INT, -- Week Number of the Quarter
	WeekOfYear						INT,-- Week Number of the Year
	Month							INT, -- Number of the Month 1 to 12{}
	MonthName						NVARCHAR(9),-- January, February etc
	MonthOfQuarter					INT,-- Month Number belongs to Quarter
	Quarter							NCHAR(2),
	QuarterName						NVARCHAR(9),-- First,Second..
	Year							INT,-- Year value of Date stored in Row
	YearName						CHAR(7), -- CY 2017,CY 2018
	MonthYear						CHAR(10), -- Jan-2018,Feb-2018
	MMYYYY							INT,
	FirstDayOfMonth					DATE,
	LastDayOfMonth					DATE,
	FirstDayOfQuarter				DATE,
	LastDayOfQuarter				DATE,
	FirstDayOfYear					DATE,
	LastDayOfYear					DATE,
	IsHoliday						BIT,-- Flag 1=National Holiday, 0-No National Holiday
	IsWeekday						BIT,-- 0=Week End ,1=Week Day
	Holiday							NVARCHAR(50),--Name of Holiday in US
	Season							NVARCHAR(10)--Name of Season
	);

CREATE TABLE DimTicketType
	(
	TicketType_SK				INT		IDENTITY	CONSTRAINT pk_ticket_type_key				PRIMARY KEY
	,TicketType_BK				INT					CONSTRAINT nn_ticket_type_bk				NOT NULL
	,TicketTypeName				NVARCHAR(100)		CONSTRAINT nn_ticket_type_name				NOT NULL
	);

CREATE TABLE DimCustomer
	(
	Customer_SK						INT		IDENTITY	CONSTRAINT pk_customer_key				PRIMARY KEY
	,Customer_BK					INT					CONSTRAINT nn_customer_bk				NOT NULL
	,CustomerFirstName				NVARCHAR(100)		CONSTRAINT nn_customer_first_name		NOT NULL
	,CustomerLastName				NVARCHAR(100)		CONSTRAINT nn_customer_last_name		NOT NULL
	,CustomerAge					INT					CONSTRAINT nn_customer_age				NOT NULL
	,CustomerAgeGroup				NVARCHAR(100)		CONSTRAINT nn_customer_age_group		NOT NULL
	,CustomerDateofBirth			DATE				CONSTRAINT nn_customer_date_of_birth	NOT NULL
	,CustomerGender					NVARCHAR(20)		CONSTRAINT nn_customer_gender			NOT NULL
	,CustomerIsMember				NVARCHAR(30)		CONSTRAINT nn_customer_is_member		NOT NULL
	);

CREATE TABLE DimEmployee
	(
	Employee_SK						INT		IDENTITY	CONSTRAINT pk_employee_key				PRIMARY KEY
	,Employee_BK					INT					CONSTRAINT nn_employee_bk				NOT NULL
	,EmployeeFirstName				NVARCHAR(100)		CONSTRAINT nn_employee_first_name		NOT NULL
	,EmployeeLastName				NVARCHAR(100)		CONSTRAINT nn_employee_last_name		NOT NULL
	,EmployeePositionName			NVARCHAR(100)		CONSTRAINT nn_employee_position_name	NOT NULL
	,EmployeeDepartment				NVARCHAR(100)		CONSTRAINT nn_employee_department		NOT NULL
	,EmployeeDateofBirth			DATE				CONSTRAINT nn_employee_date_of_birth	NOT NULL
	,EmployeeAge					INT					CONSTRAINT nn_employee_age				NOT NULL
	,EmployeeGender					NVARCHAR(20)		CONSTRAINT nn_employee_gender			NOT NULL
	,EmployeeIsSalaried				NVARCHAR(30)		CONSTRAINT nn_employee_is_salaried		NOT NULL
	);

CREATE TABLE FactTicketSale
	(
	Customer_SK						INT					CONSTRAINT fk_customer_key			FOREIGN KEY REFERENCES DimCustomer(Customer_SK)
	,Employee_SK					INT					CONSTRAINT fk_employee_key			FOREIGN KEY REFERENCES DimEmployee(Employee_SK)
	,TicketType_SK					INT					CONSTRAINT fk_ticket_type_key		FOREIGN KEY REFERENCES DimTicketType(TicketType_SK)
	,TransactionDate				INT					CONSTRAINT fk_transaction_date_key	FOREIGN KEY REFERENCES DimDate(Date_SK)
	,TicketSaleID					INT					CONSTRAINT nn_ticket_sale_id			NOT NULL
	,TicketSaleTypeID				INT					CONSTRAINT nn_ticket_sale_type_id		NOT NULL
	,SaleQuantity					INT					CONSTRAINT nn_sale_quantity				NOT NULL
	,UnitTicketPrice				MONEY				CONSTRAINT nn_unti_ticket_price			NOT NULL
	,LineOrderTotal					MONEY				CONSTRAINT nn_line_order_total			NOT NULL
	,CONSTRAINT pk_fact_ticket_sale PRIMARY KEY (TicketSaleID,TicketSaleTypeID,Customer_SK,Employee_SK,TicketType_SK,TransactionDate)
	);

----------------------------------------------------------------------------------------------------------------------------

