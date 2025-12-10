-- Ejercicio 1: Crear base de datos
CREATE DATABASE veterinaria_patitas_felices;
USE veterinaria_patitas_felices;

-- Ejercicio 2: Crear tabla duenos
CREATE TABLE duenos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100)
);
