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
---

  <!-- _paginate: skip -->

  <div class="front">
    <h1 class="title"> Docker Básico </h1>
    <hr class="line"/>
    <p class="author">Arturo Silvelo</p>
    <p class="company">Try New Roads</p>
  </div>

---

# Ejercicio: Volúmenes

---

Cada uno de los ejericios parten del ejercicio de redes donde se conectan las aplicaciones `course-backend` y `course-frontend`,

---

## Ejercicio 1: Anonymous

1. Crea una nueva instancia de postgres con un volumen anónimo e inspecciona la información de los volúmenes.

2. Inserta algunas entradas de ejemplo en la base de datos de postgres.

3. Elimina el contenedor de postgres y crea uno nuevo.

---

## Ejercicio 2: Named Volumes

1. Crea un nuevo contenedor de postgres usando un volumen de nombrado.

2. Inserta algunas entradas de ejemplo en la base de datos de postgres.

3. Elimina el contenedor de postgres y crea uno nuevo.

---

# Ejercicio 3: Bind Mounts

1. Haz una copia del volumen en un directorio local.

2. Creamos una nueva máquina de postgres con un volumen de tipo `bind`.

3. Verifica que ambas bases de datos tengan los mismos datos.

---

## Notas

- El volume de datos para postgress se encuentra en el siguiente directorio: `/var/lib/postgresql/data`

- Para la realización de estos ejercicios es necesario modificar el backend para que use una base de datos. Para esto tenemos que configurar las siguiente variables al iniciar el contenedor.

```bash
USE_DB=false
DB_HOST=localhost
DB_PORT=5432
DB_USER=todo_user
DB_PASS=todo_pass
DB_NAME=todo_db
```

---

```bash
docker run
-d  # Segundo plano
-p 3000:3000 # Conectar el puerto 3000 del host con el 3000 del contenedor
--network course-network # Asignar la red
--hostname course-backend # Nombre en la red
--name cb # Nombre del contendor
-e USE_DB=true # Variables de entorno
-e DB_HOST=course-database
-e DB_PORT=5432
-e DB_USER=postgres
-e DB_PASS=12345678
-e DB_NAME=postgres
ghcr.io/trynewroads/course-backend:1.0.0 # imagen usada
```
