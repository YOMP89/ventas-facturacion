CREATE DATABASE VentasFacturacion;
USE VentasFacturacion;

-- Tabla de Clientes
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    correo VARCHAR(100)
);

-- Tabla de Productos
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0
);

-- Tabla de Facturas
CREATE TABLE Facturas (
    factura_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    fecha_factura DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Tabla de Detalles de Ventas
CREATE TABLE DetallesVentas (
    detalle_id INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES Facturas(factura_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);

-- Insertando clientes
INSERT INTO Clientes (nombre, direccion, telefono, correo) VALUES 
('Ana Martínez', 'Calle Falsa 123', '123456789', 'ana@gmail.com'),
('Luis García', 'Av. Siempre Viva 456', '987654321', 'luis@gmail.com');

-- Insertando productos
INSERT INTO Productos (nombre, descripcion, precio, stock) VALUES 
('Laptop', 'Laptop de 15 pulgadas con 8GB de RAM', 699.99, 20),
('Smartphone', 'Teléfono inteligente con pantalla táctil', 399.99, 50);

-- Insertando facturas
INSERT INTO Facturas (cliente_id, fecha_factura, total) VALUES 
(1, '2024-10-23', 1399.98),
(2, '2024-10-23', 399.99);

-- Insertando detalles de ventas
INSERT INTO DetallesVentas (factura_id, producto_id, cantidad, precio_unitario) VALUES 
(1, 1, 2, 699.99),  -- Ana compró 2 Laptops
(2, 2, 1, 399.99);   -- Luis compró 1 Smartphone

-- Listar todos los clientes
SELECT * FROM Clientes;

-- Verificar el stock de productos
SELECT nombre, stock FROM Productos;

-- Consultar facturas con sus clientes y montos totales
SELECT F.factura_id, C.nombre AS Cliente, F.fecha_factura, F.total
FROM Facturas F
JOIN Clientes C ON F.cliente_id = C.cliente_id;

-- Consultar detalles de una factura específica
SELECT DV.detalle_id, P.nombre AS Producto, DV.cantidad, DV.precio_unitario, (DV.cantidad * DV.precio_unitario) AS Subtotal
FROM DetallesVentas DV
JOIN Productos P ON DV.producto_id = P.producto_id
WHERE DV.factura_id = 1;  -- Detalles de la factura con ID 1

-- Calcular ingresos totales por producto
SELECT P.nombre AS Producto, SUM(DV.cantidad * DV.precio_unitario) AS IngresosTotales
FROM DetallesVentas DV
JOIN Productos P ON DV.producto_id = P.producto_id
GROUP BY P.nombre;
