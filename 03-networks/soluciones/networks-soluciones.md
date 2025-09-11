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
    gap: 1rem;
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
