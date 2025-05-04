Question 1:

To transform the `ProductDetail` table into 1NF, we need to split the `Products` column into separate rows, each representing a single product for an order

Here's the SQL query to achieve this:
```sql
SELECT OrderID, CustomerName, Product, 1 as Quantity
FROM ProductDetail
WHERE Product IS NOT NULL
UNION ALL
SELECT OrderID, CustomerName, Products, NULL as Quantity
FROM ProductDetail
WHERE Products IS NOT NULL;
```
This query will create a new row for each product in the `Products` column, with the `Quantity` column set to 1 for the first row and NULL for the subsequent rows.

Question 2:

To transform the `OrderDetails` table into 2NF, we need to remove the partial dependency on the `CustomerName` column by creating a new table for the customer information. We can then create a relationship between the `OrderDetails` table and the new `Customers` table using the `CustomerName` column as a foreign key.

Here's the SQL query to achieve this:
```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);

CREATE TABLE OrderDetails (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```
This query creates a new `Customers` table with a `CustomerID` column as the primary key and a `CustomerName` column. It then creates a new `OrderDetails` table with an `OrderID` column as the primary key, a `CustomerID` column as a foreign key, and `Product` and `Quantity` columns.

We can then insert the data from the original `OrderDetails` table into the new `OrderDetails` table using the following SQL query:
```sql
INSERT INTO Customers (CustomerID, CustomerName) SELECT DISTINCT CustomerID, CustomerName FROM OrderDetails;

INSERT INTO OrderDetails (OrderID, CustomerID, Product, Quantity) SELECT OrderID, CustomerID, Product, Quantity FROM OrderDetails;
```
This query first inserts the unique `CustomerID` and `CustomerName` values from the original `OrderDetails` table into the new `Customers` table. It then inserts the `OrderID`, `CustomerID`, `Product`, and `Quantity` values from the original `OrderDetails` table into the new `OrderDetails` table, using the `CustomerID` column as a foreign key to reference the corresponding row in the `Customers` table.