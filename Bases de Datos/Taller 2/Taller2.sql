DROP TABLE TITULARES;
DROP TABLE CUENTAS;
DROP TABLE OFICINAS;
DROP TABLE CLIENTES;

CREATE TABLE CLIENTES
(
  CODIGO NUMERIC(3,0) PRIMARY KEY,
  NOMBRE VARCHAR2(60),
  APELLIDO VARCHAR2(60),
  FECHA_NACIMIENTO DATE,
  EMAIL VARCHAR2(60)
);

CREATE TABLE OFICINAS
(
  CODIGO NUMERIC(3,0) PRIMARY KEY,
  NOMBRE VARCHAR2(60),
  BARRIO VARCHAR2(60)
);

CREATE TABLE CUENTAS
(
  NUMERO NUMERIC(3,0) PRIMARY KEY,
  TIPO CHAR(2),
  SALDO NUMERIC(10,2),
  CODIGO_OFICINA NUMERIC(3,0),
  FOREIGN KEY (CODIGO_OFICINA) REFERENCES OFICINAS
);

CREATE TABLE TITULARES
(
  CODIGO_CLIENTE NUMERIC(3,0),
  NUMERO_CUENTA NUMERIC(3,0),
  PRIMARY KEY (CODIGO_CLIENTE, NUMERO_CUENTA),
  FOREIGN KEY (CODIGO_CLIENTE) REFERENCES CLIENTES,
  FOREIGN KEY (NUMERO_CUENTA) REFERENCES CUENTAS
);

/*CLIENTES*/
INSERT INTO CLIENTES VALUES (1, 'PEDRO', 'PEREZ', TO_DATE('18/01/1980', 'DD/MM/YYYY'), 'pperez@hotmail.com'); 
INSERT INTO CLIENTES VALUES (2, 'MARIA', 'RESTREPO', TO_DATE('18/02/1970', 'DD/MM/YYYY'), 'mrestre@gmail.com'); 
INSERT INTO CLIENTES VALUES (3, 'JUAN', 'ARIAS', TO_DATE('18/03/1990', 'DD/MM/YYYY'), 'jarias@javeriana.edu.co'); 
INSERT INTO CLIENTES VALUES (4, 'CARLOS', 'LOZANO', TO_DATE('18/04/2000', 'DD/MM/YYYY'), 'clozano@gmail.com'); 
INSERT INTO CLIENTES VALUES (5, 'ESTEBAN', 'GONZALES', TO_DATE('18/02/2001', 'DD/MM/YYYY'), 'egonzales@gmail.com'); 
INSERT INTO CLIENTES VALUES (6, 'JOHN', 'HURTADO', TO_DATE('20/02/1970', 'DD/MM/YYYY'), 'jhurtado@hotmail.com'); 

/*OFICINAS*/
INSERT INTO OFICINAS VALUES (10, 'JAVERIANA', 'JAVERIANA');
INSERT INTO OFICINAS VALUES (20, 'GALERIAS', 'GALERIAS');

/*CUENTAS*/
INSERT INTO CUENTAS VALUES (100, 'A', 100000, 10);
INSERT INTO CUENTAS VALUES (200, 'A', 1000, 20);
INSERT INTO CUENTAS VALUES (300, 'C', 50000, 10);
INSERT INTO CUENTAS VALUES (400, 'C', 80000, 10);
INSERT INTO CUENTAS VALUES (500, 'A', 22500, 10);
INSERT INTO CUENTAS VALUES (600, 'A', 2500, 20);

/*TITULARES*/
INSERT INTO TITULARES VALUES (1, 100);
INSERT INTO TITULARES VALUES (1, 200);
INSERT INTO TITULARES VALUES (2, 100);
INSERT INTO TITULARES VALUES (2, 200);
INSERT INTO TITULARES VALUES (3, 300);
INSERT INTO TITULARES VALUES (4, 400);
INSERT INTO TITULARES VALUES (5, 500);
INSERT INTO TITULARES VALUES (6, 600);

COMMIT;

/*CONSULTAS*/
WITH AVG_GENERAL AS 
  (SELECT AVG(CUENTAS.SALDO) AS PROMEDIO_CUENTAS
    FROM CUENTAS),
     AVG_OFICINA AS
  (SELECT OFICINAS.CODIGO, OFICINAS.NOMBRE, AVG(CUENTAS.SALDO) AS PROMEDIO_OFICINA
    FROM OFICINAS, CUENTAS
    WHERE OFICINAS.CODIGO = CUENTAS.CODIGO_OFICINA
    GROUP BY OFICINAS.CODIGO, OFICINAS.NOMBRE)
SELECT *
  FROM AVG_GENERAL, AVG_OFICINA
  WHERE AVG_OFICINA.PROMEDIO_OFICINA > AVG_GENERAL.PROMEDIO_CUENTAS;

WITH CLIENTESXTITULARES AS
  (SELECT DISTINCT CLIENTES.CODIGO AS CCOD, TITULARES.NUMERO_CUENTA AS NUMC, CLIENTES.FECHA_NACIMIENTO AS CFN
    FROM CLIENTES, TITULARES
    WHERE CLIENTES.CODIGO = TITULARES.CODIGO_CLIENTE),
     CUENTASXTITULARES AS
  (SELECT DISTINCT CODIGO_OFICINA AS OCOD, CUENTAS.NUMERO AS CNUM, CUENTAS.SALDO, CUENTAS.TIPO
    FROM CUENTAS, TITULARES
    WHERE CUENTAS.NUMERO = TITULARES.NUMERO_CUENTA),
     ITXCT AS
  (SELECT DISTINCT COUNT(CNUM), MAX(CFN), MIN(CFN) 
    FROM CLIENTESXTITULARES, CUENTASXTITULARES
    WHERE CLIENTESXTITULARES.NUMC = CUENTASXTITULARES.CNUM AND OCOD = 10)
SELECT *
  FROM ITXCT;