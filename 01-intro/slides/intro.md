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

# Introducción

---

## ¿Qué es Docker?

- **Docker** es una plataforma de código abierto que automatiza el desarrollo, despliegue y ejecución de aplicaciones. Permite separar las aplicaciones desarrolladas de la infraestructura donde se desarrollan.
- Docker se ejecuta en entornos totalmente aislados llamados **contenedores**. Estos se ejecutan directamente sobre el kernel de la máquina por lo que son mucho más ligeros que las máquinas virtuales.

---

## Virtualización

La virtualización permite crear instancias virtuales de un hardware físico, permitiendo ejecutar múltiples sistemas operativos en un solo servidor físico.

- **Virtualización:** Simula hardware completo (CPU, memoria, disco).
- **Docker:** Usa el sistema operativo del host, lo que hace que los contenedores sean más ligeros y rápidos.

<div class="container-center">

| Virtualización   | Docker  |
| ---------------- | ------- |
| Pesadas          | Ligeros |
| Consumo Recursos | Rápidos |

</div>

---

<div class="container-image">
  <img src="../../images/vm-docker.png" alt="Virtualización Docker vs VM" />
</div>

---

# Ventajas

---

1. **Portabilidad**
   - Docker empaqueta aplicaciones junto a sus dependencias en contenedores.
   - Esto asegura que las aplicaciones se ejecuten de la misma manera en cualquier entorno.
   - Facilita el despliegue en entornos locales, servidores o la nube sin ajustes adicionales.

---

2. **Consistencia entre Entornos**
   - Los contenedores permiten que el entorno de desarrollo sea idéntico al de producción.
   - Evita problemas de compatibilidad y errores por diferencias entre entornos.
   - Garantiza que el código funcione igual en desarrollo, pruebas y producción.

---

3. **Escalabilidad**
   - Docker facilita el escalado horizontal de aplicaciones mediante la creación de múltiples contenedores.
   - Permite el uso de herramientas como Kubernetes para gestionar el escalado automáticamente.
   - Cada servicio puede escalarse de forma independiente en función de la demanda.

---

4. **Eficiencia en el Uso de Recursos**
   - Los contenedores comparten el núcleo del sistema operativo, siendo más livianos que las máquinas virtuales.
   - Se pueden ejecutar más aplicaciones en el mismo hardware, optimizando recursos.

---

5. **Velocidad de Desarrollo y Despliegue**
   - Los contenedores se inician en segundos, permitiendo un desarrollo y despliegue rápido.
   - Facilita el uso de CI/CD, reduciendo el tiempo de desarrollo y los ciclos de despliegue.

---

6. **Seguridad Mejorada**
   - Docker aísla cada contenedor, limitando el acceso entre contenedores y al host.
   - Permite ejecutar aplicaciones de distintos niveles de seguridad en un mismo servidor.

---

## Instalación

- [https://docs.docker.com/get-started/get-docker/](https://docs.docker.com/get-started/get-docker/)

**Instalación en Windows:**

- WSL: Docker se desarrolló inicialmente para Linux.
- Hyper-V: Para contenedores Windows (Licencia Pro/Enterprise)

**Instalación en MAC:**

- Chips M1: Arquitectura ARM

---

## Conceptos

- **Imágenes:** Las imágenes son plantillas de solo lectura que se utilizan para crear contenedores.
- **Contenedores:** Los contenedores son instancias en ejecución de estas imágenes.
- **Registros:** Los registros son almacenes donde se guardan las imágenes Docker.
- **Volúmenes:** Son utilizados para almacenar datos persistentes que sobreviven al ciclo de vida de un contenedor.
- **Networks:** Son utilizadas para conectar por red privadas los distintos contendores.

---

<div class="container-image">
  <img src="../../images/docker-architecture.png" alt="Arquitectura Docker" />
</div>
