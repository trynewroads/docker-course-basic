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

  .small {
    font-size: 14px;
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

2. Inserta algunas entradas de ejemplo en la base de datos de postgres.

<div class="resolve">

Comprobar que los datos se han guardado en la base de datos

```bash
docker exec -it cdb psql -U postgres -d postgres -c "SELECT * FROM task;"
```

</div>

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

2. Creamos una nueva máquina de postgres con un volumen de tipo `bind`.

3. Verifica que ambas bases de datos tengan los mismos datos.
