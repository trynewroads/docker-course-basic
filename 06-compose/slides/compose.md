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

  .normal {
    font-size: 18px;
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

# Docker Compose

---

## ¿Qué es Docker Compose?

Es una herramienta para definir y ejecutar aplicaciones de múltiples contenedores a partir de un único archivo de configuración YAML.

- **Ventajas**: Simplifica la gestión de servicios, redes y volúmenes en un solo archivo, facilitando el despliegue de tu stack de aplicaciones de forma eficiente.

---

- **Uso**: Con un solo comando, puedes crear y arrancar todos los servicios configurados en el archivo `docker-compose.yml`, ideal para entornos de producción, desarrollo, testing y CI/CD.

---

## ¿Cómo Funciona Docker Compose?

- Docker Compose utiliza un archivo YAML (`compose.yaml`) para definir la configuración de tu aplicación y sus servicios.
- Sigue las reglas establecidas por la _Compose Specification_ ([especificación completa](https://docs.docker.com/reference/compose-file/)).
- También se soportan archivos `docker-compose.yml` para compatibilidad con versiones anteriores.

---

## Configuración compose

En un archivo `compose.yaml`, las claves principales son:

- **services**: Define los servicios (contenedores) que forman tu aplicación. Cada servicio puede tener su propia imagen, variables de entorno, puertos, volúmenes, etc.
- **image**: Especifica la imagen de Docker que se usará para crear el contenedor del servicio. Puede ser una imagen pública, privada o una construida localmente.
- **environment**: Permite establecer variables de entorno para los servicios.

---

- **container_name**: Permite asignar un nombre personalizado al contenedor que se crea para el servicio, facilitando
- **ports**: Expone y mapea puertos del contenedor al host.
- **depends_on**: Indica dependencias de arranque entre servicios.
- **volumes**: Define volúmenes persistentes para almacenar datos fuera del ciclo de vida de los contenedores.
- **networks**: Permite definir redes personalizadas para que los servicios se comuniquen entre sí de forma aislada o con el exterior.

---

## Comandos Comunes de Docker Compose

`docker compose` ([referencia](https://docs.docker.com/reference/cli/docker/compose/)) para gestionar aplicaciones multicontenedor.

- `docker compose up`: Inicia todos los servicios definidos en el archivo.
- `docker compose down`: Detiene y elimina todos los contenedores, redes y volúmenes creados por `up`.
- `docker compose logs`: Muestra los logs de todos los servicios.
- `docker compose ps`: Lista todos los contenedores que se están ejecutando.

Puedes invocar contenedores de manera individual usando `docker compose <command> <nombre del servicio>`.

---

## Creando un archivo `compose.yaml` básico

Creación de un contenedor con `docker run`

<div class="normal">

```bash
docker run \
-d  \
-p 3000:3000 \
--network course-network \
--hostname course-backend \
--name cb \
-e USE_DB=true \
-e DB_HOST=course-database \
-e DB_PORT=5432 \
-e DB_USER=postgres \
-e DB_PASS=12345678 \
-e DB_NAME=postgres \
course-backend
```

</div>

---

Convertir la configuración a un compose

<div class="normal">

```yaml
services:
  course-backend:
    image: course-backend
    container_name: cb
    hostname: course-backend
    networks:
      - course-network
    ports:
      - "3000:3000"
    environment:
      - USE_DB=true
      - DB_HOST=course-database
      - DB_PORT=5432
      - DB_USER=postgres
      - DB_PASS=12345678
      - DB_NAME=postgres

networks:
  course-network:
    external: true
```

</div>
