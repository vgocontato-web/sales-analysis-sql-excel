SELECT 

YEAR(T1.OrderDate) AS 'Ano',
DATENAME(MONTH, T1.OrderDate) AS 'Mês',
FORMAT (T1.OrderDate, 'yyyy-MM') AS 'Ano-Mês',
T2.SalesTerritoryCountry AS 'País',
T3.StateProvinceName AS 'Estado/Província',
T6.EnglishProductCategoryName AS 'Categoria',
COUNT(T1.SalesOrderNumber) AS 'Quantidade de Pedidos',
SUM(T1.OrderQuantity) AS 'Quantidade por Categoria',
SUM(T1.SalesAmount) AS 'Faturamento',
SUM(T1.SalesAmount) / COUNT(DISTINCT T1.SalesOrderNumber) AS 'Ticket Médio',
SUM(T1.TotalProductCost) AS 'Custo Total',
SUM(T1.SalesAmount) - SUM(T1.TotalProductCost) AS 'Lucro',
(SUM(T1.SalesAmount) - SUM(T1.TotalProductCost)) / SUM(T1.SalesAmount) AS 'Margem %'

FROM FactResellerSales AS T1
JOIN DimSalesTerritory AS T2 ON T1.SalesTerritoryKey = T2.SalesTerritoryKey
JOIN DimGeography AS T3 ON T2.SalesTerritoryKey = T3.SalesTerritoryKey
JOIN DimProduct AS T4 ON T1.ProductKey = T4.ProductKey
JOIN DimProductSubcategory AS T5 ON T4.ProductSubcategoryKey = T5.ProductSubcategoryKey
JOIN DimProductCategory AS T6 ON T5.ProductCategoryKey = T6.ProductCategoryKey

GROUP BY
YEAR(T1.OrderDate),
DATENAME(MONTH, T1.OrderDate), 
FORMAT (T1.OrderDate, 'yyyy-MM'),
T2.SalesTerritoryCountry,
T3.StateProvinceName,
T6.EnglishProductCategoryName

ORDER BY 'Ano' ASC