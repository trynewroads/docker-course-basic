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
    background: transparent!important
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

## Ejercicios Redes

---

**Enunciado:**

Tienes dos imágenes Docker disponibles en Docker Hub:

- `silvelo/todo-backend`
- `silvelo/todo-client`

El objetivo de este ejercicio es desplegar ambos contenedores y configurarlos para que se comuniquen entre sí utilizando una red personalizada en Docker.

1. Crea una red personalizada llamada `todo-network` que permita la comunicación entre los contenedores.
2. Inicia un contenedor basado en la imagen `silvelo/todo-backend` y conéctalo a la red `todo-network`.
3. Asegúrate de exponer el puerto `3000` para el backend.

---

4. Inicia un contenedor basado en la imagen `silvelo/todo-client` y conéctalo también a la red `todo-network`.
5. Asegúrate de que la aplicación frontend pueda acceder al backend a través del nombre del servicio (`todo-backend`) en lugar de una dirección IP.

**Resultado esperado:**

- El backend (`silvelo/todo-backend`) debería estar accesible en la red bajo el nombre `todo-backend`.
- El frontend (`silvelo/todo-client`) debería poder comunicarse con el backend usando la URL `http://todo-backend:3000`.

---

**Extensión del ejercicio:**

Vamos a añadir una base de datos MongoDB y configurar la red para que los servicios tengan permisos específicos.

1. Añade un contenedor basado en la imagen oficial de `mongo`.
2. El backend debe poder conectarse tanto al cliente como a MongoDB.
3. El cliente solo puede conectarse al backend, pero no directamente a MongoDB.
4. MongoDB solo debe ser accesible desde el backend.
