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

# Ejercicio: Persistencia de Datos con Volúmenes

- Partiendo del ejercicio de redes donde se conectan las aplicaciones `todo-backend` y `todo-client`, realiza lo siguiente:
  - Crea un volumen nombrado para almacenar la base de datos de MongoDB.
  - Inserta algunas entradas de ejemplo en la base de datos de MongoDB a través del backend.
  - Detén y elimina el contenedor de MongoDB.
  - Crea un nuevo contenedor de MongoDB usando el mismo volumen nombrado.
  - Verifica que los datos insertados anteriormente siguen estando presentes en la base de datos.

---

# Ejercicio 1: Persistencia de Datos con Volúmenes

Partiendo del ejercicio de redes donde se conectan las aplicaciones `todo-backend` y `todo-client`, realiza lo siguiente:

1. Crea un volumen nombrado para almacenar la base de datos de MongoDB y añade dicho volumen al contenedor.
2. Inserta algunas entradas de ejemplo en la base de datos de MongoDB a través del backend.
3. Elimina el contenedor de MongoDB.
4. Crea un nuevo contenedor de MongoDB usando el mismo volumen nombrado.
5. Verifica que los datos insertados anteriormente siguen estando presentes en la base de datos.

---

# Ejercicio 2: Persistencia de Datos con Volúmenes

Partiendo del ejercicio anterior:

1. Haz una copia del volumen en un directorio local.
2. Creamos una nueva máquina de Mongo con un volumen de tipo `bind`.
3. Verifica que ambas bases de datos tengan los mismos datos.

---

# Ejercicio 3: Persistencia de Datos con Volúmenes

1. Crea una nueva instancia de Mongo con un volumen anónimo e inspecciona la información de los volúmenes.
2. Inserta algunas entradas de ejemplo en la base de datos de MongoDB.
3. Detén y borra el contenedor.
4. Recupera los datos del volumen e intenta montarlos en otro contenedor.
