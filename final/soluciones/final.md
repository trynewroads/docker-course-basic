---
marp: true
theme: default
title: Docker Básico
paginate: true
size: 16:9
backgroundColor: #2E2052;
color: #ffffff;
footer: Docker Básico
header: |
  <div class="logo-start">
    <img src="../../images/docker-logo-white.png" alt="Logo Docker"  class="logo"/>
  </div>
  <div class="logo-end">
    <img src="../../images/logo_white.png" alt="Logo TNR" class="logo" />
  </div>

style: |
  section {
    display:flex;
  }

  section > h2, h3, h4, h5{
    border-bottom: 2px solid #2D6BFA;
    padding-bottom: .3rem;
  }

  section::after, header, footer {
    font-weight: 700;
    color: white;
  }

  section > header {
    display: flex;
    top: 0;
    width: calc(100% - 60px);
    background: radial-gradient(30% 100% at 50% 0%, #2D6BFA 0%, rgba(46, 32, 82, 0.00) 100%);
  }

  .logo-start{
    flex:1;
  }

  .logo-end{
    flex:1;
    text-align:end;
    width: auto;
    height: 30px;
  }

  .logo {
    width: auto;
    height: 30px;
  }

  .front {
    display: flex;
    flex-direction: column;
  }

  .title{
    font-size:2.5em;
    margin-bottom:0;
    padding-bottom:0;
    
  }

  .line{
    width:100%;
    background-color: #2D6BFA
  }

  .author{
    font-size:1.3em;
    font-weight: 700;
    margin-bottom: 0;
  }

  .company{
    font-size:.9em;
    margin-top: .1em;
  }

  blockquote{
    color:white;
    font-size: 16px;
    border-color:#2D6BFA;
    bottom: 70px;
    left: 30px;
    position: absolute;
  }

  a{
    background-color: rgb(45 107 250 / 30%);
    color: white;
    font-weight: bold;
    text-decoration: none;
  }

  a > code {
    background-color: rgb(45 107 250 / 30%);
  }


  code {
    background-color: rgb(255 255 255 / 30%);
  }

  tr {
    background: transparent!important;
  }

  .container-center {
    display: flex;
    place-content: center;
  }

  .container-image {
    display: flex;
    place-content: center;
    max-height: 80%;
  }

  .resolve{
    padding: 1rem 1rem .5rem 1rem;
    margin: 1rem;
    border-radius: 25px;
    background-color: rgb(255 255 255 / 10%);
    font-size: 22px;
  }
---

  <!-- _paginate: skip -->

  <div class="front">
    <h1 class="title"> Docker Básico </h1>
    <hr class="line"/>
    <p class="author">Arturo Silvelo
    <p class="company">Try New Roads
  </div>

---

# Ejercicios Contenedores

---

## Objetivo de la práctica

Aprender a gestionar contenedores Docker mediante la creación, modificación y manipulación de un contenedor NGINX.

---

## Pasos a seguir

1. Limpiar cualquier recurso previo (contenedores, imágenes, volúmenes, redes).

<div class="resolve">

```bash
docker container prune
docker image prune
docker volume prune
docker network prune
```

</div>

---

2. Crear un contenedor NGINX que sirva contenido web en un puerto aleatorio.

Este contenedor se ejecutará en un puerto aleatorio y permitirá acceder al contenido web que servirá.

<div class="resolve">

```bash
docker run -d --name nginx-practica -P nginx
```

Utiliza el comando `docker ps` para ver el contenedor en ejecución y el puerto asignado.

```bash
docker ps
```

</div>

---

3. Acceder al contenedor para modificar el archivo `index.html` y personalizar el contenido.

<div class="resolve">
Una vez que el contenedor esté en ejecución, accede al contenedor y edita el archivo `index.html` para modificar el contenido, como los elementos `h1` o `p`. Puedes hacerlo con los siguientes comandos:

```bash
docker exec -it nginx-practica /bin/bash
cd /usr/share/nginx/html
nano index.html
```

Estos cambios se verán reflejados inmediatamente en el contenedor de `nginx-practica` y serán accesibles en el navegador si la página está en ejecución.

Instala `nano` para editar el archivo `index.html`

```bash
apt update
apt install -y nano
```

</div>

---

4. Copiar el contenido de la carpeta HTML del contenedor al sistema host.
<div class="resolve">

Una vez que hayas realizado los cambios, copia el contenido del directorio HTML del contenedor a tu máquina host con el siguiente comando:

```bash
docker cp nginx-practica:/usr/share/nginx/html .
```

Este comando copia el contenido de la carpeta `/usr/share/nginx/html` del contenedor `nginx-practica` a la ubicación actual del host.
Al ejecutar este comando, se creará una carpeta llamada `html` en el directorio actual del host, que contendrá todos los archivos HTML del contenedor.

</div>

---

5. Crear un nuevo contenedor NGINX utilizando la carpeta copiada como su contenido web.
<div class="resolve">

Monta la carpeta copiada anteriormente como su contenido web

```bash
docker run --name nginx-practica -v $(pwd):/usr/share/nginx/html -P nginx
```

ó

```bash
cd /ruta/a/mi/carpeta
docker run --name nginx-practica -v .:/usr/share/nginx/html -P nginx
```

La carpeta del host queda sincronizada con el contenedor, reflejando cualquier cambio en tiempo real (como las ediciones en `index.html`).

En sistemas Unix, `$(pwd)` representa el directorio actual. En PowerShell de Windows, usa `${PWD}` en su lugar.

</div>

---



## Soluciones Redes

---

Descargar imágenes

<div class="resolve">

```bash
docker pull ghcr.io/trynewroads/course-frontend:1.0.0
docker pull ghcr.io/trynewroads/course-backend:1.0.0
```

Verificar que las imágenes se han descargado

```bash
docker image ls
```

</div>

---

1. Crea una red personalizada llamada `course-network` que permita la comunicación entre los contenedores.

<div class="resolve">

```bash
docker network create course-network
```

Verifica que se ha creado y el rango de la subred creada

```bash
docker network ls
docker inspect course-network
```

```bash
{
    "Subnet": "172.22.0.0/16",
    "Gateway": "172.22.0.1"
}
```

 </div>

---

2. Inicia un contenedor basado en la imagen `course-backend`, conéctalo a la red `course-network` ,dale un nombre de host y al contenedor.

<div class="resolve">

```bash
docker run
-d  # Segundo plano
-p 3000:3000 # Conectar el puerto 3000 del host con el 3000 del contenedor
--network course-network # Asignar la red
--hostname course-backend # Nombre en la red
--name cb # Nombre del contendor
ghcr.io/trynewroads/course-backend:1.0.0 # imagen usada
```

</div>

---

<div class="resolve">

Comprobar la creación

```bash
docker ps
```

Comprobar la red

```bash
docker inspect course-network
```

```bash
"Networks": {
  "course-network": {
    Gateway": "172.22.0.1",
    "IPAddress": "172.22.0.2",
    "DNSNames": [
      "cb", # Resolución por el nombre del contenedor
      "43bf280a0797", # Resolución por el id del contenedor
      "course-backend" # Resolución por el hostname
    ]

```

</div>

---

<div class="resolve">
Acceder servidor <a href=http://localhost:3000/docs>http://localhost:3000/docs</a>

</div>
  <div class="container-image ">
    <img src=../../images/servidor.png>
  </div>

---

3. Inicia un contenedor basado en la imagen `course-frontend` y conéctalo también a la red `course-network`.

<div class="resolve small" >

Crear fichero de configuración ningx `default.conf.template`

```
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://course-backend:3000/api;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Headers para CORS si es necesario
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS";
        add_header Access-Control-Allow-Headers "Content-Type, Authorization";
    }
}
```

</div>

---

<div class="resolve" >

```bash
docker run
-d  # Segundo plano
-p 80:80 # Conectar el puerto 3000 del host con el 3000 del contenedor
-v ./default.conf.template:/etc/nginx/templates/default.conf.template # Configuración de ningx
--network course-network # Asignar la red
--hostname course-frontend # Nombre en la red
--name cf # Nombre del contendor
ghcr.io/trynewroads/course-frontend:1.0.0 # imagen usada
```

Comprobar la creación

```bash
docker ps
```

Comprobar la red

```bash
docker inspect course-network
```

</div>

---

<div class="resolve">
Acceder web <a href=http://localhost>http://localhost</a> con el usuario `admin` y contraseña `12345678`

</div>
  <div class="container-image">
    <img src=../../images/crear-tarea.png>
    <img src=../../images/listado-tareas.png>
  </div>

---

4. Asegúrate de que la aplicación frontend pueda acceder al backend a través del nombre del servicio (`course-backend`) en lugar de una dirección IP.

<div class="resolve">

- Usuario `admin`, contraseña: `12345678`
- Acceder servidor [http://localhost:3000/docs](http://localhost:3000/docs)
- Acceder cliente [http://localhost:80](http://localhost:80)
- Crear una tarea
- Ver el listado de tareas

</div>

---



# Ejercicio: Volúmenes

---

## Ejercicio 1: Anonymous

1. Crea una nueva instancia de postgres con un volumen anónimo e inspecciona la información de los volúmenes.

<div class="resolve">

Creamos el contenedor de postgres y lo asignamos a la red

```bash
docker run --name cdb -e POSTGRES_PASSWORD=12345678 --hostname course-database --network course-network -d postgres
```

Verificar la creación

```bash
docker ps
docker inspect course-network
```

</div>

---

2. Inserta algunas entradas de ejemplo en la base de datos de postgres.

<div class="resolve">

Comprobar que los datos se han guardado en la base de datos

```bash
docker exec -it cdb psql -U postgres -d postgres -c "SELECT * FROM task;"
```

</div>

---

3. Elimina el contenedor de postgres y crea uno nuevo.

<div class="resolve">

Eliminamos la máquina en caliente, este paso puede hacer que el backend deje de funcionar, por lo que tenemos que reiniciar.

```bash
docker rm -f cdb

docker restart cb
```

Creamos de nuevo la máquina

```bash
docker run --name cdb -e POSTGRES_PASSWORD=12345678 --hostname course-database --network course-network -d postgres
```

Repetimos el punto 2 para verificar que están los datos.

</div>

---

## Ejercicio 2: Named Volumes

1. Crea un nuevo contenedor de postgres usando un volumen de nombrado.

<div class="resolve">

Creamos el volume

```bash
docker volume create postgress-data
```

Comprobar que los datos se han guardado en la base de datos

```bash
docker run --name cdb -e POSTGRES_PASSWORD=12345678 --hostname course-database --network course-network -d  -v postgress-data:/var/lib/postgresql/data postgres
```

</div>

---

2. Inserta algunas entradas de ejemplo en la base de datos de postgres.

<div class="resolve">

Comprobar que los datos se han guardado en la base de datos

```bash
docker exec -it cdb psql -U postgres -d postgres -c "SELECT * FROM task;"
```

</div>

---

3. Elimina el contenedor de postgres y crea uno nuevo.

<div class="resolve">

Eliminamos el contenedor

```bash
docker rm -f cdb
```

Creamos otro de nuevo pero usando el mismo volume

```bash
docker run --name cdb -e POSTGRES_PASSWORD=12345678 --hostname course-database --network course-network -d  -v postgress-data:/var/lib/postgresql/data postgres
```

Comprobar que los datos siguen

```bash
docker exec -it cdb psql -U postgres -d postgres -c "SELECT * FROM task;"
```

</div>

---

# Ejercicio 3: Bind Mounts

1. Haz una copia del volumen en un directorio local.

<div class="resolve">

Copiamos el contenido de la base de datos a local.

```bash
docker cp cdb:/var/lib/postgresql/data .
```

Esto copia la carpeta de data del contenedor a una carpeta data en el host

</div>

---

2. Creamos una nueva máquina de postgres con un volumen de tipo `bind`.

<div class="resolve">

Eliminamos el contenedor de la base de datos.

```bash
docker rm -f cdb
```

Creamos uno nuevo pero usando `bind` para montar el directorio copiado en el paso anterior

```bash
docker run --name cdb -e POSTGRES_PASSWORD=12345678 --hostname course-database --network course-network -d -v ./data:/var/lib/postgresql/data postgres
```

</div>

---

3. Verifica que ambas bases de datos tengan los mismos datos.
<div class="resolve">

Es posible que necesitemos reiniciar el backend

```bash
docker restart cb
```

Comprobamos que los datos de la nueva base de datos sean los mismos.

```bash
docker exec -it cdb psql -U postgres -d postgres -c "SELECT \* FROM task;"
```

También podemos crear nuevas tareas y comprobar que se añaden

</div>

---



# Ejercicios Imágenes

---

## Ejercicio 1: Crear una Imagen Docker

Crear una imagen Docker para la aplicación [backend](https://github.com/trynewroads/course-backend)

1. Descargar el repositorio

   ```bash
   git clone git@github.com:trynewroads/course-backend.git
   ```

2. Crear un archivo `Dockerfile`

---

3. Usar `node:20` como imagen base.

<div class="resolve">

```dockerfile
FROM node:20
```

</div>

---

4. Establecer un directorio de trabajo (`/app`).

<div class="resolve">

```dockerfile
WORKDIR /app
```

</div>

---

5. Copiar fichero de dependencias (`package.json`).

<div class="resolve">

```dockerfile
COPY package*.json ./
```

</div>

---

6. Instalar las dependencias (`npm install`).

<div class="resolve">

```dockerfile
RUN npm install
```

</div>

---

7. Definir [variables](https://github.com/trynewroads/course-backend/tree/main) y configurar puerto (3000).

<div class="resolve">

```dockerfile
ENV NODE_ENV=production \
PORT=3000 \
DEBUG_REQUEST=false \
ENABLE_AUTH=true \
DB_HOST=localhost \
DB_PORT=5432 \
USE_DB=false

EXPOSE 3000
```

</div>

---

8. Copiar todo el contenido.

<div class="resolve">

```dockerfile
COPY . .
```

</div>

---

9. Compilar la aplicación (`npm run build`)

<div class="resolve">

```dockerfile
RUN npm run build
```

</div>

---

10. Comando para iniciar la aplicación (`node dist/main.js`)

<div class="resolve">

```dockerfile
CMD [ "node", "dist/main.js" ]
```

</div>

---

11. Crear la imagen

<div class="resolve">

```bash
docker build -t course-test-backend -f 05-images/soluciones/Dockerfile ../course-backend/

docker image ls course-test-backend
```

</div>

---

12. Probar la imagen

<div class="resolve">

Para evitar conflictos con el contenedor que esta corriendo, vamos cambiar los nombres y el puerto.

```bash
docker run \
-d \
-p 3001:3000 \
--network course-network \
--hostname course-test-backend \
--name ctb \
-e USE_DB=true \
-e DB_HOST=course-database \
-e DB_PORT=5432 \
-e DB_USER=postgres \
-e DB_PASS=12345678 \
-e DB_NAME=postgres \
course-test-backend
```

</div>

---

<div class="resolve">

Ahora podremos acceder al backend en <a href="http://localhost:3000/docs">Contenedor 1</a> y <a href="http://localhost:3001/docs">Contenedor 2</a>

Si creamos una tarea usando el Swagger podremos ver que se añade en el frontend.

```bash
docker ps
```

</div>

---

## Ejercicio 2: Crea una imagen de docker para desarrollo

Crear una imagen Docker para la aplicación [backend](https://github.com/trynewroads/course-backend)

1. Descargar el repositorio

   ```bash
   git clone git@github.com:trynewroads/course-backend.git
   ```

---

2. Crear un archivo `Dockerfile.dev`

---

3. Usar `node:20` como imagen base

<div class="resolve">

```dockerfile
FROM node:20
```

</div>

---

4. Establecer un directorio de trabajo (`/app`)

<div class="resolve">

```dockerfile
WORKDIR /app
```

</div>

---

5. Copiar fichero de dependencias (`package.json`)

<div class="resolve">

```dockerfile
COPY package*.json ./
```

</div>

---

6. Instalar las dependencias (`npm install`)

<div class="resolve">

```dockerfile
RUN npm install
```

</div>

---

7. Definir [variables](https://github.com/trynewroads/course-backend/tree/main) y configurar puerto (3000)

<div class="resolve">

```dockerfile
ENV NODE_ENV=production \
PORT=3000 \
DEBUG_REQUEST=false \
ENABLE_AUTH=true \
DB_HOST=localhost \
DB_PORT=5432 \
USE_DB=false

EXPOSE 3000
```

</div>

---

8. Copiar todo el contenido

<div class="resolve">

```dockerfile
COPY . .
```

</div>

---

9. Definir volume (en la carpeta `app`)

<div class="resolve">

```dockerfile
VOLUME /app
```

</div>

---

10. Comando para iniciar la aplicación (`npm run start:dev`)

<div class="resolve">

```dockerfile
CMD [ "npm", "run", "start:dev" ]
```

</div>

---

11. Crear la imagen (`docker build`)

<div class="resolve">

````bash
```bash
docker build -t course-dev-backend -f 05-images/soluciones/Dockerfile.dev ../course-backend/

docker image ls course-dev-backend
````

</div>

---

12. Probar la imagen (`docker run`)

<div class="resolve">

Con esta imagen tendremos algo parecido a la anterior, pero si modificamos el código dentro del contenedor los cambios se verán reflejados.

```bash
docker run \
-d \
-p 3002:3000 \
--network course-network \
--hostname course-dev-backend \
--name cvb \
-e USE_DB=false \
course-dev-backend
```

</div>

---

<div class="resolve">

Lo que podemos hacer es montar el volumen del host de forma directa y así las modificaciones que se hacen en el host se actualizarán con el contenedor y se verán reflejados de forma inmediata.

```bash
docker run \
-d \
-p 3003:3000 \
--network course-network \
--hostname course-dev-backend \
--name cvvb \
-v ../course-backend:/app \
--user $(id -u):$(id -g) \
-e USE_DB=false \
course-dev-backend
```

</div>

---



# Ejercicio Docker Compose

---

Crear la estructura que llevamos usando hasta ahora pero en formato `compose`.

---

## Ejercicio 1: Crear Compose de backend

1. Crear un fichero `docker-compose.yml` ó `compose.yml`

---

2. Configurar el servicio `backend`

   ```bash
   docker run -d \
   -p 3005:3000 \
   --network course-network \
   --hostname course-compose-backend \
   --name ccb \
   -e USE_DB=false \
   ghcr.io/trynewroads/course-backend:1.0.0
   ```

---

3. Levantar el `compose`

<div class="resolve">

```bash
docker compose -f 06-compose/soluciones/compose.yml up -d

docker compose -f ./06-compose/soluciones/compose.yml ps
```

</div>

4. Comprobar que el servicio.

<div class="resolve">
   Acceder al <a  href="http://localhost:3005/docs">servidor</a>
</div>

---

# Ejercicio 2: Crear Compose del frontend

1. Editar el fichero `docker-compose.yml` ó `compose.yml`

---

2. Configurar el servicio `frontend`

   ```bash
   docker run \
   -d
   -p 8080:80 \
   --network course-network \
   --hostname course-compose-frontend \
   -v ./nginx/default.conf.template:/etc/nginx/templates/default.conf.template:ro \
   --name ccf \
   ghcr.io/trynewroads/course-frontend:1.0.0
   ```

---

3. Levantar el `compose`

<div class="resolve">

```bash
docker compose -f 06-compose/soluciones/compose.yml up -d

docker compose -f ./06-compose/soluciones/compose.yml ps
```

</div>

4. Comprobar que el servicio.

<div class="resolve">
   Acceder al <a  href="http://localhost:8080">Cliente</a>
</div>

---

# Ejercicio 3: Crear Compose de la base de datos

1. Editar el fichero `docker-compose.yml` ó `compose.yml`

---

2. Configurar el servicio `postgres`

   ```bash
   docker run
   -d
   --name ccdb
   -e POSTGRES_PASSWORD=12345678
   --hostname course-database
   --network course-network
   -v postgres_data:/var/lib/postgresql/data postgres
   ```

---

3. Levantar el `compose`

<div class="resolve">

```bash
docker compose -f 06-compose/soluciones/compose.yml up -d

docker compose -f ./06-compose/soluciones/compose.yml ps
```

</div>

---

4. Comprobar que el servicio.

<div class="resolve">

```bash
docker exec -it ccdb psql -U postgres -d postgres -c "SELECT * FROM task;"
```

</div>

---

# Ejercicio 4: Mejorar compose

1. Establecer redes independientes para aislar los servicios que se comuniquen entre ellos.

<div class="resolve small">

```yaml
course-compose-backend:
  networks:
    - course-compose-back
    - course-compose-front

course-compose-frontend:
  networks:
    - course-compose-front

course-compose-database:
  networks:
    - course-compose-back

networks:
  course-compose-back:
    driver: bridge

  course-compose-front:
    driver: bridge
```

</div>

---

2. Establecer dependencia entres los servicios para que se inicien en orden (`depends_on`)

<div class="resolve">

```yaml
course-compose-backend:
  depends_on:
    - course-compose-database

course-compose-frontend:
  depends_on:
    - course-compose-backend
```

</div>

---

3. Eliminar las exposición de puertos no necesarios (`puerto de backend`)

<div class="resolve">

```yaml
course-compose-backend:
  #port:
  #  - 3005:3000
```

</div>

---

4. Limpiar sistema

<div class="resolve">

Probamos el compose que funciona con los cambios

```bash
docker compose -f ./06-compose/soluciones/4.compose.yml up -d
docker compose -f ./06-compose/soluciones/4.compose.yml ps
```

Comprobamos si podemos acceder al <a href="http://localhost:8080">Cliente</a>, que no podemos acceder al <a href="http://localhost:3005/docs">Servidor</a>.

```bash
docker compose -f ./06-compose/soluciones/4.compose.yml down --volumes

```

</div>

---

