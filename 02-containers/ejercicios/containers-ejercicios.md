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
---

  <!-- _paginate: skip -->

  <div class="front">
    <h1 class="title"> Docker Básico </h1>
    <hr class="line"/>
    <p class="author">Arturo Silvelo</p>
    <p class="company">Try New Roads</p>
  </div>

---

# Ejercicios Contenedores

---

**Objetivo de la práctica:**
Aprender a gestionar contenedores Docker mediante la creación, modificación y manipulación de un contenedor NGINX.

**Pasos a seguir:**

- Limpiar cualquier recurso previo (contenedores, imágenes, volúmenes, redes).
- Crear un contenedor NGINX que sirva contenido web en un puerto aleatorio.
- Acceder al contenedor para modificar el archivo `index.html` y personalizar el contenido.
- Copiar el contenido de la carpeta HTML del contenedor al sistema host.
- Crear un nuevo contenedor NGINX utilizando la carpeta copiada como su contenido web.

---

Para comenzar, es importante limpiar cualquier recurso que se haya creado anteriormente. Usa los siguientes comandos para eliminar contenedores, imágenes, volúmenes y redes que ya no son necesarios:

```
docker container prune
docker image prune
docker volume prune
docker network prune
```

---

A continuación, vamos a crear un contenedor con NGINX como proxy. Este contenedor se ejecutará en un puerto aleatorio y permitirá acceder al contenido web que servirá.

```
docker run -d --name nginx-practica -P nginx
docker ps
```

- Utiliza el comando `docker ps` para ver el contenedor en ejecución y el puerto asignado.

---

Para modificar el contenido del contenedor, accede a su terminal de comandos. A continuación, instala `nano` para editar el archivo `index.html`:

```
docker exec -it nginx-practica /bin/bash
cd /usr/share/nginx/html
apt update
apt install -y nano
nano index.html
```

---

- Una vez dentro del archivo `index.html`, realiza los cambios necesarios en el contenido.
- Por ejemplo, puedes modificar la etiqueta `<h1>` para cambiar el título principal de la página o editar el texto en la etiqueta `<p>` del cuerpo.
- Estos cambios se verán reflejados inmediatamente en el contenedor de `nginx-practica` y serán accesibles en el navegador si la página está en ejecución.

---

Para copiar el contenido de la carpeta HTML del contenedor al host, utiliza el siguiente comando:

```
docker cp nginx-practica:/usr/share/nginx/html .
```

- Este comando copia el contenido de la carpeta `/usr/share/nginx/html` del contenedor `nginx-practica` a la ubicación actual del host.
- Al ejecutar este comando, se creará una carpeta llamada `html` en el directorio actual del host, que contendrá todos los archivos HTML del contenedor.
- Esto es útil para modificar y reutilizar archivos HTML de forma local sin necesidad de acceder continuamente al contenedor.

---

Finalmente, vamos a crear un nuevo contenedor NGINX que utilice la carpeta copiada anteriormente como su contenido web. Montaremos la carpeta en el contenedor.

```
docker run --name nginx-practica -v $(pwd):/usr/share/nginx/html -P nginx
docker ps
```

- La carpeta del host queda sincronizada con el contenedor, reflejando cualquier cambio en tiempo real (como las ediciones en `index.html`).

**Nota**: En sistemas Unix, `$(pwd)` representa el directorio actual. En PowerShell de Windows, usa `${PWD}` en su lugar.
