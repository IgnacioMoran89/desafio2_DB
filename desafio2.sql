--1. Crear base de datos llamada películas
CREATE DATABASE peliculas;

\c peliculas

--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas.
--Id de Película es la relación entre ambas tablas

--3. Cargar ambos archivos a su tabla correspondiente
CREATE TABLE peliculas(id SERIAL, pelicula VARCHAR(200) , año_estreno SMALLINT, director VARCHAR(50));

\copy peliculas FROM '/mnt/c/Users/moran/Desktop/desafio2_db/peliculas.csv' csv header;


CREATE TABLE reparto(pelicula_id SMALLINT, nombre_actor VARCHAR(50));

\copy reparto FROM '/mnt/c/Users/moran/Desktop/desafio2_db/reparto.csv' csv;

ALTER TABLE peliculas ADD PRIMARY KEY (id);

ALTER TABLE reparto ADD FOREIGN KEY (pelicula_id) REFERENCES peliculas(id); 

-- 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto.
SELECT * FROM peliculas FULL JOIN reparto ON peliculas.id=reparto.pelicula_id WHERE peliculas.pelicula='Titanic';

--5. Listar los titulos de las películas donde actúe Harrison Ford.
SELECT id, pelicula FROM peliculas WHERE id IN (SELECT pelicula_id FROM reparto WHERE nombre_actor='Harrison Ford');

--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT director, COUNT(*) FROM peliculas GROUP BY director ORDER BY count DESC FETCH FIRST 10 ROWS ONLY;

--7. Indicar cuantos actores distintos hay.
SELECT COUNT(DISTINCT nombre_actor) FROM reparto;

--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.
SELECT pelicula,año_estreno FROM peliculas WHERE año_estreno BETWEEN 1990 AND 1999 ORDER BY pelicula ASC;

--9. Listar el reparto de las películas lanzadas el año 2001
SELECT nombre_actor FROM reparto INNER JOIN peliculas ON reparto.pelicula_id=peliculas.id WHERE año_estreno=2001;

--10. Listar los actores de la película más nueva
SELECT nombre_actor FROM reparto WHERE pelicula_id IN (SELECT id FROM peliculas ORDER BY año_estreno DESC LIMIT 1);



 




--NOTAS

-- Nota1: permite editar el tipo de dato de una columna
--ALTER TABLE peliculas ALTER COLUMN pelicula SET DATA TYPE VARCHAR(200);

-- Nota 2 : para borrar llave primaria (probar drop o remove)
-- ALTER TABLE tabla DROP PRIMARY KEY;

-- Nota 3: DESC LIMIT 1 o ASC LIMIT 1 permite ordenar solo los que están en esa posición (en este caso primera posición) de manera asc o desc.
