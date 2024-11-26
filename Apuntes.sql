x-- modificacion de datos
update nombre_tabla 
-- cambiar la comision de todos los empleados a 500€
-- 1- comprobamos la comision de los empleados
select nom_emp, com_emp from emp;
-- 2- actualizamos la comisioon de todos los empleados a 500€
update emp set com_emp=500
-- 3- comprobamos la comision de los empleados
select nom_emp, com_emp from emp;
-- cambiar la comision de los empleados del departamento 1 a 600€
update emp set com_emp=600 where ide_dep=1
-- comprobamos la comision de empleados
select nom_emp, com_emp from emp;

-- Mostrar los datos sin que se repitan los valores
select distinct nombre_campo from nombre_tabla;
select distinct loc_cen from cen;

-- Limitar el número de registros que devuelve una consulta
select * from nombre_tabla limit 2;

-- Obtener el nombre de los dos primeros empleados
select nom_emp from emp limit 2;

-- Obtener el valor númerico más alto
select max(nombre_campo) from nombre_tabla;

-- Obtener el valor númerico más bajo
select min(nombre_campo) from nombre_tabla;

-- obtener el numero de registros (computa los NULL)
select count(*) from nombre_tabla;

-- obtener el numero de registros (no computa los NULL)
select count (nombre_campo) from nombre_tabla; 

-- indica el numero de empleados que actualmente trabajan en la empresa
select count(*) from emp;

-- indica el numero de empleados que actualmente cobran comision
select count(com_emp) from emp;

-- indica el promedio de los valores de un campo
select avg(campo) from tabla;

-- indicar la suma de los valores de un campo
select sum(campo) from tabla;

-- mostras busquedas con un criterio exacto
select * from tabla where campo=x;

-- Para busquedas aproximadas tenemos el uso de LIKE
select nom_emp from emp where nom_emp like '%a%';

-- Para busquedas con mas de un criterio (siendo flexible, muestra si aparece aunque sea uno de los criterios puestos)
select * from t1 where c1=x or c1=y or c1=x
select * from t1 where c1 in (x, y, z);
select * from emp where nom_emp='Ana' or nom_emp='Javi' or nom_emp='Luis';
select * from emp where nom_emp in ('Ana', 'Javi', 'Luis');

-- Mostrar el nombre de los empleados que trabajan en el dep.1 y 2
select nom_emp from emp where ide_dep in (1, 2);

-- Mostrar el nombre de los empleados que no trabajan en el dep.1 y 2
select nom_emp from emp where ide_dep not in (1, 2);
select ide_dep, nom_emp from emp where ide_dep!=1 and ide_dep!=2;

-- mostrar dentro de un rango
select * from t1 where c1>=10 and cp<=20;
select * from t1 where c1 between 10 and 20

-- mostrar el nombre y salario de los empleados que ganen entre 1500 y 2000
select nom_emp, sal_emp  from emp where sal_emp>=1500 and sal_emp<=2000;
select nom_emp, sal_emp  from emp where sal_emp between 1500 and 2000;

-- mostrar el nombre y salario de los empleados que ganen entre 1500 y 2000
select nom_emp, sal_emp  from emp where sal_emp<1500 and sal_emp>2000;
select nom_emp, sal_emp  from emp where sal_emp not between 1500 or 2000;

-- Alias para los campos
select c1 alias1, c2 alias 2 from t1;
select c1 'alias 1', c2 'alias 2' 2 from t1;
select c1 as 'alias 1', c2 as 'alias 2' 2 from t1;

-- mostrar el nombre completo de los empleados de un modo comprensible
select nom_emp nombre, ap1_emp as 'primer apellido', ap2_emp as 'segundo apellido' from emp;

-- Es posible realizar una consulta sobre una misma tabla o mas de una tabla a traves de las JOIN (union)
    -- Este por ejemplo es por medio de dos consultas (select), por lo que no estamos ante una JOIN
        select * from t1;
        select * from t2;
    -- En este caso si estamos ante una JOIN que con una consulta (select) ofrece datos de dos o mas tablas (en este caso sobre dos tablas: t1 y t2)
        select * from t1,t2 where t1.c1=t2.c2
        select * from  cen, dep where cen.ide_cen=dep.ide_cen;
        select nom_cen, nom_dep from cen, dep where cen.ide_cen=dep.ide_cen;


--                      TIPOS DE JOINS (ESTILO ANTIGUO)

-- Inner JOIN -> 
    select * from  cen, dep where cen.ide_cen=dep.ide_cen;
    select nom_cen, nom_dep from cen, dep where cen.ide_cen=dep.ide_cen;
    -- ejercicio -> seleccionar el nombre de todos los centros conjunto al nombre de todos los departamentos y empleados:
    resultado -> select nom_cen, nom_dep, nom_emp from cen, dep, emp where cen.ide_cen=dep.ide_cen and dep.ide_dep=emp.ide_dep;

--                      TIPOS DE JOINS (NUEVO ESTILO) en (SGBDR)

-- 1. internas (INNER JOIN) 
        select * from t1 inner join t2 on  t1.c1=t2.c1
            select nom_cen, nom_dep, nom_emp from cen, dep, emp where cen.ide_cen=dep.ide_cen and dep.ide_dep=emp.ide_dep;
        select * from t1 inner join t2 on t1.c1=t2.c1 inner join on t3 t2.c2=t3.c2
            select * from cen inner join dep on cen.ide_cen=dep.ide_cen inner join emp on dep.ide_dep=emp.ide_dep;
-- 2. externas a izquierda (LEFT [OUTER] JOIN )
        select nom_cen, nom_dep from cen left outer join dep on cen.ide_cen=dep.ide_cen;
-- 3. externas a derecha (RIGHT [OUTER] JOIN) ->
        select nom_cen, nom_dep from cen right outer join dep on cen.ide_cen=dep.ide_cen;
-- 3. SELF join (realizar una join de la misma tabla)
        select tabla1.c1, tabla2.c2 from  t1 tabla1 inner join  t1 tabla2 on tabla1.c1=tabla2.c1 -- siendo t1 y t2 los alias de tabla1 y tabla2 

-- consulta para una escala
select 
t1.com_vue as 'compañia 1',
t1.ori_vue as 'origen 1',
t1.des_vue as 'destino 1',
t1.pvp_vue as 'precio 1',
t2.com_vue as 'compañia 2',
t2.ori_vue as 'origen 2',
t2.des_vue as 'destino 2',
t2.pvp_vue as 'precio 2',
t1.pvp_vue + t2.pvp_vue as 'precio total'
from vuelos t1 
inner join vuelos t2
on t1.des_vue=t2.ori_vue -- donde el destino del primer vuelo es el origen del segundo vuelo (Ya que tiene escala)
where t1.ori_vue='Madrid'
and t2.des_vue='Moscu'
order by 9 -- 9 es la posicion del campo del precio total, para poder referirte a el ya que al ser una suma no lo coge
           -- si no pones nada detras de "order by" predeterminadamente te lo hace ASCendente

-- Definir una tabla para almacenar productos teniendo en cuenta que vamos a necesitar en el futuro realizar campaña promocionales de productos "sin iva"
-- Tipos IVA 
    21% tipo general1
    10% tipo reducido1
    5% tipo reducido2
    0% tipo reducido3

NO - select no cambia los datos
NO - insert inserta nuevos registros
NO - alter modifica estructuralmente las tablas pero no sus datos
SI - update permite modificar datos en los registros

-- QUITAR IVA 
update pro set pvp_pro=pvp_pro*(1-(iva_pro/100));
-- PONER IVA
update pro set pvp_pro=pvp_pro/(1-(iva_pro/100));

-- GROUP BY 
--> agrupa datos en combinacion con una funcion escalar (se usa SIEMPRE con: count, max, min, avg ...)
    -- sintaxis
            select campo1, count(campo2) from t1 group by c1 -- el "COUNT(*) cuenta el total de registros en una  tabla"
            select t1.c1, count(t2.c2) from t1 inner join t2 on t1.c1=t2.c2 group by t1.c1;
-- muestra el numero de personas que hay en cada departamento
select ide_dep, count(*) 'numero de empleados' from emp group by ide_dep;
-- muestra el numero de personas que hay en cada departamento indicando el nombre de cada departamento (en vez de su id)
select nom_dep, count(emp.ide_emp) 'numero de empleados' 
from dep 
inner join emp 
on dep.ide_dep=emp.ide_dep 
group by emp.ide_dep;

-- HAVING
-- permite filtrar de acuerdo a un criterio, un conjunto de datos al usar group by que pueden haber sido tambien filtrados antes por un where.
select c1, count(c2) from t1 where c1=X group by c1 having c3=Y order by c1;
-- mostrar el numero de personas que hay en cada departamento, pero solo para los departamentos 1 y 2, en el caso de que en cada departamento el salario mas bajo supere el valor de 1100.
select ide_dep, count(*) 'numero de empleados' 
from emp 
where ide_dep in(1,2) 
group by ide_dep 
having min(sal_emp)>1100

-- EXISTS
-- Muestra los datos siempre que la subconsulta devuelva datos
select c1, c2 from t1 where EXISTS (select c1 from t1 where c1>x)
-- mostrar el nombre del empleado que tiene el salario mas alto
    -- 1. Localizar salario mas alto
        select max(sal_emp) from emp;
    -- 2.Obtener el nombre en relacion al salario mas alto
        select nom_emp 'nombre de empleado', sal_emp 'salario maximo' from emp where sal_emp=(select max(sal_emp) from emp)
-- Mostrar los datos de los empleados, siempre que existan centros en la localidad de madrid
select * from emp where exists (select ide_cen from cen where loc_cen='madrid')
-- mostras los datos de los empleados siempre que no existan centros en la localidad de sevilla
select * from emp where not exists (select ide_cen from cen where loc_cen='sevilla')

-- ANY y ALL
-->permite ejecutar una consulta siempre que la subconsulta devuelva algun dato (any) o todos los datos (all)
select c1, c2 from t1 where c1 = any|all (select c1 from t1 where c1=x);
-- mostrar los ides de los departamentos y los nombres de los empleados que tenga salareios mayores que el salario mas BAJO de los empelados del departamento 1
select ide_dep, nom_emp from emp where ide_dep!=1 and sal_emp>any (select min(sal_emp) from emp where ide_dep=1);
-- muestra los ides de los departamentos y los nombres de los empleados que tenga salarios mayores que el salario mas alto de los empleados del departamento 1

-- SELECT INTO 
-- (no funciona en MySQL) --> no es necesario crear previamente la tabla destino
--> permite realizar una copia masiva de datos teniendo como fuente de estos datos un o varios tablas a partir de las cuales se recopila el conjunto o una parte de los campos que las componen.
-- sintaxis
select * into tabla_destino from tabla_origen where


-- INSERT SELECT 
-- (si funciona en MySQL) --> es necesario crear previamente la tabla destino
--> permite realizar una copia masiva de datos teniendo como fuente de estos datos un o varios tablas a partir de las cuales se recopila el conjunto o una parte de los campos que las componen.
-- sintaxis 
insert into tabla_destino (c2, c3) select c2, c3 from tabla orgien where ...

create table if not exists emp2
(
    ide_emp int unsigned,
    nom_emp varchar (50),
    ap1_emp varchar (50),
    ap2_emp varchar (50)
);

-- ESTRUCTURAS DE CONTROL DE FLUJO
-- CASE permite mostrar datos cuando se cumple el caso expresado
-- sintaxis
select c1
CASE 
    when c2=x then 'mensaje 1'
    when c2=y then 'mensaje 2'
    else 'mensaje 3'
end 'Alias de campo CAse'
from t1


-- NULL
-- null no es un dato es un estado
-- evaluar un null MAL:                 -evaluar  un null BIEN
select * from t1 where c1=null          select * from t1 where c1 IS null

-- IFNULL, COALESCE, NVL
-- permite sustituir el estado NULL por un valor para poder realizar una operacion
-- sintaxis
select ifnull (c1, 0) + ifnull (c2, 0 ) from t1;
-- suma el salario y la comision de los empleados, evitando errores de calculo en los casos en los que existan estados NULL
 select nom_emp, ifnull (sal_emp, 0) + ifnull (com_emp, 0 ) as 'Salario total' from emp;


-- EJERCICIO 2 RESUELTO 2DO TRIMESTRE

-- 1.
select nom_emp, com_emp from empleados where cod_dep=110 and 0<(select count(com_emp) from empleados where com_emp is not null and cod_dep=110) order by nom_emp;

-- 2.
select cod_emp, nom_emp, (sal_emp + com_emp) 'salario total' from empleados where com_emp is not null and (sal_emp+com_emp)>(select min(sal_emp)+500 from empleados);

-- 3.
select nom_emp, sal_emp from empleados where cod_dep=111 and com_emp is not null and com_emp>(0.005 * sal_emp) order by nom_emp;

-- 4.
create table empleados2(select cod_emp, cod_dep, nom_emp from empleados limit 5);

-- 5.
insert into empleados2 (cod_emp, cod_dep, nom_emp) select cod_emp, cod_dep, nom_emp from empleados where sal_emp between 2900 and 3100

-- 6.
select (sal_emp/num_hij) as 'Salario para cada hijo' from empleados where com_emp is null and num_hij>0

-- 8.
select cod_dep, nom_emp from empleados where cod_dep=112 and nom_emp like 'm%'

-- 7. 
select cod_dep, nom_emp , sal_emp from empleados where (cod_dep = 110 or cod_dep = 111) and (num_hij = 0 or sal_emp>1500) order by nom_emp asc

-- 9.
select nom_emp, sal_emp from empleados where fec_ing>='19880101' or (fec_ing<'19880101' and sal_emp<(select min(sal_emp)*2 from empleados where fec_ing>='19880101')) order by nom_emp;

-- 10.
select ((sum(sal_emp)*14) + (sum(com_emp)*11)) as 'masa salarial' from empleados;




-- EJERCICIO JOINS TABLAS ESCRITORES

-- 1. Mostrar todos los escritores, conjuntamente con sus obras, excluyendo aquellos registros que no tengan continuidad
select nom_esc, tit_obr from esc inner join obr on esc.ide_esc=obr.ide_esc

-- 2. Mostrar todos los escritores, conjuntamente con sus obras, incluyendo aquellos escritores que no tengan obra
select nom_esc, tit_obr from esc left join obr on esc.ide_esc=obr.ide_esc

-- 3. Mostrar todos los escritores, conjuntamente con sus obras, incluyendo aquellas obras que no tengan escritor
select nom_esc, tit_obr from esc right join obr on esc.ide_esc=obr.ide_esc



-- PRACTICA 3

1.-- Muestra el precio medio de los productos
 select avg(pvp_pro) as 'Precio Medio' from pro;
2.-- Muestra el precio más alto de los productos
 select max(pvp_pro) as 'Precio mas Alto' from pro;
3.-- Muestra el precio más bajo de los productos
 select min(pvp_pro) as 'Precio mas bajo' from pro;
4.-- Muestra el valor total de todos los productos
 select sum(pvp_pro) as 'Valor Total' from pro
5.-- Muestra el número total de productos
 select count(pvp_pro) from pro
6.-- Muestra los primeros dos productos
 select nom_pro from pro limit 2
7.-- Muestra las marcas disponibles sin que se repitan
 select distinct nom_fab from fab;
8.-- Muestra información de los productos cuyo precio esté fijado a partir de los 500 €, incluido los 500 €
 select * from pro where pvp_pro>=500
9.-- Muestra el precio medio de los productos de yamaha
 select avg(pvp_pro) as 'precio medio de yamaha' from fab inner join fab pro on fab.cod_fab=pro.cod_fab where fab.nom_fab='yamaha';
10.-- Muestra el contenido completo de la base de datos por medio de una única instrucción, teniendo en cuenta que este se encuentra repartido entre un total de tres tablas.
 select
 fab.nom_fab,
 pro.nom_pro,
 pro.pvp_pro
 from pro 
 inner join fab on pro.cod_fab = fab.cod_fab 
 inner join cat on pro.cod_cat = cat.cod_cat;





-- PRACTICA 4 (generico, osea sin tablas)

1.-- Selecciona el nombre, el apellido y dirección de los empleados:
select nom_emp, ape_emp, dir_emp from emp;
2.-- Modifica, por ejemplo Portugal, poniendo en mar el valor 'si' al tener acceso al mar.
update pai set mar_pai='si' where nom_pai='Portugal' 
3.-- Eliminar todos los telefonos de Huawei desde el 2019, incluyendo este año.
delete from telefonos where mar_tel='Huawei' and fec_tel>='20190101'

4.-- Inserta una descripción de un evento y la fecha en la que se lanza este evento, siendo incluida esta fecha de forma automatizada.
insert into eventos (des_eve, fec_eve) values ('Evento de Musica electronica', NOW())

5.-- Muestra información completa, de toda la base de datos, en relación al universo (tabla), a la galaxia (tabla) y al sistema_solar (tabla). 
select * 
from uni 
inner join gal on uni.ide_gal = gal.ide_gal
inner join sis on gal.ide_gal = sis.ide_gal

6.-- Muestra el promedio de horas trabajadas de los empleados que empezaron a trabajar entre 2000 y 2010 (ambos años incluidos) o bien que miden más de 1,80 y son mujeres.
select avg(hor_emp) from emp where (ing_emp between '20000101' and '20101231') or (est_emp>1.80 and gen_emp='mujer')

7.-- Muestra el modelo del avión más rápido.
select mod_avi from aviones where vel_avi = (select max(vel_avi) from aviones)

8.-- Modifica en una sola instrucción el color, el sabor y la textura del pimentón.
update especias set col_pim='amarillo', sab_pim='agridulce', tex_pim='liquido' where='pimenton'

9.-- Inserta en la tabla relojes_clasicos todos los relojes de la tabla relojes_existentes que tenga una fecha de fabricación anterior a 1950 mediante una única instrucción.
insert into relojes_clasicos select * from relojes_existentes where fef_rel<'19500101'

10.-- Selecciona todos los vinos que en tipología contengan el término 'reserva'.
select * from vinos where tip_vin like '%reserva%'



/*
CREATE TABLE lineas (
	ide_lin INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_lin VARCHAR(40)
);

CREATE TABLE trayectos (
	ide_tra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ori_tra VARCHAR(40),
    des_tra VARCHAR(40),
    ide_lin INT,
    FOREIGN KEY (ide_lin) REFERENCES lineas(ide_lin)
);

CREATE TABLE horario (
	ide_hor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sal_hor TIME,
    lleg_hor TIME,
    ide_tra INT,
    FOREIGN KEY (ide_tra) REFERENCES trayectos(ide_tra)
);

CREATE TABLE paradas (
	ide_par INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_par VARCHAR(40),
    ide_lin INT,
    FOREIGN KEY (ide_lin) REFERENCES lineas(ide_lin)
);

CREATE TABLE operatividad (
	ide_ope INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    des_ope DATE,
    hat_ope DATE,
    dias_ope VARCHAR(40),
    ide_lin INT,
    FOREIGN KEY (ide_lin) REFERENCES lineas(ide_lin)
);

-- LINEAS
insert into lineas (nom_lin) values ('Linea1');
insert into lineas (nom_lin) values ('Linea2');
insert into lineas (nom_lin) values ('Linea3');
-- TRAYECTOS
insert into trayectos (ori_tra, des_tra, ide_lin) values ('primavera', 'invierno', 1);
insert into trayectos (ori_tra, des_tra, ide_lin) values ('roja', 'azul', 2);
insert into trayectos (ori_tra, des_tra, ide_lin) values ('helada', 'caliente', 3);
insert into trayectos (ori_tra, des_tra, ide_lin) values ('invierno', 'primavera', 1);
insert into trayectos (ori_tra, des_tra, ide_lin) values ('azul', 'roja', 2);
insert into trayectos (ori_tra, des_tra, ide_lin) values ('caliente', 'helada', 3);
-- HORARIO
insert into horario (sal_hor, lleg_hor, ide_tra) values ('07:00:00', '07:30:00', 1);
insert into horario (sal_hor, lleg_hor, ide_tra) values ('07:00:00', '07:30:00', 2);
insert into horario (sal_hor, lleg_hor, ide_tra) values ('07:15:00', '07:45:00', 3);
insert into horario (sal_hor, lleg_hor, ide_tra) values ('07:30:00', '08:00:00', 4);
insert into horario (sal_hor, lleg_hor, ide_tra) values ('07:30:00', '08:00:00', 5);
insert into horario (sal_hor, lleg_hor, ide_tra) values ('07:45:00', '08:15:00', 6);
-- PARADAS
insert into paradas (nom_par, ide_lin) values ('primavera', 1);
insert into paradas (nom_par, ide_lin) values ('verano', 1);
insert into paradas (nom_par, ide_lin) values ('otoño', 1);
insert into paradas (nom_par, ide_lin) values ('invierno', 1);
insert into paradas (nom_par, ide_lin) values ('roja', 2);
insert into paradas (nom_par, ide_lin) values ('verde', 2);
insert into paradas (nom_par, ide_lin) values ('verano', 2);
insert into paradas (nom_par, ide_lin) values ('azul', 2);
insert into paradas (nom_par, ide_lin) values ('helada', 4);
insert into paradas (nom_par, ide_lin) values ('fria', 4);
insert into paradas (nom_par, ide_lin) values ('templada', 4);
insert into paradas (nom_par, ide_lin) values ('caliente', 4);
-- OPERATIVIDAD
insert into operatividad (des_ope, hat_ope, dias_ope, ide_lin) VALUES ('20240101', '20241231', 'L-M-X-J-V-S-D', 1);
insert into operatividad (des_ope, hat_ope, dias_ope, ide_lin) VALUES ('20240101', '20241231', 'L-M-X-J-V-S-D', 2);
insert into operatividad (des_ope, hat_ope, dias_ope, ide_lin) VALUES ('20240101', '20241231', 'L-M-X-J-V-S-D', 3)
*/


/*
DCL (Lenguaje de Control de Datos)

Permite orotgar o denegar permisos a las estructuras/objetos de las bases de datos(tablas).

{CREATE | ALTER | DROP} {ROLE | USER}
GRANT
RENAME
REVOKE
*/

-- CREACION DE USUARIO
create user 'anakin'@'localhost' identified by 'madrid';

-- OTORGAR TODOS LOS PRIVILEGIOS AL NUEVO USUARIO
grant all privileges on *.* to 'anakin'@'localhost';

-- CREACION DE USUARIO (nuevo usuario)
create user 'anakin2'@'localhost' identified by 'madrid';

-- OTORGAR TODOS LOS PRIVILEGIOS AL NUEVO USUARIO
grant all privileges on *.* to 'anakin2'@'localhost' 
require none with grant option
MAX_QUERIES_PER_HOUR 0
MAX_CONNECTIONS_PER_HOUR 0
MAX_UPDATE_PER_HOUR 0
MAX_USER_PER_HOUR 0

-- CREACION DE USUARIO
create user 'anakin3'@'localhost' identified by 'madrid';

-- OTORGAR PRIVILEGIOS PARA CREAR, ELIMINAR, INDEXAR, Y MODIFICAR ESTRUCTURAS
grant select, insert, update, delete, file on *.* to 'anakin2'@'localhost' 

-- CREACION DE USUARIO
create user 'anakin4'@'localhost' identified by 'madrid';

-- OTORGAR PRIVILEGIOS PARA CREAR, ELIMINAR, INDEXAR, Y MODIFICAR ESTRUCTURAS
GRANT CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, CREATE VIEW, EVENT,
TRIGGER, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE,
EXECUTE ON *.* TO 'anakin4'@'localhost';

-- CREACION DE USUARIO
create user 'anakin5'@'localhost' identified by 'madrid';
-- OTORGAR PRIVILEGIOS PARA ADMINISTRAR OTROS USUARIOS
GRANT RELOAD, SHUTDOWN, PROCESS, REFERENCES, SHOW DATABASES, SUPER, LOCK TABLE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE USER ON *.* TO 'anakin4'@'localhost';

/*
A partir de la tabla que se detalla a continuación
elabora un procedimiento que incremente el precio
dependiendo del combustible en el porcentaje indicado.
 
Si es eléctrico el precio se incrementa en un 10%.
Si es híbrido gasolina el precio se incrementa en un 20%.
Si es gasolina el precio se incrementa en un 30%.
Si es gasoil el precio se incrementa en un 40%.

create table coches (
    ide_coc int not null auto_increment primary key,
    mar_coc varchar(50),
    mod_coc varchar(50),
    tip_coc varchar(50),
    com_coc varchar(50),
    col_coc varchar(50),
    fem_coc date,
    pvp_coc int
)
insert into coches (mar_coc, mod_coc, tip_coc, com_coc, col_coc, fem_coc, pvp_coc) values 
('tesla', 'model 3', 'turismo', 'electrico', 'rojo', '20230101', 25000),
('tesla', 'model s', 'turismo', 'electrico', 'blanco', '20230201', 35000),
('toyota', 'corolla', 'turismo', 'hibrido gasolina', 'rojo', '20230101', 15000),
('toyota', 'avensis', 'turismo', 'hibrido gasolina', 'rojo', '20230201', 22000);

delimiter $
create procedure mod_pvp_coc (combustible varchar(50))
begin
    declare ide int;
    declare pvp int;
    -- Declaración de la variable contador para el bucle
    declare contador int default 0;
    declare cur1 cursor for
    select ide_coc from coches where com_coc=combustible;
    -- Cuando todos los registros, dentro del cursor, hayan sido iteradas
    -- la variable contador pasará de 0 a 1 (condición de salida del bucle)
    declare continue handler for not found set contador = 1;
    open cur1;
    bucle1:loop
    fetch cur1 into ide;
    if contador=1 then
        leave bucle1;
    end if;
    if combustible='electrico' then
        -- si es electrico incrementamos el pvp en un 10%
        update coches set pvp_coc=pvp_coc*1.1 where ide_coc=ide;
    elseif combustible='hibrido gasolina' then
        -- si es hibrido gasolina el pvp en un 20%
        update coches set pvp_coc=pvp_coc*1.2 where ide_coc=ide;
    elseif combustible='gasolina' then
        -- si es gasolina incrementamos el pvp en un 30%
        update coches set pvp_coc=pvp_coc*1.3 where ide_coc=ide;
    elseif combustible='gasolil' then
        -- si es gasolil incrementamos el pvp en un 40%
        update coches set pvp_coc=pvp_coc*1.4 where ide_coc=ide;
    end if;
    end loop bucle1;
    close cur1;
end$  
*/

-- NORMALMENTE CUANDO ES DETERMINISTA (SIEMPRE MISMO RESULTADO) NO TENDRA PARAMETROS

Ejercicio 1: Crear un Procedimiento Simple
 
Enunciado:
 
Crea un procedimiento almacenado llamado hola_mundo que, al ejecutarse, seleccione un mensaje que diga "Hola mundo".
 
Solución:
 
DELIMITER //
CREATE PROCEDURE hola_mundo()
BEGIN
  SELECT 'Hola mundo' AS mensaje;
END//
DELIMITER ;
 
Llamada:
 
CALL hola_mundo();
 
 
Ejercicio 2: Procedimiento con Parámetros de Entrada
 
Enunciado:
 
Desarrolla un procedimiento almacenado saludar_usuario que acepte un nombre de usuario como parámetro y devuelva un saludo personalizado.
 
Solución:
 
DELIMITER //
CREATE PROCEDURE saludar_usuario(IN nombre_usuario VARCHAR(100))
BEGIN
  SELECT CONCAT('¡', 'Hola, ', nombre_usuario , '!') AS Saludo;
END//
DELIMITER ;
 
Llamada:
 
CALL saludar_usuario('Ana');
 
 
Ejercicio 3: Procedimiento con Parámetros de Entrada y Salida
 
Enunciado:
 
Escribe un procedimiento almacenado llamado calcular_iva que tome como entrada el precio de un producto y un porcentaje de IVA, y que devuelva el precio final incluyendo el IVA.
 
Solución:
 
DELIMITER //
CREATE PROCEDURE calcular_iva(IN precio DECIMAL(10,2), IN tasa_iva DECIMAL(5,2), OUT precio_final DECIMAL(10,2))
BEGIN
  SET precio_final = precio + (precio * tasa_iva / 100);
END//
DELIMITER ;
 
 
Llamada:
 
CALL calcular_iva(100.00, 16, @precio_con_iva);
SELECT @precio_con_iva AS PrecioFinal;
 
 
Ejercicio 4: Procedimiento con devolución de datos
 
Enunciado:
 
Crea un procedimiento almacenado listar_precios que reciba un rango de precios mínimo y máximo y que devuelva una lista de productos cuyos precios estén dentro de ese rango.
 
Tabla y datos:
 
CREATE TABLE productos (
  producto_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10, 2),
  stock INT
);
 
INSERT INTO productos (nombre, precio, stock) VALUES ('Producto A', 120.00, 10);
INSERT INTO productos (nombre, precio, stock) VALUES ('Producto B', 80.00, 3);
 
Solución:
 
DELIMITER //
CREATE PROCEDURE listar_precios(IN min_price DECIMAL(10,2), IN max_price DECIMAL(10,2))
BEGIN
  SELECT * FROM productos WHERE precio BETWEEN min_price AND max_price;
END//
DELIMITER ;
 
Llamada:
 
CALL listar_precios(100.00, 500.00);
 
 
Ejercicio 5: Procedimiento con Cursor y Manejo de Excepciones
 
Enunciado:
 
Implementa un procedimiento almacenado actualizar_stock que actualice el stock de los productos. Si el producto tiene un stock menor a 5, debe incrementarse en 10 unidades.
 
Tabla y datos:
 
CREATE TABLE productos (
  producto_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10, 2),
  stock INT
);
 
INSERT INTO productos (nombre, precio, stock) VALUES ('Producto A', 120.00, 10);
INSERT INTO productos (nombre, precio, stock) VALUES ('Producto B', 80.00, 3);
 
Solución:
 
DELIMITER //
CREATE PROCEDURE actualizar_stock()
BEGIN
  DECLARE v_finished INTEGER DEFAULT 0;
  DECLARE v_producto_id INT;
  DECLARE v_stock_actual INT;
 
  -- Declarar el cursor
  DECLARE producto_cursor CURSOR FOR 
      SELECT producto_id, stock FROM productos;
  
  -- Declarar el handler de finalización
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
 
  OPEN producto_cursor;
 
  get_stock: LOOP
    FETCH producto_cursor INTO v_producto_id, v_stock_actual;
    IF v_finished = 1 THEN 
      LEAVE get_stock;
    END IF;
  
    -- Condición para incrementar el stock
    IF v_stock_actual < 5 THEN
      UPDATE productos SET stock = stock + 10 WHERE producto_id = v_producto_id;
    END IF;
  END LOOP get_stock;
 
  CLOSE producto_cursor;
END//
DELIMITER ;
 
Llamada:
 
CALL actualizar_stock();

Ejercicio 6: Procedimiento con Parámetros de Entrada y de Salida Múltiples
 
Enunciado:
 
Desarrolla un procedimiento almacenado llamado obtener_estadisticas_producto que reciba el ID de un producto y devuelva el precio más alto, el precio más bajo y el precio promedio de ese producto según las ventas históricas.
 
Tabla y datos:
 
CREATE TABLE ventas (
  venta_id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT,
  precio DECIMAL(10, 2)
);
 
INSERT INTO ventas (producto_id, precio) VALUES (1, 99.99);
INSERT INTO ventas (producto_id, precio) VALUES (1, 199.99);
 
Solución:
 
DELIMITER //
CREATE PROCEDURE obtener_estadisticas_producto(IN producto_id INT, OUT max_precio DECIMAL(10,2), OUT min_precio DECIMAL(10,2), OUT promedio_precio DECIMAL(10,2))
BEGIN
  SELECT MAX(precio), MIN(precio), AVG(precio) INTO max_precio, min_precio, promedio_precio
  FROM ventas WHERE producto_id = producto_id;
END//
DELIMITER ;
 
Para ejecutar el procedimiento:
 
CALL obtener_estadisticas_producto(1, @max_precio, @min_precio, @promedio_precio);
SELECT @max_precio AS MaxPrecio, @min_precio AS MinPrecio, @promedio_precio AS PromedioPrecio;

Ejercicio 7: Procedimiento con Bucle que Modifica Datos en Múltiples Tablas

Enunciado:

Crea un procedimiento almacenado reajustar_precios que aumente el precio de todos los
productos en un porcentaje dado y actualice la fecha de última modificación del precio en otra
tabla de auditoría.

Tabla y datos:

CREATE TABLE ventas (
    venta_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    precio DECIMAL(10, 2)
);
CREATE TABLE auditoria_precios (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    nuevo_precio DECIMAL(10, 2),
    fecha_actualizacion DATE
);
INSERT INTO ventas (producto_id, precio) VALUES (1, 99.99);
INSERT INTO ventas (producto_id, precio) VALUES (1, 199.99);

Solución:
DELIMITER //

CREATE PROCEDURE reajustar_precios(IN porcentaje_aumento DECIMAL(5,2))
BEGIN
    -- Aumentar el precio de todos los productos en un porcentaje dado
    UPDATE ventas
    SET precio = precio * (1 + porcentaje_aumento / 100);

    -- Insertar en la tabla de auditoría
    INSERT INTO auditoria_precios (producto_id, nuevo_precio, fecha_actualizacion)
    SELECT producto_id, precio, CURDATE()
    FROM ventas;
END //

DELIMITER ;

CALL reajustar_precios(10);


/*CASE SENSITIVE
Dos modos de tratar loas cadenas de caracteres, en cuanto al uso de mayusculas y minusculas.
Sin distincion: no case sensitive
Con distincion: case sensitive
*/

create table if not exists usuarios1 
(
    ide int not null auto_increment primary key,
    usu varchar(10),
    con varchar(10)
);
 
insert into usuarios1 (usu, con) values
('usu1', 'con1')
('usu2', 'CON1'),
('usu3', 'Con1'),
('usu4', 'cOn1'),
('usu5', 'coN1'),
('usu6', 'CoN1')

select usu, convert(con using utf8) as 'clave', con=BINARY 'con' from usuarios1;

create database if not exists bd2 default character set utf8 collate utf8_genereal_ci;

create table if not exists usuarios2 
(
    ide int not null auto_increment primary key,
    usu varchar(10) character set utf8 default NULL,
    con varchar(10) tinyblob not null
) default character=utf8;
 
insert into usuarios2 (usu, con) values
('usu1', 'con1')
('usu2', 'CON1'),
('usu3', 'Con1'),
('usu4', 'cOn1'),
('usu5', 'coN1'),
('usu6', 'CoN1');

select usu, convert(con using utf8) as 'clave', con=BINARY 'con' from usuarios2;