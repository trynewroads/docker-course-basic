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
