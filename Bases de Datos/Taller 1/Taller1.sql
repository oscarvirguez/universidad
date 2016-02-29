DROP TABLE JUGADORXEQUIPO;
DROP TABLE JUGADORES;
DROP TABLE EQUIPOS;
DROP TABLE PAISES;

CREATE TABLE PAISES
(
  CODIGOPAIS NUMERIC(3,0) PRIMARY KEY,
  NOMBREPAIS VARCHAR2(60) NOT NULL
);

CREATE TABLE EQUIPOS
(
  CODIGOEQUIPO NUMERIC(3,0) PRIMARY KEY,
  NOMBRE VARCHAR2(60) NOT NULL
);

CREATE TABLE JUGADORES
(
  CODIGOJUGADOR NUMERIC(3,0) PRIMARY KEY,
  NOMBRES VARCHAR2(60) NOT NULL,
  APELLIDOS VARCHAR2(60) NOT NULL,
  FECHA_NACIMIENTO DATE NOT NULL,
  VALORPASEACTUAL NUMERIC(12,0) NOT NULL,
  CODIGOPAIS NUMERIC(3,0) NOT NULL,
  FOREIGN KEY(CODIGOPAIS) REFERENCES PAISES
);

CREATE TABLE JUGADORXEQUIPO
(
  CODIGOEQUIPO NUMERIC(3,0),
  CODIGOJUGADOR NUMERIC(3,0),
  FECHADESDE DATE,
  FECHAHASTA DATE,
  PRIMARY KEY(CODIGOEQUIPO, CODIGOJUGADOR, FECHADESDE),
  FOREIGN KEY(CODIGOEQUIPO) REFERENCES EQUIPOS,
  FOREIGN KEY(CODIGOJUGADOR) REFERENCES JUGADORES
);

/*PAISES*/
INSERT INTO PAISES VALUES (000, 'BRASIL');
INSERT INTO PAISES VALUES (001, 'COLOMBIA');
INSERT INTO PAISES VALUES (002, 'ESPA�A');
INSERT INTO PAISES VALUES (003, 'INGLATERRA');
INSERT INTO PAISES VALUES (004, 'PORTUGAL');

/*EQUIPOS*/
INSERT INTO EQUIPOS VALUES (000, 'ARSENAL');
INSERT INTO EQUIPOS VALUES (001, 'BARCELONA');
INSERT INTO EQUIPOS VALUES (002, 'CHELSEA');
INSERT INTO EQUIPOS VALUES (003, 'REALMADRID');

/*JUGADORES*/
INSERT INTO JUGADORES VALUES (000, 'JAMES', 'RODRIGUEZ', TO_DATE('21/7/1991', 'DD/MM/YYYY'), 10000000, 001);
INSERT INTO JUGADORES VALUES (001, 'LUIS', 'FIGO', TO_DATE('4/11/1972', 'DD/MM/YYYY'), 50000000, 004);
INSERT INTO JUGADORES VALUES (002, 'RONALDO', 'LIMA', TO_DATE('2/9/1976', 'DD/MM/YYYY'), 7500000, 000);
INSERT INTO JUGADORES VALUES (003, 'FARYD', 'MONDRAGON', TO_DATE('21/6/1971', 'DD/MM/YYYY'), 4500000, 001);
INSERT INTO JUGADORES VALUES (004, 'JUAN', 'CUADRADO', TO_DATE('26/5/1988', 'DD/MM/YYYY'), 3500000, 001);

/*JUGADOR X EQUIPO*/
INSERT INTO JUGADORXEQUIPO VALUES (001, 002, TO_DATE('1/1/1996', 'DD/MM/YYYY'), TO_DATE('31/12/1997', 'DD/MM/YYYY'));
INSERT INTO JUGADORXEQUIPO VALUES (003, 002, TO_DATE('1/1/2002', 'DD/MM/YYYY'), TO_DATE('31/12/2007', 'DD/MM/YYYY'));
INSERT INTO JUGADORXEQUIPO VALUES (001, 001, TO_DATE('1/1/1995', 'DD/MM/YYYY'), TO_DATE('31/12/1999', 'DD/MM/YYYY'));
INSERT INTO JUGADORXEQUIPO VALUES (003, 001, TO_DATE('1/1/2000', 'DD/MM/YYYY'), TO_DATE('31/12/2004', 'DD/MM/YYYY'));
INSERT INTO JUGADORXEQUIPO(CODIGOEQUIPO, CODIGOJUGADOR, FECHADESDE) VALUES (003, 000, TO_DATE('1/1/2015', 'DD/MM/YYYY'));
INSERT INTO JUGADORXEQUIPO(CODIGOEQUIPO, CODIGOJUGADOR, FECHADESDE) VALUES (002, 004, TO_DATE('1/1/2015', 'DD/MM/YYYY'));

COMMIT;

/*FARYD MONDRAGON NO SALE PORQUE NO SE TIENEN DATOS DE TRANSFERENCIA*/
SELECT NOMBRES, APELLIDOS, NOMBRE, FECHADESDE, FECHAHASTA
  FROM EQUIPOS, JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORES.CODIGOJUGADOR = JUGADORXEQUIPO.CODIGOJUGADOR AND EQUIPOS.CODIGOEQUIPO = JUGADORXEQUIPO.CODIGOEQUIPO
  ORDER BY NOMBRE DESC;
  
SELECT NOMBRES, APELLIDOS, NOMBRE, FECHADESDE, FECHAHASTA
  FROM EQUIPOS, JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORES.CODIGOJUGADOR = JUGADORXEQUIPO.CODIGOJUGADOR AND EQUIPOS.CODIGOEQUIPO = JUGADORXEQUIPO.CODIGOEQUIPO
  ORDER BY NOMBRES ASC;
  
SELECT NOMBRES, APELLIDOS
  FROM JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 003 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR
MINUS
SELECT NOMBRES, APELLIDOS
  FROM JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 001 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR;

SELECT NOMBRES, APELLIDOS
  FROM JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 003 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR
INTERSECT
SELECT NOMBRES, APELLIDOS
  FROM JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 001 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR;
  
SELECT NOMBRES, APELLIDOS
  FROM JUGADORES, PAISES
  WHERE (LENGTH(NOMBRES) > 6 OR NOMBRES LIKE '%S') AND (JUGADORES.CODIGOPAIS = PAISES.CODIGOPAIS AND PAISES.NOMBREPAIS = UPPER('BRASIL'));
  
/*JUGADORES ANTES DE ACTUALIZAR EL VALORPASEACTUAL*/
SELECT NOMBRES, VALORPASEACTUAL
  FROM JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 003 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR;

UPDATE JUGADORES
  SET VALORPASEACTUAL = VALORPASEACTUAL * 1.045
  WHERE JUGADORES.VALORPASEACTUAL IN (SELECT VALORPASEACTUAL FROM JUGADORES, JUGADORXEQUIPO WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 003 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR);

/*JUGADORES DESPUES DE ACTUALIZAR EL VALORPASEACTUAL*/
SELECT NOMBRES, VALORPASEACTUAL
  FROM JUGADORES, JUGADORXEQUIPO
  WHERE JUGADORXEQUIPO.CODIGOEQUIPO = 003 AND JUGADORXEQUIPO.CODIGOJUGADOR = JUGADORES.CODIGOJUGADOR;