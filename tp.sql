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
-- Ejercicio 3: Crear tabla mascotas
CREATE TABLE mascotas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE,
    id_dueno INT,
    FOREIGN KEY (id_dueno) REFERENCES duenos(id)
);
-- Ejercicio 4 - Crear tabla veterinarios
CREATE TABLE veterinarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    especialidad VARCHAR(50) NOT NULL
);
-- Ejercicio 5 - Crear tabla historial_clinico
CREATE TABLE historial_clinico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_mascota INT,
    id_veterinario INT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(250) NOT NULL,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id) ON DELETE CASCADE,
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id)
);
-- Ejercicio 6 - Insertar registros
-- 3 dueños
INSERT INTO duenos (nombre, apellido, telefono, direccion)
VALUES ('Laura', 'Perez', '1123335467', 'Arenales 2987'),
    ('Julio', 'Zambrano', '112345678', 'Florida 456'),
    ('Lucía', 'Vera', '113456789', 'Laprida 789');
-- 3 mascotas 
INSERT INTO mascotas (nombre, especie, fecha_nacimiento, id_dueno)
VALUES ('Bubi', 'Gato', '2020-05-10', 1),
    -- Dueña: Laura
    ('Pancito Bebe', 'Gato', '2019-08-22', 2),
    -- Dueño: Julio
    ('Manchita', 'Perro', '2021-01-15', 3);
-- Dueña: Lucía
-- 2 veterinarios con especialidades distintas
INSERT INTO veterinarios (nombre, apellido, matricula, especialidad)
VALUES ('Alan', 'Martínez', 'MAT123', 'Cirugía'),
    ('Josefina', 'Aguero', 'MAT456', 'Clinica');
-- 3 registros de historial clínico
INSERT INTO historial_clinico (id_mascota, id_veterinario, descripcion)
VALUES (1, 1, 'Vacunación anual'),
    (2, 2, 'Desparasitación'),
    (3, 1, 'Cirugía de esterilización');
-- Ejercicio 7 - Update
--1) Cambiar la dirección de un dueño (por ID)
UPDATE duenos
SET direccion = 'Av. Nazca 788'
WHERE id = 1;
--2) Actualizar la especialidad de un veterinario (por matrícula).
UPDATE veterinarios
SET especialidad = 'Tecnico Laboratorio'
WHERE matricula = 'MAT456';
--3) Editar la descripción de un historial clínico (por ID)
UPDATE historial_clinico
SET descripcion = 'Chequeo general'
WHERE id = 2;
-- Ejercicio 8 -
--1) Eliminar una mascota (por nombre)
DELETE FROM mascotas
WHERE nombre = 'Manchita';
--Se elimino la mascota y su historial clinico.
-- Ejercicio 9  JOIN Simple
SELECT m.nombre AS NombreMascota,
    m.especie AS Especie,
    CONCAT(d.nombre, ' ', d.apellido) AS NombreCompletoDueño
FROM mascotas m
    JOIN duenos d ON m.id_dueno = d.id
WHERE m.nombre = 'Bubi';
-- Ejercicio 10 JOIN múltiple con historial
SELECT m.nombre AS NombreMascota,
    m.especie AS Especie,
    CONCAT(d.nombre, ' ', d.apellido) AS NombreCompletoDueño,
    CONCAT(v.nombre, ' ', v.apellido) AS NombreCompletoVeterinario,
    h.fecha_registro AS FechaRegistro,
    h.descripcion AS Descripcion
FROM historial_clinico h
    JOIN mascotas m ON h.id_mascota = m.id
    JOIN duenos d ON m.id_dueno = d.id
    JOIN veterinarios v ON h.id_veterinario = v.id
ORDER BY h.fecha_registro DESC;