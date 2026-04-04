-- Using the Database
use NepseDB;
--- Checking the Existing Indexes:: 
select 
i.name as IndexName,
i.type_desc as IndexType,
t.name as TableName
from sys.indexes i
join sys.tables t on i.object_id = t.object_id
where t.name in ('Companies','StockPrice','Financials')
and i.name is not null;

--- Creating the New Indexes;;
-- Nonclustered Index on Symbol(we search by Symbol often)
create nonclustered index IX_Companies_Symbol
on Companies(Symbol);
--- Creating Non Cluster index on TradeDate(we filter by date often)
create nonclustered index IX_StockPrice_TradeDate
on StockPrice(TradeDate);
-- Creating Non Clustered Index on CompanyID + TradeDate Combined
-- (Composite index for joining and filtering together)
create nonclustered index IX_StockPrice_CompanyDate
on StockPrice(CompanyID,TradeDate);
--- Columnstore Index on StockPrice for analytics:: 
create nonclustered Columnstore index IX_StockPrice_ColumnStore
on StockPrice(OpenPrice,HighPrice,LowPrice,ClosePrice,Volume);
-- query 1st Seeing the Different Indexes Making:: 
select * from companies where Symbol = 'NABIL';
select * from StockPrice Where TradeDate ='2026-01-04';