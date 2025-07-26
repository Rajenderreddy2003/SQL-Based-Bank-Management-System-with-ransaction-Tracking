-------------------------------------- Bank Account & Transaction System -----------------------------------------

-------------- Problem Statement -----------------
-- This project aims to build a secure and efficient system to manage banking operations,
-- including customer profiles, account details, transactions, and branch assignments. 
-- It ensures proper data relationships using foreign keys, 
-- supports secure logins with password hashing, 
-- and tracks all financial activities like deposits and withdrawals. 


create database BankDatabase;
use BankDatabase;

-- 1. Database Design & Table Creation (DDL) --------------------------------

-- Customers Table 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(150),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address TEXT,
    DOB DATE
);

-- Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountNumber VARCHAR(20) UNIQUE,
    AccountType VARCHAR(50),
    Balance DECIMAL(15, 2),
    CreatedOn DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATETIME,
    Amount DECIMAL(12, 2),
    TransactionType VARCHAR(20), -- e.g., Debit, Credit
    Description TEXT,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Branches Table
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    Location VARCHAR(150),
    ManagerName VARCHAR(100)
);

-- AccountBranch Table
CREATE TABLE AccountBranch (
    AccountID INT,
    BranchID INT,
    AssignedDate DATE,
    PRIMARY KEY (AccountID, BranchID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- LoginCredentials Table
CREATE TABLE LoginCredentials (
    LoginID INT PRIMARY KEY,
    CustomerID INT,
    Username VARCHAR(50) UNIQUE,
    PasswordHash VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 4.Modify a column (e.g., increase size or change type).
alter table customers
modify fullname varchar(100);

desc customers;

-- 5.Drop a column or rename a table.
alter table LoginCredentials
rename column PasswordHash to HashPassword;

desc LoginCredentials;


-- 2. Data Insertion & Manipulation (DML)----------------------

-- 6.Insert at least 20–30 rows of sample data into each table.
-- Customers Table
INSERT INTO Customers (CustomerID, FullName, Email, Phone, Address, DOB) VALUES
(1, 'John Doe', 'johndoe@email.com', '9876543210', '123 Main St, City A', '1990-05-20'),
(2, 'Jane Smith', 'janesmith@email.com', '9876543211', '456 Elm St, City B', '1988-10-15'),
(3, 'Alice Johnson', 'alicej@email.com', '9876543212', '789 Oak St, City C', '1992-12-01'),
(4, 'Bob Brown', 'bobb@email.com', '9876543213', '321 Pine St, City D', '1985-03-08'),
(5, 'Charlie Davis', 'charlied@email.com', '9876543214', '654 Maple St, City E', '1995-07-25'),
(6, 'Eva Green', 'evag@email.com', '9876543215', '987 Cedar St, City F', '1993-09-19'),
(7, 'Frank White', 'frankw@email.com', '9876543216', '432 Birch St, City G', '1987-11-30'),
(8, 'Grace King', 'gracek@email.com', '9876543217', '765 Walnut St, City H', '1990-02-12'),
(9, 'Henry Lee', 'henryl@email.com', '9876543218', '987 Spruce St, City I', '1991-06-06'),
(10, 'Ivy Walker', 'ivyw@email.com', '9876543219', '123 Ash St, City J', '1994-04-18'),
(11, 'Jack Hill', 'jackh@email.com', '9876543220', '124 Willow St, City A', '1996-08-23'),
(12, 'Karen Young', 'kareny@email.com', '9876543221', '425 Cypress St, City B', '1989-05-10'),
(13, 'Liam Scott', 'liams@email.com', '9876543222', '678 Poplar St, City C', '1993-02-14'),
(14, 'Mia Adams', 'miaa@email.com', '9876543223', '789 Dogwood St, City D', '1990-12-05'),
(15, 'Noah Baker', 'noahb@email.com', '9876543224', '345 Palm St, City E', '1992-01-30'),
(16, 'Olivia Carter', 'oliviac@email.com', '9876543225', '567 Fir St, City F', '1988-09-27'),
(17, 'Paul Evans', 'paule@email.com', '9876543226', '234 Redwood St, City G', '1991-03-11'),
(18, 'Quinn Flores', 'quinnf@email.com', '9876543227', '678 Cottonwood St, City H', '1995-11-08'),
(19, 'Ruby Gomez', 'rubyg@email.com', '9876543228', '890 Chestnut St, City I', '1994-07-14'),
(20, 'Sam Harris', 'samh@email.com', '9876543229', '109 Hickory St, City J', '1997-12-22');

-- Accounts Table
INSERT INTO Accounts (AccountID, CustomerID, AccountNumber, AccountType, Balance, CreatedOn) VALUES
(1, 1, 'ACC1001', 'Savings', 5000.00, '2022-01-15'),
(2, 2, 'ACC1002', 'Current', 12000.00, '2022-02-18'),
(3, 3, 'ACC1003', 'Savings', 3000.00, '2022-03-22'),
(4, 4, 'ACC1004', 'Current', 8000.00, '2022-04-10'),
(5, 5, 'ACC1005', 'Savings', 7000.00, '2022-05-11'),
(6, 6, 'ACC1006', 'Savings', 1500.00, '2022-06-12'),
(7, 7, 'ACC1007', 'Current', 9200.00, '2022-07-15'),
(8, 8, 'ACC1008', 'Savings', 5400.00, '2022-08-18'),
(9, 9, 'ACC1009', 'Savings', 2500.00, '2022-09-20'),
(10, 10, 'ACC1010', 'Current', 6600.00, '2022-10-22'),
(11, 11, 'ACC1011', 'Savings', 4300.00, '2022-11-25'),
(12, 12, 'ACC1012', 'Savings', 7800.00, '2022-12-01'),
(13, 13, 'ACC1013', 'Current', 8700.00, '2023-01-05'),
(14, 14, 'ACC1014', 'Savings', 2000.00, '2023-02-08'),
(15, 15, 'ACC1015', 'Current', 5100.00, '2023-03-10'),
(16, 16, 'ACC1016', 'Savings', 6200.00, '2023-04-12'),
(17, 17, 'ACC1017', 'Current', 7700.00, '2023-05-15'),
(18, 18, 'ACC1018', 'Savings', 9100.00, '2023-06-17'),
(19, 19, 'ACC1019', 'Savings', 1000.00, '2023-07-20'),
(20, 20, 'ACC1020', 'Current', 15000.00, '2023-08-22');

-- Branches Table
INSERT INTO Branches (BranchID, BranchName, Location, ManagerName) VALUES
(1, 'Central Branch', 'Downtown', 'Mr. A'),
(2, 'North Branch', 'North City', 'Mrs. B'),
(3, 'South Branch', 'South City', 'Mr. C'),
(4, 'East Branch', 'East City', 'Mrs. D'),
(5, 'West Branch', 'West City', 'Mr. E'),
(6, 'Uptown Branch', 'Uptown', 'Mr. F'),
(7, 'Suburban Branch', 'Suburbs', 'Mrs. G'),
(8, 'Airport Branch', 'Near Airport', 'Mr. H'),
(9, 'University Branch', 'University Area', 'Mrs. I'),
(10, 'Industrial Branch', 'Industrial Zone', 'Mr. J'),
(11, 'Harbor Branch', 'Harbor Area', 'Mrs. K'),
(12, 'Hillside Branch', 'Hillside', 'Mr. L'),
(13, 'Lakeside Branch', 'Lakeside', 'Mrs. M'),
(14, 'City Center Branch', 'City Center', 'Mr. N'),
(15, 'Technology Park Branch', 'Tech Park', 'Mrs. O'),
(16, 'Historic Branch', 'Old Town', 'Mr. P'),
(17, 'Market Branch', 'Market Area', 'Mrs. Q'),
(18, 'Museum Branch', 'Museum District', 'Mr. R'),
(19, 'Metro Branch', 'Metro Station', 'Mrs. S'),
(20, 'New Town Branch', 'New Town', 'Mr. T');

-- AccountBranch Table
INSERT INTO AccountBranch (AccountID, BranchID, AssignedDate) VALUES
(1, 1, '2022-01-20'),
(2, 2, '2022-02-25'),
(3, 3, '2022-03-28'),
(4, 4, '2022-04-15'),
(5, 5, '2022-05-16'),
(6, 6, '2022-06-17'),
(7, 7, '2022-07-19'),
(8, 8, '2022-08-22'),
(9, 9, '2022-09-23'),
(10, 10, '2022-10-24'),
(11, 11, '2022-11-27'),
(12, 12, '2022-12-05'),
(13, 13, '2023-01-07'),
(14, 14, '2023-02-09'),
(15, 15, '2023-03-11'),
(16, 16, '2023-04-13'),
(17, 17, '2023-05-16'),
(18, 18, '2023-06-18'),
(19, 19, '2023-07-21'),
(20, 20, '2023-08-23');

-- Transaction Table
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType, Description) VALUES
(1, 1, '2023-01-10 10:15:00', 500.00, 'Credit', 'Salary deposit'),
(2, 1, '2023-01-12 11:20:00', 200.00, 'Debit', 'Grocery shopping'),
(3, 2, '2023-02-14 12:30:00', 1000.00, 'Credit', 'Project Payment'),
(4, 2, '2023-02-16 09:45:00', 500.00, 'Debit', 'Mobile Purchase'),
(5, 3, '2023-03-15 14:00:00', 250.00, 'Credit', 'Cashback'),
(6, 3, '2023-03-17 16:00:00', 100.00, 'Debit', 'Restaurant Bill'),
(7, 4, '2023-04-18 17:30:00', 800.00, 'Credit', 'Freelance Income'),
(8, 4, '2023-04-19 18:30:00', 400.00, 'Debit', 'Electricity Bill'),
(9, 5, '2023-05-20 20:45:00', 600.00, 'Credit', 'Bonus'),
(10, 5, '2023-05-21 21:50:00', 150.00, 'Debit', 'Shopping'),
(11, 6, '2023-06-22 22:30:00', 700.00, 'Credit', 'Rent Collection'),
(12, 7, '2023-07-23 09:10:00', 900.00, 'Credit', 'Stock Sale'),
(13, 8, '2023-08-24 11:30:00', 300.00, 'Credit', 'Gift'),
(14, 9, '2023-09-25 13:45:00', 450.00, 'Debit', 'Travel'),
(15, 10, '2023-10-26 15:00:00', 350.00, 'Credit', 'Cash Reward'),
(16, 11, '2023-11-27 17:15:00', 250.00, 'Debit', 'Online Subscription'),
(17, 12, '2023-12-28 19:20:00', 550.00, 'Credit', 'Festival Bonus'),
(18, 13, '2024-01-29 21:25:00', 800.00, 'Debit', 'New Phone Purchase'),
(19, 14, '2024-02-01 08:30:00', 400.00, 'Credit', 'Refund'),
(20, 15, '2024-03-02 10:00:00', 200.00, 'Debit', 'Medical Bill');

-- LoginCredentials Table
INSERT INTO LoginCredentials (LoginID, CustomerID, Username, HashPassword) VALUES
(1, 1, 'johndoe', 'hashedpassword1'),
(2, 2, 'janesmith', 'hashedpassword2'),
(3, 3, 'alicejohnson', 'hashedpassword3'),
(4, 4, 'bobbrown', 'hashedpassword4'),
(5, 5, 'charliedavis', 'hashedpassword5'),
(6, 6, 'evagreen', 'hashedpassword6'),
(7, 7, 'frankwhite', 'hashedpassword7'),
(8, 8, 'graceking', 'hashedpassword8'),
(9, 9, 'henrylee', 'hashedpassword9'),
(10, 10, 'ivywalker', 'hashedpassword10'),
(11, 11, 'jackhill', 'hashedpassword11'),
(12, 12, 'karenyoung', 'hashedpassword12'),
(13, 13, 'liamscott', 'hashedpassword13'),
(14, 14, 'miaadams', 'hashedpassword14'),
(15, 15, 'noahbaker', 'hashedpassword15'),
(16, 16, 'oliviacarter', 'hashedpassword16'),
(17, 17, 'paulevans', 'hashedpassword17'),
(18, 18, 'quinnflores', 'hashedpassword18'),
(19, 19, 'rubygomez', 'hashedpassword19'),
(20, 20, 'samharris', 'hashedpassword20');

-- 7.Update specific rows based on conditions.
update customers
set Address = "456 Main St, City A"
where FullName = "John Doe";

select * from customers;

-- 8.Delete one or more records using conditions.
Delete from Transactions 
where TransactionID = 19;

Delete from Transactions 
where TransactionID = 20;

select * from Transactions;

-- 9.Insert multiple rows using a single statement.
insert into Transactions values
(19, 14, '2024-02-01 08:30:00', 400.00, 'Credit', 'Refund'),
(20, 15, '2024-03-02 10:00:00', 200.00, 'Debit', 'Medical Bill');

select * from Transactions;

-- 10.Use LOCK to control concurrent updates (optional for advanced users).
lock tables Accounts read;

SELECT * FROM Accounts WHERE AccountID = 1;

UNLOCK TABLES;


-- 3. SELECT Queries & Filtering -----------

-- 11.Retrieve all data from a table.
select * from Accounts;

-- 12.Select specific columns with WHERE conditions.
select AccountNumber from Accounts
where balance > 11000;

-- 13.Use BETWEEN, IN, IS NULL, LIKE for filtering.
select * from Accounts where balance between 7000 and 11000;

select * from Branches where Location in ("old town","new town");

select * from Customers where CustomerID is null;

select * from Customers where FullName like "J%";

-- 14.Show top 5 records using LIMIT or sorted by a column.
select * from Accounts order by balance desc limit 5;

-- 15.Combine filters using AND, OR, and NOT.
select FullName from Customers where FullName like "r%" and FullName like "%z";

select FullName from Customers where FullName like "m%" or FullName like "r%";

select FullName from Customers where not FullName like "j%";


-- 4. Sorting, Distinct, and Pagination -------------------------
 
-- 16.Display unique values from a column using DISTINCT.
select distinct(FullName) from Customers;

-- 17.Sort records in ascending/descending order using ORDER BY.
select * from Accounts order by Balance desc;

-- 18.Implement pagination using LIMIT and OFFSET.
select * from Customers limit 10 offset 6;


-- 5. Aggregate Functions & Grouping -------------------------------
desc Accounts;
-- 19.Use COUNT, SUM, AVG, MIN, MAX on relevant numeric columns.
select distinct(count(CustomerID)) from Customers;
select AccountType,sum(balance) from Accounts Group by AccountType;
select AccountType,avg(balance) from Accounts Group by AccountType;
select AccountType,min(balance) from Accounts Group by AccountType;
select AccountType,max(balance) from Accounts Group by AccountType;

-- 20.Group records by a specific column and apply aggregation.
select AccountType,avg(balance) from Accounts Group by AccountType;

-- 21.Filter groups using HAVING (e.g., show groups with more than 3 items).
select AccountType,count(*) as count1 from Accounts group by AccountType having count1 >8;


-- 6. Joins --------------------------------------------------------

-- 22.Use INNER JOIN to combine data from at least two related tables.
select * from Accounts A
inner join Transactions T
on A.AccountID = T.AccountID;

-- 23.Use LEFT JOIN or RIGHT JOIN to display unmatched data as well.
select * from Accounts A
left join Transactions T
on A.AccountID = T.AccountID;

select * from Transactions T
right join Accounts A
on A.AccountID = T.AccountID;

-- 24.Join three or more tables to produce a meaningful report.
select AccountNumber,C.FullName,AccountType,Balance,B.BranchName,B.Location
from Accounts A
join Customers C on
A.CustomerID = C.CustomerID
join AccountBranch AB on
A.AccountID = AB.AccountID
join Branches B on
AB.BranchID = B.BranchID;


--  7. Subqueries ---------------------------------------

-- 25.Write a subquery in WHERE to compare against aggregated data.
select * from Accounts
where Balance > (select avg(Balance) from Accounts);

-- 26. Use a subquery in FROM as a derived table.
select AccountNumber,FullName from 
(select AccountNumber,Balance,c.FullName,c.Address from Accounts a 
join Customers c on a.CustomerID = c.CustomerID)
 as table1;
 
 -- 27.Implement a correlated subquery for row-wise comparison.
SELECT DISTINCT c.CustomerID, c.FullName, t.AccountID, t.Amount AS HighAmount
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.Amount > (
    SELECT AVG(t2.Amount)
    FROM Transactions t2
    WHERE t2.AccountID = t.AccountID
);
select * from Accounts a
where a.Balance > (select avg(a2.Balance) from Accounts a2
where a2.AccountType = a.AccountType);


-- 8. String Functions ----------------------------

-- 28.Concatenate two or more columns into one. 
select concat(AccountNumber, " - ",FullName," - ", AccountType," Account") as Details 
from Accounts a
join Customers c on c.customerID = a.customerID;

-- 29.Change the case of text using UPPER or LOWER.
select upper(FullName)
from Customers;

select lower(FullName)
from Customers;

-- 30.Use SUBSTRING, REPLACE, or REVERSE on text fields.
select substring(FullName,1,4) from Customers;

select replace(FullName,'a','apple') from Customers;

select reverse(FullName) from Customers;

-- 31.Extract left/right parts of a string, Use Other Strings.
select left(FullName,2) from Customers;

select right(FullName,3) from Customers;


--  9. Date & Time Functions ---------------------------------

-- 32.Extract parts of a date (year, month, day) using YEAR(), MONTH(), etc.
select year(TransactionDate) from Transactions;

select month(TransactionDate) from Transactions;

select day(TransactionDate) from Transactions;

-- 33.Get current date/time using NOW(), CURDATE(), CURTIME().
select now();

select curdate();

select curtime();

-- 34.Find the difference between two dates using DATEDIFF() or TIMESTAMPDIFF().
select datediff(TransactionDate,CreatedOn)
from Accounts a
join Transactions t
on a.AccountID = t.AccountID;

select timestampdiff(month,CreatedOn,TransactionDate)
from Accounts a
join Transactions t
on a.AccountID = t.AccountID;

-- 35.Add or subtract time from a date using DATE_ADD() or DATE_SUB().
select date_add(CreatedOn,interval 5 month) from Accounts;

select date_sub(CreatedOn,interval 15 day) from Accounts;


-- 10. Conditional Logic & CASE ----------------------------------

-- 36.Use CASE to assign labels (e.g., rating, status, grade) based on column values.
select AccountNumber,
case 
    when AccountType = "savings" and Balance <= 3000 then "Low Balance"
    when AccountType = "savings" and Balance <= 10000 then "Moderate Balance"
    when AccountType = "savings" and Balance > 10000 then "High Balance"
	when AccountType = "current" and Balance <= 1000 then "Low Balance"
	when AccountType = "current" and Balance <= 5000 then "Moderate Balance"
	when AccountType = "current" and Balance > 5000 then "High Balance"
	end as Note
from Accounts;

-- 37.Use CASE in ORDER BY or UPDATE to apply dynamic logic.
SELECT c.CustomerID, c.FullName, a.AccountType, a.Balance
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
ORDER BY 
    CASE 
        WHEN a.AccountType = 'Savings' THEN 1
        ELSE 2
    END,
    a.Balance DESC;
    
    
--  11. Views --------------------------------------

-- 38.Create a view that summarizes key data (e.g., top customers, popular products).
create view keydata as
select TransactionType,sum(Amount)
from Transactions
group by TransactionType
;

select * from keydata;

-- 39.Create a view for public reporting (e.g., showing only non-sensitive data).

create view Details as
select a.AccountID,c.FullName,a.AccountType,b.BranchName
from Customers c
join
Accounts a
on c.CustomerID = a.CustomerID
join AccountBranch ab
on a.AccountID = ab.AccountID
join Branches b
on ab.BranchID = b.BranchID;

select * from Details;

-- 40.Query the view using filters and joins.

select t.TransactionType,t.Amount
from Details d
join Transactions t
on d.AccountID = t.AccountID
where d.AccountType = "savings"
and t.TransactionType = "credit"
;



-- 12. ER Diagram ------------------------------------------


-- 42.Indicate relationship types (1:1, 1:N, M:N).

-- 1.Customers ↔ Accounts
--   1:N One-to-Many
--   One customer can have multiple accounts.

-- 2.Accounts ↔ Transactions
--   1:N (One-to-Many)
--   One account can have many transactions.

-- 3.Branches ↔ AccountBranch
--   1:N (One-to-Many)
--   One branch can be linked to many accounts.

-- 4.Customers ↔ LoginCredentials
--   1:1 (One-to-One)
--   One customer has one login.


-- 43.Explain the role of each foreign key in maintaining data integrity.

-- 1.Accounts.CustomerID → Customers.CustomerID
-- 		Ensures that each account is linked to a valid customer.
-- 		Prevents an account from being created for a non-existent customer.


-- 2.AccountBranch.AccountID → Accounts.AccountID
-- 		Associates each account with a specific branch.
-- 		Ensures no orphaned branch records exist without corresponding accounts.

-- 3.AccountBranch.BranchID → Branches.BranchID
-- 		Ensures the branch linked to the account exists in the branches table.
-- 		Guarantees valid reference to a real branch.

-- 4.Transactions.AccountID → Accounts.AccountID
-- 		Associates each transaction with an existing account.
-- 		Prevents transactions from being linked to non-existent or deleted accounts.

-- 5.LoginCredentials.CustomerID → Customers.CustomerID
-- 		Ensures login data is associated with a valid customer.
-- 		Prevents unauthorized or dangling login records for removed customers.