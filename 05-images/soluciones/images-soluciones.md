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

```yaml
FROM node:20
```

</div>

---

4. Establecer un directorio de trabajo (`/app`).

<div class="resolve">

```yaml
WORKDIR /app
```

</div>

---

5. Copiar fichero de dependencias (`package.json`).

<div class="resolve">

```yaml
COPY package*.json ./
```

</div>

---

6. Instalar las dependencias (`npm install`).

<div class="resolve">

```yaml
RUN npm install
```

</div>

---

7. Definir [variables](https://github.com/trynewroads/course-backend/tree/main) y configurar puerto (3000).

<div class="resolve">

```yaml
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

```yaml
COPY . .
```

</div>

---

9. Compilar la aplicación (`npm run build`)

<div class="resolve">

```yaml
RUN npm run build
```

</div>

---

10. Comando para iniciar la aplicación (`node dist/main.js`)

<div class="resolve">

```yaml
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

## Ejercicio 1: Crear una Imagen Docker para el Entorno de Desarrollo de una Aplicación NestJS (Continuación)

9. Genera la imagen con un nombre.

10. Inicia un contenedor con la imagen creada. (Comprobar que funciona y es accesible)

11. Inicia otro contenedor con un bind mount del `src`. (Comprobar que las modificaciones realizadas actualizan el backend, `main.ts` modificar textos del config)
