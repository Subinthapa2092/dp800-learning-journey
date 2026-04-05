--- Creating the Simple Squences 
 create sequence seq_transactionID
 start with 1 
 increment by 2 
 minvalue 1 maxvalue 9999
 no cycle;
select next value for seq_transactionID;
-- For changing the Sequence Max Values
alter sequence seq_transactionID
 maxvalue 999;
-- For Changing the Sequence increment Values 
alter sequence seq_transactionID
increment by 2;
-- checking the Output;; 
select next value for seq_transactionID;
select next value for seq_transactionID;
select next value for seq_transactionId;
select next value for seq_transactionID;
-- Droping the Sequence 
drop sequence seq_transactionID;
-- Renaming the new Sequence with Column name 
select next value for seq_transactionID as transactionId;

-- Step 1: Reset sequence to 1
ALTER SEQUENCE seq_transaction_ID
RESTART WITH 1;

-- Step 2: Drop table completely
DROP TABLE IF EXISTS Transactions;

-- Step 3: Recreate fresh
CREATE TABLE Transactions (
    TransactionID   INT PRIMARY KEY
                    DEFAULT (NEXT VALUE FOR seq_transaction_ID),
    CompanyId       INT NOT NULL,
    TradeDate       DATE NOT NULL,
    TradeType       CHAR(1) NOT NULL,
    Quantity        INT NOT NULL,
    Price           DECIMAL(10,2) NOT NULL,
    TotalAmount     AS (CAST(Quantity AS DECIMAL(10,2)) * Price) PERSISTED,
    FOREIGN KEY (CompanyId) REFERENCES Companies(CompanyID),
    CHECK (TradeType IN ('B','S')),
    CHECK (Quantity > 0),
    CHECK (Price > 0)
);

-- Step 4: Insert one row only to test
INSERT INTO Transactions
    (CompanyId, TradeDate, TradeType, Quantity, Price)
VALUES
(1, GETDATE(), 'S', 50, 60.00);
(2, GETDATE(), 'B', 100, 50.00);
(3, GETDATE(), 'S', 50, 60.00);


-- Step 5: Check result
SELECT * FROM Transactions;