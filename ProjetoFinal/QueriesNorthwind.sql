USE Northwind;


-- 1. Quantos territórios estão registrados em cada região?

SELECT COUNT(TerritoryID) AS territorio_por_regiao FROM territories GROUP BY RegionID;

-- 2. Selecione da tabela order_details todas as ordens que tiveram pelo menos um item com mais de 50 unidades vendidas.

SELECT * FROM [Order Details] WHERE Quantity > 50;

-- 3. Qual o tempo médio de envio por cidade de destino?

SELECT ShipCity, AVG(DATEDIFF(DAY, Orders.OrderDate, Orders.ShippedDate)) AS tempo_medio_de_envio_em_dias FROM Orders GROUP BY ShipCity;

-- 4. Para cada empregado, exiba seu total de vendas em cada país.

SELECT Employees.FirstName AS Nome,
	Customers.Country AS País,
	SUM([Order Details].Quantity) AS TotalVendas
FROM Employees 
	INNER JOIN Orders
	ON Employees.EmployeeID = Orders.EmployeeID
	INNER JOIN [Order Details]
	ON Orders.OrderID = [Order Details].OrderID
	INNER JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.FirstName,
	Customers.Country
ORDER BY Employees.FirstName

-- 5. Calcule o preço de cada pedido após os descontos serem aplicados.

SELECT Products.ProductName AS Produto, 
	[Order Details].UnitPrice * ROUND(1 - [Order Details].Discount, 2) AS Valor
FROM [Order Details]
	INNER JOIN Products
	ON [Order Details].ProductID = Products.ProductID

/* 6. Crie uma view chamada ProductDetails que mostre
ProductID,
Company-Name,
CategoryName,
Description,
QuantityPerUnit,
UnitPrice,
UnitInstock,
UnitsOnOrder,
ReorderLevel,
Discontinued
das tabelas Supplier, Products e Categories.
*/

CREATE VIEW ProductDetails AS (
	SELECT Products.ProductID,
		Suppliers.CompanyName,
		Categories.CategoryName,
		Categories.Description,
		Products.QuantityPerUnit,
		Products.UnitPrice,
		Products.UnitsInStock,
		Products.UnitsOnOrder,
		Products.ReorderLevel,
		Products.Discontinued
	FROM Products
		INNER JOIN Suppliers
		ON Products.SupplierID = Suppliers.SupplierID
		INNER JOIN Categories
		ON Products.CategoryID = Categories.CategoryID
)

SELECT * FROM ProductDetails;
