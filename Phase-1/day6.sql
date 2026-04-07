-- creating a Partition Function's 
create partition function PF_StockByYear(Date)
as range right for values(
'2023-01-01',
'2024-01-01',
'2025-01-01',
'2026-01-01');

-- Creating Partition Schema :: 
create partition scheme PS_StockByYear
as partition PF_StockByYear
ALL to ([PRIMARY]);
---Creating a table with partition scheme ::
-- Creating Partition Tables 
create table StockPricePartitioned(
PriceId int not null,
CompanyId int not null,
TradeDate date not null,
OpenPrice decimal(10,2),
HighPrice decimal(10,2),
LowPrice decimal(10,2),
ClosePrice decimal(10,2),
Volume bigint
) on Ps_StockByYear(TradeDate);
--- Inserting data into the partitioned table 
insert into StockPricePartitioned values
(1,1,'2022-06-15',1200,1220,1290,1190,20000),
(2,2,'2022-06-15',1200,1220,1290,1190,20000),
(3,1,'2023-03-20',1200,1220,1290,1190,20000),
(4,2,'2023-03-20',1200,1220,1290,1190,20000),
(5,3,'2024-06-15',1200,1220,1290,1190,20000),
(6,1,'2024-06-15',1200,1220,1290,1190,20000),
(7,2,'2025-07-15',1200,1220,1290,1190,20000),
(8,3,'2025-07-15',1200,1220,1290,1190,20000),
(9,4,'2026-04-01',1200,1220,1290,1190,20000),
(10,1,'2026-04-01',1200,1220,1290,1190,20000);
-- Checking the partition eachrow landed in 
select PriceId,CompanyID,TradeDate,ClosePrice,OpenPrice,
$Partition.PF_StockByYear(TradeDate) as PartitionNumber 
from StockPricePartitioned
order by TradeDate;
--- Query only One Partition for 2026 
select * from StockPricePartitioned
where TradeDate >= '2026-01-01';
-- Comparing search Specific Partition directly
select * from StockPricePartitioned
where $Partition.PF_StockByYear(TradeDate) = 1;