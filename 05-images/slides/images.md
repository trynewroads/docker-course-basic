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

# Imágenes

---

## ¿Qué son las Imágenes de Docker?

- Las imágenes de Docker son plantillas de solo lectura utilizadas para crear contenedores.
- Contienen el sistema de archivos y todas las dependencias necesarias para ejecutar una aplicación.
- Se pueden compartir y distribuir fácilmente a través de registros como Docker Hub.
- Para crear imágenes personalizadas, se utiliza un `Dockerfile`, que es un archivo de texto con instrucciones para construir la imagen.

---

## ¿Qué es un Dockerfile?

- Un Dockerfile es un archivo de texto que define los pasos necesarios para construir una imagen de Docker, como instalar dependencias, copiar archivos y configurar el entorno.
- Se utiliza con el comando `docker build` para generar una imagen personalizada y reproducible.
- Un Dockerfile se construye usando una serie de instrucciones o palabras reservadas, cada una de las cuales genera una nueva capa en la imagen.
- Las capas son almacenadas de manera eficiente, y Docker reutiliza las capas que no han cambiado, lo que acelera las construcciones subsecuentes.
- La capa final de la imagen es el contenedor que se ejecutará, proporcionando el entorno listo para ejecutar la aplicación.

---

## Instrucciones Comunes en Dockerfile

- `FROM`: Define la imagen base a partir de la cual se construye la nueva imagen.

  ```dockerfile
  FROM nginx:alpine
  ```

- `WORKDIR`: Cambia el directorio donde se ejecutarán los siguientes comandos.
- `ENV`: Define las variables de entorno.
- `RUN`: Ejecuta un comando dentro de la imagen durante su construcción.

  ```dockerfile
  RUN apk update && apk add --no-cache iputils nano
  ```

---

- `VOLUME`: Crea un punto de montaje para volúmenes.

  ```dockerfile
  VOLUME ["/etc/nginx/conf.d"]
  ```

---

- `COPY`/`ADD`: Copia archivos o directorios del host al contenedor.

  ```dockerfile
  COPY ./index.html /usr/share/nginx/html/index.html
  ```

- `EXPOSE`: Informa a Docker que el contenedor escucha en un puerto específico. No mapea automáticamente el puerto al host.

  ```dockerfile
  EXPOSE 80
  ```

---

- `CMD`: Especifica el comando que se ejecutará cuando se inicie el contenedor. Es esencial para definir el comportamiento del contenedor.

  ```dockerfile
  CMD ["nginx", "-g", "daemon off;"]
  ```

Más información: [https://docs.docker.com/reference/dockerfile/](https://docs.docker.com/reference/dockerfile/)

---

## .dockerignore

- El archivo `.dockerignore` especifica qué archivos o directorios no deben ser copiados a la imagen de Docker.
- Similar al `.gitignore`, ayuda a evitar archivos innecesarios en la imagen.
- Mejora la eficiencia al reducir el tamaño de la imagen y acelera el proceso de construcción.
- Protege la seguridad al evitar incluir archivos sensibles en la imagen.

---

## ¿Cómo crear una imagen Docker?

- Para crear una imagen Docker solo necesitas un archivo llamado Dockerfile con las instrucciones para construir el entorno y la aplicación.

- Utiliza el comando docker build para generar la imagen a partir del Dockerfile y el contexto, que es la carpeta donde están los archivos necesarios.

  ```bash
  docker build -t nombre-imagen:tag .
  ```

---

# Opciones avanzadas de `docker build`

- Puedes usar **varios `-t`** para etiquetar la imagen con diferentes nombres/tags:

  ```bash
  docker build -t miapp:latest -t miapp:v1.0 .
  ```

- Para indicar un `Dockerfile` con otro nombre o en otra ruta, usa `-f`:

  ```bash
  docker build -f Dockerfile.dev -t miapp:dev .
  ```

- Puedes construir imágenes desde cualquier carpeta como contexto:

  ```bash
  docker build -t miapp:prod ./directorio-con-el-dockerfile
  ```
