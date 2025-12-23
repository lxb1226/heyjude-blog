---
title: "Cómo Sincronizar tu Blog Hugo al Perfil de GitHub con GitHub Actions Automáticamente"
date: 2025-06-21T22:00:00+08:00
draft: false
tags: ["Hugo", "GitHub", "Blog Sync", "GitHub Actions", "Automation"]
categories: ["Technology", "Blog Setup"]
description: "Un tutorial detallado sobre el uso de GitHub Actions con gautamkrishnar/blog-post-workflow para sincronizar automáticamente tu blog Hugo al perfil de GitHub, incluyendo pasos de configuración y precauciones."
---

## Cómo Sincronizar tu Blog Hugo al Perfil de GitHub

Después de haber desplegado nuestro blog, queremos que nuestro perfil de GitHub se actualice automáticamente cada vez que haya una nueva publicación de blog, para que nuestro perfil pueda mostrar nuestros últimos artículos. Podemos lograr esto con `GitHub Actions`.

## Requisitos Previos

Antes de comenzar, asegúrate de haber completado los siguientes preparativos:

- **Blog Hugo**: Un blog Hugo configurado y alojado en un repositorio de GitHub (como `username/username.github.io` o un repositorio personalizado).
- **Repositorio de GitHub**: Un repositorio para almacenar los archivos fuente de tu blog (por ejemplo, `username/blog`) y un repositorio para GitHub Pages (por ejemplo, `username/username.github.io`).
- **README de Perfil de GitHub**: El Profile README está habilitado en GitHub (crea un repositorio con el mismo nombre que tu nombre de usuario, como `username/username`, por ejemplo, [Mi Perfil de GitHub](https://github.com/lxb1226/lxb1226)).
- **Conocimientos Básicos de Git**: Entender cómo hacer commit de código, configurar `.gitignore` y usar GitHub Actions.

## ¿Qué es blog-post-workflow?

`blog-post-workflow` es una GitHub Action desarrollada por Gautam Krishnar, diseñada para sincronizar las últimas publicaciones de blog al GitHub Profile README u otras ubicaciones especificadas. Admite múltiples frameworks de blogs (incluyendo Hugo) y recupera las últimas publicaciones analizando el feed RSS, actualizando automáticamente el archivo de destino.

## Paso 1: Configurar el Repositorio del Blog Hugo

1. **Asegurarse de que el Blog Hugo Genere un Feed RSS**:
   Hugo genera un feed RSS de forma predeterminada (generalmente ubicado en `public/index.xml`). En tu archivo de configuración de Hugo (`config.toml` o `config.yaml`), asegúrate de que la salida RSS esté habilitada:
   ```toml
   [outputs]
   home = ["HTML", "RSS"]
   ```
   Después de ejecutar el comando `hugo`, verifica el archivo `index.xml` en el directorio `public`.

   Tips: Si tu blog es multilingüe, la dirección del feed RSS debe ser `https://tu-dominio-blog/index.xml`, no `https://tu-dominio-blog/en/index.xml` o `https://tu-dominio-blog/zh/index.xml`, etc.

2. **Alojar Contenido del Blog**:
   - Asegúrate de que los archivos fuente de tu blog Hugo estén almacenados en un repositorio (por ejemplo, `username/blog`).
   - Los archivos estáticos (el directorio `public`) deben ser enviados al repositorio de GitHub Pages (por ejemplo, `username/username.github.io`).
   - En la configuración del repositorio de GitHub Pages, habilita GitHub Pages y selecciona la rama correcta (generalmente `main` o `gh-pages`).

3. **Verificar Acceso al Blog**:
   Asegúrate de que tu blog sea accesible a través de un dominio personalizado (por ejemplo, `https://username.github.io`) o del dominio predeterminado de GitHub Pages.

## Paso 2: Configurar el README del Perfil de GitHub

1. **Crear Repositorio README del Perfil**:
   - Crea un repositorio en GitHub que tenga el mismo nombre que tu nombre de usuario (por ejemplo, `username/username`).
   - Crea un archivo `README.md` en el directorio raíz del repositorio para mostrar el contenido de tu Perfil de GitHub.

2. **Agregar Marcador de Posición del Blog**:
   Agrega un marcador de posición en `README.md` para insertar dinámicamente artículos del blog. Por ejemplo:
   ```markdown
   ## Mis Últimos Artículos del Blog
   <!-- BLOG-POST-LIST:START -->
   <!-- BLOG-POST-LIST:END -->
   ```

   El `blog-post-workflow` reemplazará este marcador de posición con enlaces a los últimos artículos del blog.

## Paso 3: Configurar blog-post-workflow

1. **Crear Flujo de Trabajo de GitHub Actions**:
   En tu repositorio README del Perfil (`username/username`), crea la siguiente estructura de directorios:
   ```
   .github/workflows/blog-post.yml
   ```

2. **Escribir Archivo de Flujo de Trabajo**:
   Agrega el siguiente contenido a `blog-post.yml` para configurar `blog-post-workflow`:
   ```yaml
   name: Sync Blog to Profile README

   on:
     schedule:
       - cron: "0 0 * * *" # Ejecutar una vez al día
     workflow_dispatch: # Permitir disparo manual

   jobs:
     update-readme-with-blog:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: gautamkrishnar/blog-post-workflow@v1
           with:
             feed_list: "https://username.github.io/index.xml" # Reemplaza con la dirección RSS de tu blog
             max_post_count: 5 # Sincronizar los últimos 5 artículos
             readme_path: ./README.md # Archivo README de destino
             commit_message: "Update README with latest blog posts"
   ```
   - **feed_list**: Reemplaza con la dirección del feed RSS de tu blog Hugo (generalmente `https://tu-dominio-blog/index.xml`).
   - **max_post_count**: Establece el número de artículos recientes a mostrar.
   - **readme_path**: Asegúrate de que apunte a la ruta correcta del archivo README.
   - **commit_message**: Personaliza el mensaje de commit.

3. **Confirmar Archivo de Flujo de Trabajo**:
   Haz commit de `blog-post.yml` en tu repositorio README del Perfil. GitHub Actions se ejecutará automáticamente a la medianoche (UTC) diariamente o puede activarse manualmente a través del panel de GitHub Actions.

## Paso 4: Verificar Resultados de Sincronización

1. **Verificar Registros de GitHub Actions**:
   - Ve a la pestaña Actions del repositorio README del Perfil para ver el estado del flujo de trabajo `Sync Blog to Profile README`.
   - Asegúrate de que no haya errores y de que el flujo de trabajo se haya completado correctamente.
   ![](https://img.music-poster.art/2025/06/133d3d31fe568cbba71be00326fe6420.png)
   - También puedes activar manualmente el flujo de trabajo para verificar si el README se ha actualizado. Haz clic en `Run workflow` para activarlo manualmente.
   ![](https://img.music-poster.art/2025/06/bd7d8b28b5a2538881cfd90a878dcd8e.png)

2. **Ver Actualización del README**:
   - Abre el `README.md` del repositorio `username/username` para verificar si el marcador de posición `<!-- blog-post-workflow -->` ha sido reemplazado con la lista de las últimas publicaciones del blog.
   - La salida de muestra puede verse como:
     ```markdown
     ## Mis Últimos Artículos del Blog
     - [Título del Artículo 1](https://username.github.io/post/xxx) - 2025-06-21
     - [Título del Artículo 2](https://username.github.io/post/yyy) - 2025-06-20
     ```

3. **Acceder al Perfil de GitHub**:
   Abre tu página de perfil de GitHub (por ejemplo, `https://github.com/username`) y confirma que los últimos artículos del blog se muestran en el Profile README.
   ![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

## Notas

- **Disponibilidad del Feed RSS**: Asegúrate de que el feed RSS de tu blog (`index.xml`) sea accesible a través de una URL pública. Si el blog está alojado en un repositorio privado, considera cambiar a un repositorio público o proporcionar RSS a través de otro medio.
- **Permisos de GitHub Actions**: Asegúrate de que tu repositorio tenga habilitados los permisos de escritura de Actions (Settings > Actions > General > Allow all actions and reusable workflows).
- **Frecuencia de Sincronización**: La configuración predeterminada es sincronizar una vez al día, pero puedes ajustar la expresión `cron` según sea necesario (por ejemplo, cada hora: `0 * * * *`).
- **Depuración**: Si la sincronización falla, verifica los registros de Actions. Los problemas comunes incluyen una dirección RSS incorrecta o una ruta de archivo README incorrecta.

---

**Recursos de Referencia**:
- [gautamkrishnar/blog-post-workflow](https://github.com/gautamkrishnar/blog-post-workflow)
- [Documentación Oficial de Hugo](https://gohugo.io/documentation/)
- [Documentación de GitHub Actions](https://docs.github.com/en/actions)
