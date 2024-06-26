-- Tablas
CREATE TABLE Pais (
    Pais VARCHAR(5) PRIMARY KEY,
    NomPais VARCHAR(250)
);

CREATE TABLE Departamento (
    Pais VARCHAR(5),
    Depto VARCHAR(5),
    NomDepto VARCHAR(250),
    PRIMARY KEY (Pais, Depto),
    FOREIGN KEY (Pais) REFERENCES Pais(Pais)
);


CREATE TABLE Persona (
    IdPersona SERIAL PRIMARY KEY,
    NombreCompleto VARCHAR(100),
    Pais VARCHAR(5),
    Departamento VARCHAR(5),
    Direccion VARCHAR(100),
    FOREIGN KEY (Pais) REFERENCES Pais(Pais),
    FOREIGN KEY (Pais, Departamento) REFERENCES Departamento(Pais, Depto)
);


-- Consulta Seleccion Todos
SELECT IdPersona, NombreCompleto, Direccion, NomPais, NomDepto
FROM Persona
JOIN Pais ON Persona.Pais = Pais.Pais
JOIN Departamento ON Persona.Departamento = Departamento.Depto AND Persona.Pais = Departamento.Pais;


SELECT IdPersona, NombreCompleto, Direccion, NomPais, NomDepto FROM Persona JOIN Pais ON Persona.Pais = Pais.Pais JOIN Departamento ON Persona.Departamento = Departamento.Depto AND Persona.Pais = Departamento.Pais

---

-- Consultar Solo Paises
SELECT NomPais FROM Pais

-- Consultar Solo Departamentos
SELECT NomDepto FROM Departamento
