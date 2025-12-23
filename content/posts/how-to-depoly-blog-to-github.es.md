---
title: "Cómo Desplegar tu Blog en GitHub Pages en 10 Minutos"
subtitle: "Hosting Gratuito para tu Blog de Hugo en GitHub Pages"
date: 2025-05-18T17:01:07+08:00
lastmod: 2025-05-18T17:01:07+08:00
draft: false
authors: ["heyjude"]
description: "Guía paso a paso para desplegar tu blog de Hugo en GitHub Pages, incluyendo la configuración del repositorio, configuración de GitHub Actions y flujo de trabajo de despliegue automatizado, ayudándote a crear un sitio web de blog profesional a costo cero."

tags: ["hugo", "github pages", "automated deployment", "static site", "CI/CD"]
categories: ["Blog Setup", "Tutorials", "Automation"]
series: ["blog tutorial"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

Una vez que hemos construido nuestro sitio web de blog localmente, el siguiente paso es distribuir el contenido del blog en línea para que otros puedan verlo.

Investigué los sitios web de hosting actuales y encontré las siguientes opciones:

- **GitHub Pages**: Un servicio gratuito de hosting de sitios estáticos proporcionado por GitHub, adecuado para integración con repositorios de código.
- **Netlify**: Admite construcción y despliegue automáticos, características ricas en el plan gratuito, con muy buen soporte para Hugo.
- **Vercel**: Desarrollado por el equipo de Next.js, despliegue rápido, adecuado para proyectos frontend.
- **Cloudflare Pages**: Servicio de hosting de sitios estáticos proporcionado por Cloudflare, viene con aceleración CDN y de seguridad.
- **Firebase Hosting**: Una plataforma de hosting frontend lanzada por Google, adecuada para usar con aplicaciones frontend.
- **Amazon S3 + CloudFront**: Una solución de alto rendimiento de hosting y distribución, adecuada para despliegues profesionales.
- **GitLab Pages**: Servicio de hosting de sitios estáticos proporcionado por GitLab, construye automáticamente a través de configuración CI.
- **Render**: Una plataforma de hosting full-stack simplificada, admite el despliegue automático de sitios de Hugo.
- **Surge.sh**: Una herramienta minimalista de hosting de sitios estáticos, despliegue de línea de comandos simple y rápido.
- **DigitalOcean App Platform**: Plataforma de servicio en la nube que admite el despliegue automático de sitios web estáticos y servicios backend.

Estas plataformas tienen sus propias características, y presentaré cómo desplegar en cada una en próximos artículos. En este artículo, presentaré cómo desplegar un sitio web de blog en GitHub Pages.

## ¿Qué es GitHub Pages?

GitHub Pages es un servicio gratuito de hosting de sitios web estáticos proporcionado por GitHub, adecuado para hosting de blogs, páginas de inicio de proyectos, documentación, etc. Solo necesitas un repositorio de GitHub para publicar tu sitio web en https://tunombre.github.io o un dominio personalizado.

## Cómo Desplegar un Sitio Web de Blog en GitHub Pages

### Plan General
* Tu repositorio principal (por ejemplo, my-hugo-site) contiene el código fuente de Hugo (content/, layouts/, etc.).
* Los archivos estáticos construidos (public/) se enviarán a otro repositorio (tunombredeusuario.github.io).
* El repositorio tunombredeusuario.github.io es específicamente para hosting del sitio web estático generado.

### Estructura del Proyecto

Asumiendo que tienes dos repositorios de GitHub:
* my-hugo-site (repositorio de origen): almacena el código fuente de Hugo y los artículos.
* tunombredeusuario.github.io (repositorio de despliegue): almacena los archivos estáticos construidos.

La estructura del proyecto es la siguiente:
```
my-hugo-site/
├── content/            # Contenido del blog
├── layouts/            # Layouts personalizados para Hugo
├── themes/             # Temas de Hugo
├── config.toml        # Archivo de configuración de Hugo
└── .github/workflows/deploy.yml  # Configuración de despliegue automático

tunombredeusuario.github.io/
├── (archivos del sitio web estático publicado)   # Archivos estáticos generados por Hugo
```

### Paso 1: Crear Dos Repositorios

1. Crea dos repositorios en GitHub:
  * my-hugo-site: para almacenar el código fuente de Hugo.
  * tunombredeusuario.github.io: para almacenar los archivos estáticos construidos.

2. En el repositorio tunombredeusuario.github.io, establece la rama de origen para GitHub Pages en main (o master).

### Paso 2: Configurar GitHub Actions para Despliegue Automatizado

En el repositorio my-hugo-site, crea el archivo .github/workflows/deploy.yml para configurar las construcciones automatizadas y enviar los archivos estáticos al repositorio tunombredeusuario.github.io.

```yaml
name: GitHub Pages

on:
  push:
    branches:
      - main  # La rama predeterminada para el directorio raíz del blog; aquí es main, a veces es master
  pull_request:

jobs:
  deploy:
    runs-on: ubuntu-24.04
    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.147.0'  # Especifica tu versión de Hugo, puedes verificar usando hugo version
          extended: true          # Si estás usando una versión no extendida de Hugo, cambia true a false

      - name: Build
        run: git submodule update --init --recursive && hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: ${{ github.ref == 'refs/heads/main' }}  # Asegúrate de usar main o master
        with:
          personal_token: ${{ secrets.MY_PAT}} # Si el secreto tiene otro nombre, reemplaza MY_PAT con ese nombre
          external_repository: lxb1226/lxb1226.github.io # Completa el repositorio remoto, no necesariamente este formato, escribe según tu situación
          publish_dir: ./public
          #cname: www.example.com        # Completa tu dominio personalizado. Si no se usa dominio personalizado, comenta esta línea
```

Puedes consultar mi [deploy.yaml](https://github.com/lxb1226/heyjude-blog/blob/main/.github/workflows/deploy.yaml)

### Obtener GitHub Secrets

En el archivo yaml anterior, necesitas obtener el `personal_token`. Puedes obtenerlo del repositorio my-hugo-site.

Puedes recuperarlo en el repositorio -> Settings -> Secrets and variables -> Actions.
![personal_token](https://img.music-poster.art/2025/05/5331092ac30840b1bc967395cce01709.png)

### Paso 3: Configurar GitHub Pages

1. En el repositorio tunombredeusuario.github.io, ve a Settings → Pages.
2. Establece el Source en la rama main y asegúrate de que GitHub Pages esté configurado correctamente.
3. Después de guardar, el sitio web estático será hosted en https://tunombredeusuario.github.io/.
![](https://img.music-poster.art/2025/05/9052201a8331d0e293e23b1741d0fc80.png)

## Proceso de Publicación Automática del Blog

1. Escribe artículos y modifica el sitio en el repositorio my-hugo-site.
2. Cada vez que envías actualizaciones a la rama main, GitHub Actions construirá automáticamente y enviará los archivos estáticos al repositorio tunombredeusuario.github.io.
3. GitHub Pages se actualizará automáticamente y se mostrará en https://tunombredeusuario.github.io/. (Por lo general, esto toma algún tiempo)

## Referencias

1. https://docs.github.com/en/actions
2. https://gohugo.io/documentation/
3. https://lxb1226.github.io/
4. https://github.com/lxb1226/heyjude-blog
