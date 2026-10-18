-- =============================================================================
-- DỰ ÁN FLASHMART - SCRIPT KHẮC PHỤC TRUY VẤN BÁO CÁO
-- Tác giả: Data Engineer
-- =============================================================================

CREATE DATABASE IF NOT EXISTS flashmart_db;
USE flashmart_db;

-- -----------------------------------------------------------------------------
-- 1. TẠO BẢNG VÀ CHÈN DỮ LIỆU MẪU
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY, 
    name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY, 
    product_name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Chèn dữ liệu
INSERT INTO Customers VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'); 
-- Note: Charlie (id: 3) chưa từng mua hàng

INSERT INTO Products VALUES (101, 'Laptop'), (102, 'Mouse'), (103, 'Keyboard'); 
-- Note: Keyboard (id: 103) chưa từng được ai mua

INSERT INTO Orders VALUES (1001, 1, 101), (1002, 1, 102), (1003, 2, 101);

-- =============================================================================
-- 2. BÁO CÁO 1: DÀNH CHO GIÁM ĐỐC MARKETING (Sử dụng LEFT JOIN)
-- Yêu cầu: Đầy đủ tất cả khách hàng + số đơn hàng (Chưa mua = 0 đơn)
-- =============================================================================
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- =============================================================================
-- 3. BÁO CÁO 2: DÀNH CHO GIÁM ĐỐC KHO VẬN (Sử dụng Anti-Join với LEFT JOIN + IS NULL)
-- Yêu cầu: Danh sách các sản phẩm chưa từng được bán ra
-- =============================================================================
SELECT 
    p.product_id, 
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
