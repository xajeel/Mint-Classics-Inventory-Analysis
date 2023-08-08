USE mintclassic;
SELECT 
    SUM(quantityOrdered) AS tot_order, 
    SUM(quantityInStock) AS tot_stock, 
    productLine, warehouseCode,
    SUM(quantityOrdered) / DATEDIFF(NOW(), MIN(orderDate)) AS sales_velocity,
    SUM(quantityInStock) / SUM(quantityOrdered) AS inventory_order_ratio,
    DATEDIFF(MAX(orderDate), MIN(orderDate)) / sum(quantityOrdered) AS avg_order_time
    
FROM orders o
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
GROUP BY productLine, warehouseCode
ORDER BY sales_velocity,inventory_order_ratio DESC;