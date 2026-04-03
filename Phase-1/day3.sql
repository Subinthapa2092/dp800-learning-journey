-- For the NepseDB database, create a table named "companies" with the following columns:
-- - CompanyId: An integer that serves as the primary key.
USE NepseDB;
create table companies(
CompanyId Int primary key,
Symbol Varchar(10) not null unique,
CompanyName NVarchar(100) not null,
Sector Varchar(50) not null,
ListedDate Date Default getdate(),
IsActive bit Default 1,
Check(len(Symbol)>=2));

-- Create a table named "StockPrice" with the following columns:

CREATE TABLE StockPrice (
    PriceId     INT PRIMARY KEY,
    CompanyId   INT NOT NULL,
    TradeDate   DATE NOT NULL,
    OpenPrice   DECIMAL(10,2) NOT NULL,
    HighPrice   DECIMAL(10,2) NOT NULL,
    LowPrice    DECIMAL(10,2) NOT NULL,
    ClosePrice  DECIMAL(10,2) NOT NULL,
    Volume      BIGINT DEFAULT 1,
    FOREIGN KEY (CompanyId) REFERENCES Companies(CompanyID),
    CHECK (HighPrice >= LowPrice),
    CHECK (Volume >= 0)
);

-- Fiancial Table 
create Table Financials(
FinancialID Int primary key,
CompanyID int not null,
FiscalYear Char(7) not null,
EPS Decimal(10,2),
PE_Ratio Decimal(6,2),
MarktCap BigInt,
ReportDate Date Default GetDate(),
Foreign Key (CompanyID) References Companies(CompanyID),
Unique (CompanyID, FiscalYear),
Check (PE_Ratio > 0));
-- Inserting the Companies Sample Data 
-- Test 1 Insert Good Data (Should Work)
Insert into Companies Values
(1,'NABIL','Nabil Bank Limited','Banking','2010-01-01',1),
(2,'CHCL','Chilime Hydropower','Hydro','2012-02-15',1),
(3,'NRIC','Nepal Reinsurance Company','Insurance','2015-03-20',1);

-- Duplicate Symbol Test 2 -- Failed
Insert into Companies Values
(4,'NABIL','Some Other Bank','Banking',GetDate(),1);

-- 3 Test failed Because symbol is less than or equal to 2 
Insert into Companies Values
(4,'N','Bad Company','Banking',GETDATE(),1);
-- Test 4:: High Price Less than LowPrice (should be fail)
insert into StockPrice values
(1,1,'2026-01-04',470,510,480,485,5000);

-- Test 5: 
insert into StockPrice values
(1,1,'2026-01-04',500.00,510.00,480.00,485.00,5000),
(2,2,'2026-01-04',600.00,610.00,580.00,585.00,10000),
(3,3,'2026-01-04',1400.00,1500.00,1390.00,1490.00,20000);
-- Test 6: 
-- Test 6:: Fk Violation - Company 99 doesn't exist (should fail)
insert into StockPrice Values
(4,4,'2026-04-3',100,120,90,110,5000);
-- Quick Verfication of the data Fianancials Table 
insert Financials Values
(1,1,'2082',220,1200,5000000,GETDATE()),
(2,2,'2082',220,1200,2000000,GETDATE()),
(3,3,'2082',220,1200,9000000,GETDATE());
-- see all the Constraints 
select 
tc.constraint_Name,
tc.constraint_type,
tc.TABLE_NAME
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
where tc.TABLE_CATALOG = 'NepseDB'
order by tc.TABLE_NAME;
select * from Companies;
Select * from StockPrice;
select * from Financials;