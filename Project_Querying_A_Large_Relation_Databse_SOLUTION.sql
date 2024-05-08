Use [AdventureWorks2012]



--a. Get all the details from the person table including email ID, phone number and phone number type

SELECT P.*,E.EmailAddress,T.PhoneNumber,PhoneNumberTypeID
FROM Person.Person AS P 
INNER JOIN Person.EmailAddress AS E ON
P.BusinessEntityID = E.BusinessEntityID
INNER JOIN Person.PersonPhone AS T ON
P.BusinessEntityID = T.BusinessEntityID


--b. Get the details of the sales header order made in May 2011

SELECT * FROM Sales.SalesOrderHeader
Where Year(OrderDate)= 2011 And Month(orderdate)=05;

--c. Get the details of the sales details order made in the month of May 2011

SELECT S.* FROM Sales.SalesOrderDetail AS S
INNER JOIN Sales.SalesOrderHeader AS H ON
S.SalesOrderID = H.SalesOrderID
Where Year(OrderDate)= 2011 And Month(orderdate)=05

--d. Get the total sales made in May 2011

Select sum(LineTotal) AS Total_Sales, YEAR(OrderDate) AS Year
FROM Sales.SalesOrderDetail AS S
INNER JOIN Sales.SalesOrderHeader AS H ON
S.SalesOrderID = H.SalesOrderID
WHERE MONTH(OrderDate) = 5 AND YEAR(OrderDate) = 2011
GROUP BY YEAR(OrderDate)

          --OR--

SELECT SUM(SubTotal) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE MONTH(OrderDate) = 5 AND YEAR(OrderDate) = 2011;


--e. Get the total sales made in the year 2011 by month order by increasing sales.

Select DATENAME(MONTH, OrderDate) AS Month, YEAR(OrderDate) AS Year,sum(LineTotal) AS Total_Sales
from Sales.SalesOrderDetail AS S
INNER JOIN Sales.SalesOrderHeader AS H ON
S.SalesOrderID = H.SalesOrderID
WHERE Year(OrderDate) = '2011'
GROUP BY DATENAME(MONTH, OrderDate),YEAR(OrderDate)
ORDER BY Total_Sales asc

       --OR--

SELECT DateName(Month,OrderDate) As OrderMonth,SUM(SubTotal) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE  YEAR(OrderDate) = 2011
Group by DateName(Month, OrderDate)
Order By TotalSales;


--f. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'

SELECT P.FirstName,P.LastName, SUM(SalesYTD) AS Total_Sales
FROM Person.Person AS P
INNER JOIN Sales.SalesPerson AS S ON  ------Pending 
P.BusinessEntityID = S.BusinessEntityID
WHERE FirstName = 'Gustavo' AND LastName = 'Achong'
GROUP BY P.FirstName,P.LastName

            --OR---

SELECT SUM(soh.Subtotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.person p ON soh.rowguid= p.rowguid
WHERE p.FirstName = 'Gustavo' And p.LastName= 'Achong';





