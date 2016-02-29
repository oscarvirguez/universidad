/*
  Proyecto Bases de Datos
  Entrega #2
  
  Integrantes:
    Arciniegas Rodolfo
    Guayara Cesar Alejandro
*/

DROP TABLE LISTA_DE_VISITA;
DROP TABLE IMAGEN;
DROP TABLE PROPIEDAD;
DROP TABLE CIUDAD;
DROP TABLE COMPRADOR;
DROP TABLE PROPIETARIO;
DROP TABLE USUARIO;

CREATE TABLE USUARIO
(
  CEDULA NUMERIC(10,0) PRIMARY KEY,
  NOMBRE VARCHAR2(60),
  APELLIDO VARCHAR2(60),
  CORREO VARCHAR2(60)
);

CREATE TABLE PROPIETARIO
(
  IDP NUMERIC(3,0) PRIMARY KEY,
  CEDULA NUMERIC(10,0),
  USUARIO VARCHAR2(60),
  CONTRASENA VARCHAR2(60),
  FOREIGN KEY (CEDULA) REFERENCES USUARIO
);

CREATE TABLE COMPRADOR
(
    IDC NUMERIC(3,0) PRIMARY KEY,
    CEDULA NUMERIC(10,0),
    USUARIO VARCHAR2(60),
    CONTRASENA VARCHAR2(60),
    FOREIGN KEY (CEDULA) REFERENCES USUARIO
);

CREATE TABLE CIUDAD
(
  COD_CIUDAD NUMERIC(3,0) PRIMARY KEY,
  NOMBRE VARCHAR2(60)
);

CREATE TABLE PROPIEDAD
(
  ID_PROPIEDAD NUMERIC(3,0) PRIMARY KEY,
  TIPO VARCHAR2(60),
  NUM_HABITACIONES NUMERIC(2,0),
  COD_CIUDAD NUMERIC(3,0),
  DIRECCION VARCHAR2(60),
  ESTADO NUMERIC(1,0),
  PRECIO_RENTA NUMERIC(6,0),
  IDP NUMERIC(3,0),
  IDC NUMERIC(3,0),
  FOREIGN KEY (COD_CIUDAD) REFERENCES CIUDAD,
  FOREIGN KEY (IDP) REFERENCES PROPIETARIO,
  FOREIGN KEY (IDC) REFERENCES COMPRADOR,
  CONSTRAINT CTIPO CHECK (UPPER(TIPO) IN ('APARTAMENTO','CASA'))
);

CREATE TABLE IMAGEN
(
  ID_PROPIEDAD NUMERIC(3,0),
  LINK_IMAGEN VARCHAR2(60),
  DESCRIPCION VARCHAR2(120),
  FECHA DATE,
  FOREIGN KEY (ID_PROPIEDAD) REFERENCES PROPIEDAD
);

CREATE TABLE LISTA_DE_VISITA
(
  ID_PROPIEDAD NUMERIC(3,0),
  IDC NUMERIC(3,0),
  FECHA DATE,
  FOREIGN KEY (ID_PROPIEDAD) REFERENCES PROPIEDAD,
  FOREIGN KEY (IDC) REFERENCES COMPRADOR,
  PRIMARY KEY (ID_PROPIEDAD, IDC)
);

INSERT INTO USUARIO VALUES (27703459,'nombre0','apellido0','correo0');
INSERT INTO USUARIO VALUES (57605168,'nombre1','apellido1','correo1');
INSERT INTO USUARIO VALUES (43228655,'nombre2','apellido2','correo2');
INSERT INTO USUARIO VALUES (83013739,'nombre3','apellido3','correo3');
INSERT INTO USUARIO VALUES (68184030,'nombre4','apellido4','correo4');
INSERT INTO USUARIO VALUES (27532933,'nombre5','apellido5','correo5');
INSERT INTO USUARIO VALUES (56647865,'nombre6','apellido6','correo6');
INSERT INTO USUARIO VALUES (49566057,'nombre7','apellido7','correo7');
INSERT INTO USUARIO VALUES (80289448,'nombre8','apellido8','correo8');
INSERT INTO USUARIO VALUES (52250928,'nombre9','apellido9','correo9');

INSERT INTO PROPIETARIO VALUES (0,27703459,'user0','contrasena0'); 
INSERT INTO PROPIETARIO VALUES (1,57605168,'user1','contrasena1'); 
INSERT INTO PROPIETARIO VALUES (2,43228655,'user2','contrasena2'); 
INSERT INTO PROPIETARIO VALUES (3,83013739,'user3','contrasena3'); 
INSERT INTO PROPIETARIO VALUES (4,68184030,'user4','contrasena4'); 
INSERT INTO PROPIETARIO VALUES (5,27532933,'user5','contrasena5'); 
INSERT INTO PROPIETARIO VALUES (6,49566057,'user6','contrasena6'); 
INSERT INTO PROPIETARIO VALUES (7,80289448,'user7','contrasena7'); 
INSERT INTO PROPIETARIO VALUES (8,56647865,'user8','contrasena8'); 
INSERT INTO PROPIETARIO VALUES (9,52250928,'user9','contrasena9');

INSERT INTO COMPRADOR VALUES (0,27703459,'user0','contraseña0'); 
INSERT INTO COMPRADOR VALUES (1,57605168,'user1','contraseña1'); 
INSERT INTO COMPRADOR VALUES (2,43228655,'user2','contraseña2'); 
INSERT INTO COMPRADOR VALUES (3,83013739,'user3','contraseña3'); 
INSERT INTO COMPRADOR VALUES (4,68184030,'user4','contraseña4'); 
INSERT INTO COMPRADOR VALUES (5,27532933,'user5','contraseña5'); 
INSERT INTO COMPRADOR VALUES (6,49566057,'user6','contraseña6'); 
INSERT INTO COMPRADOR VALUES (7,80289448,'user7','contraseña7'); 
INSERT INTO COMPRADOR VALUES (8,56647865,'user8','contraseña8'); 
INSERT INTO COMPRADOR VALUES (9,52250928,'user9','contraseña9');

INSERT INTO CIUDAD VALUES (0,'Bogota');
INSERT INTO CIUDAD VALUES (1,'Medellin');
INSERT INTO CIUDAD VALUES (2,'Quibdo');
INSERT INTO CIUDAD VALUES (3,'Pasto');
INSERT INTO CIUDAD VALUES (4,'Armenia');
INSERT INTO CIUDAD VALUES (5,'Choconta');
INSERT INTO CIUDAD VALUES (6,'Aeria');

INSERT INTO PROPIEDAD VALUES (0,'casa',5,0,'Calle Falsa # 123',0,321354,0,NULL); 
INSERT INTO PROPIEDAD VALUES (1,'apartamento',2,1,'Carrera 45 # 10',1,45678,1,NULL); 
INSERT INTO PROPIEDAD VALUES (2,'casa',6,2,'Calle 85 # 6',2,159327,2,NULL); 
INSERT INTO PROPIEDAD VALUES (3,'apartamento',1,3,'Carrera 150 # 52',0,957153,3,NULL); 
INSERT INTO PROPIEDAD VALUES (4,'casa',0,4,'Calle 1 # 1',1,362489,4,NULL);

INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/1462120931','descripcion0',TO_DATE('18-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (1,'www.imagenes.net/-2064621811','descripcion1',TO_DATE('27-3-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/509228397','descripcion2',TO_DATE('17-6-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/1385540856','descripcion3',TO_DATE('21-6-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/678204634','descripcion4',TO_DATE('5-12-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (0,'www.imagenes.net/1169041562','descripcion5',TO_DATE('23-4-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/905859963','descripcion6',TO_DATE('26-3-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/432752165','descripcion7',TO_DATE('15-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (1,'www.imagenes.net/1532248709','descripcion8',TO_DATE('27-2-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/1089913328','descripcion9',TO_DATE('5-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (1,'www.imagenes.net/-1884989042','descripcion10',TO_DATE('28-5-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/817758453','descripcion11',TO_DATE('12-4-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/430677780','descripcion12',TO_DATE('14-7-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/-736558766','descripcion13',TO_DATE('9-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (1,'www.imagenes.net/-1455841034','descripcion14',TO_DATE('19-1-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (1,'www.imagenes.net/-334570808','descripcion15',TO_DATE('21-6-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (0,'www.imagenes.net/1675001081','descripcion16',TO_DATE('16-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/-1019621569','descripcion17',TO_DATE('13-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (2,'www.imagenes.net/681736516','descripcion18',TO_DATE('16-8-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (0,'www.imagenes.net/982313792','descripcion19',TO_DATE('22-2-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (4,'www.imagenes.net/-704238364','descripcion20',TO_DATE('12-7-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/-537053575','descripcion21',TO_DATE('4-7-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (2,'www.imagenes.net/1777219657','descripcion22',TO_DATE('11-9-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (3,'www.imagenes.net/1911583805','descripcion23',TO_DATE('8-6-2015','dd-mm-yyyy'));
INSERT INTO IMAGEN VALUES (1,'www.imagenes.net/1804963271','descripcion24',TO_DATE('9-7-2015','dd-mm-yyyy'));

INSERT INTO LISTA_DE_VISITA VALUES (1,4,TO_DATE('18-9-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (4,1,TO_DATE('15-11-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (3,5,TO_DATE('25-9-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (4,0,TO_DATE('14-12-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (2,5,TO_DATE('21-5-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (2,6,TO_DATE('2-10-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (1,8,TO_DATE('18-10-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (2,0,TO_DATE('7-11-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (4,3,TO_DATE('20-10-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (3,1,TO_DATE('3-10-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (3,2,TO_DATE('9-4-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (4,6,TO_DATE('12-11-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (3,6,TO_DATE('20-5-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (4,2,TO_DATE('23-7-2015','dd-mm-yyyy'));
INSERT INTO LISTA_DE_VISITA VALUES (1,0,TO_DATE('11-11-2015','dd-mm-yyyy'));

COMMIT;

/* Sentencias SQL */

/* 
  NOTA -- Los datos a utilizar son aleatorios, se entiende que las sentencias deben ser generales y por tal razon los datos aunque cambien
           deberan seguir funcionando.
*/

/* 
  Search Properties / View Properties
  
   Valores a Utilizar:
   - Renta Mayor A: 0
   - Renta Menor A: 9999999
   - Tipo de Propiedad: casa
   - Ciudad: Vacio
*/

select ID_PROPIEDAD , DESCRIPCION, FECHA,COD_CIUDAD, imagen.link_imagen
from PROPIEDAD  JOIN IMAGEN USING (ID_PROPIEDAD)
where ESTADO != 0 AND COD_CIUDAD IN (0,2) AND TIPO LIKE '%'  AND 	NUM_HABITACIONES BETWEEN 0 AND 15 AND propiedad.precio_renta BETWEEN 0 AND 9999999;

/*
  Browse properties By Location / View Properties
  
  Valores a Utilzar:
  - Ciudad: bogota 
*/
WITH CID AS
  (SELECT CIUDAD.COD_CIUDAD CIID, PROPIEDAD.ID_PROPIEDAD
    FROM CIUDAD, PROPIEDAD
    WHERE NOMBRE = 'Bogota' AND CIUDAD.COD_CIUDAD = PROPIEDAD.COD_CIUDAD AND PROPIEDAD.ESTADO != 2)
SELECT CID.ID_PROPIEDAD, IMG.LINK_IMAGEN, IMG.DESCRIPCION, IMG.FECHA
  FROM CID, IMAGEN IMG
  WHERE CID.ID_PROPIEDAD = IMG.ID_PROPIEDAD;

/*
  Owner View Properties
  
  Valores a Utilizar:
  - username: user0
  - password: contrasena0
*/
WITH PIID AS
  (SELECT IDP
    FROM PROPIETARIO
    WHERE USUARIO = 'user0' AND CONTRASENA = 'contrasena0')
SELECT PROP.TIPO, PROP.DIRECCION, PROP.NUM_HABITACIONES, PROP.PRECIO_RENTA, PROP.ESTADO
  FROM PIID, PROPIEDAD PROP
  WHERE PIID.IDP = PROP.IDP;
 
/*
  View Visit History
  
  Valores a Utilizar:
  - usuario: user4
  - password: contrasena4
  - mesInicio: 3
  - mesFin: 9
*/
WITH PIID AS
  (SELECT IDP
    FROM PROPIETARIO
    WHERE USUARIO = 'user4' AND CONTRASENA = 'contrasena4'),
    COMP AS
  (SELECT ID_PROPIEDAD, FECHA
    FROM LISTA_DE_VISITA
    WHERE FECHA > TO_DATE('1-3-2015','dd-mm-yyyy') AND FECHA < TO_DATE('30-9-2015','dd-mm-yyyy')
    ORDER BY ID_PROPIEDAD),
    CPXPR AS
  (SELECT PROP.IDP, PROP.ID_PROPIEDAD, COMP.FECHA
    FROM PROPIEDAD PROP, COMP
    WHERE PROP.ID_PROPIEDAD = COMP.ID_PROPIEDAD),
    FIN AS
  (SELECT ID_PROPIEDAD, FECHA
    FROM CPXPR, PIID
    WHERE PIID.IDP = CPXPR.IDP),
    CONT AS
  (SELECT ID_PROPIEDAD AS "ID PROPIEDAD", COUNT(ID_PROPIEDAD) AS "VECES VISITADA"
    FROM FIN
    GROUP BY ID_PROPIEDAD),
    TOT AS
  (SELECT NULL, COUNT(*)
    FROM CONT)
SELECT *
  FROM CONT
UNION
SELECT *
  FROM TOT;
 
/*
  View Visiting List
  
  Valores a Utilizar:
  
  - Id Comprador: 5
*/
with vlc as(
SELECT * -- LINK_IMAGEN, TIPO, DIRECCION, cod_CIUDAD, NUM_HABITACIONES, PRECIO_RENTA
FROM (select * from comprador where idc = 5) 
 JOIN  LISTA_DE_VISITA using (IDC)
 )
 select LINK_IMAGEN, TIPO, DIRECCION, cod_CIUDAD, NUM_HABITACIONES, PRECIO_RENTA
 from vlc 
 JOIN PROPIEDAD USING (ID_PROPIEDAD)
 JOIN IMAGEN USING (ID_PROPIEDAD)
 where estado !=0;