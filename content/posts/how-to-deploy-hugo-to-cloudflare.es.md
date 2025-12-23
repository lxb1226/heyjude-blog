---
title: Crear un Blog con Hugo y Desplegarlo en Cloudflare Pages
date: 2025-06-16T20:29:00+08:00
tags: [Hugo, Cloudflare, crear blog, Blog, Static Site, Deployment]
categories: [Technical Tutorial]
description: Este artículo detalla cómo crear un blog usando el generador de sitios estáticos Hugo y desplegarlo a través de Cloudflare Pages, incluyendo pasos completos para configuración del entorno, instalación de temas, creación de contenido y vinculación de dominios.
slug: deploy-hugo-to-cloudflare
keywords: ["crear blog", "Hugo tutorial", "sitio web estático", "blog gratis", "Cloudflare Pages", "deployment", "web hosting"]
---

# Crear un Blog con Hugo y Desplegarlo en Cloudflare Pages

En este artículo, te guiaré paso a paso a través del proceso completo de construcción de un blog personal usando [Hugo](https://gohugo.io/) y desplegarlo en [Cloudflare Pages](https://pages.cloudflare.com/). Hugo es un generador de sitios estáticos rápido y flexible, mientras que Cloudflare Pages ofrece servicios de alojamiento gratuitos con aceleración CDN global, permitiendo que tu blog esté en línea rápidamente y proporcione una buena experiencia de usuario. Ya seas un novato técnico o un desarrollador experimentado, este tutorial te ayudará a configurar rápidamente tu propio blog.

## ¿Por Qué Elegir Hugo y Cloudflare Pages?

- **Hugo**: Escrito en Go, es extremadamente rápido, soporta una rica variedad de temas y formato Markdown, siendo adecuado para blogs y sitios de documentación.
- **Cloudflare Pages**: Proporciona una integración perfecta con GitHub, despliegue automático, certificados SSL gratuitos y aceleración CDN global, ofreciendo mejores velocidades de acceso que GitHub Pages.
- **Costo**: La combinación de ambos es completamente gratuita, ideal para blogs personales o pequeños proyectos.

## Preparación

Antes de comenzar, necesitas preparar las siguientes herramientas y cuentas:

1. **Hugo**: Instala la última versión de Hugo (se recomienda usar la versión extendida para más características).
2. **Git**: Para el control de versiones y enviar código a GitHub.
3. **Cuenta de GitHub**: Para almacenar el código fuente del blog.
4. **Cuenta de Cloudflare**: Para desplegar y alojar el blog.
5. **Editor de Texto**: Como VSCode, para editar archivos Markdown y archivos de configuración.

## Paso 1: Instalar Hugo

### Windows
1. Instala el gestor de paquetes Chocolatey (si aún no está instalado):
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
2. Usa Chocolatey para instalar la versión extendida de Hugo:
   ```powershell
   choco install hugo-extended
   ```
3. Verifica la instalación:
   ```powershell
   hugo version
   ```

### macOS
1. Instala usando Homebrew:
   ```bash
   brew install hugo
   ```
2. Verifica la instalación:
   ```bash
   hugo version
   ```

Para más métodos de instalación, consulta la [documentación oficial de Hugo](https://gohugo.io/getting-started/installing/).

## Paso 2: Crear un Sitio Hugo

1. Crea un nuevo sitio en la terminal:
   ```bash
   hugo new site my-blog
   cd my-blog
   ```
   Esto generará la estructura de directorios del sitio Hugo en la carpeta `my-blog`:
   ```
   ├── archetypes
   ├── content
   ├── data
   ├── layouts
   ├── public
   ├── static
   ├── themes
   └── hugo.toml
   ```

2. Inicializa un repositorio Git:
   ```bash
   git init
   ```

3. Agrega un archivo `.gitignore` para ignorar archivos generados:
   ```bash
   echo "public/" >> .gitignore
   echo "resources/" >> .gitignore
   ```

## Paso 3: Instalar y Configurar el Tema

1. Elige un tema de Hugo, por ejemplo, [hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack):
   ```bash
   git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
   ```

2. Copia el archivo de configuración de ejemplo del tema a la raíz del proyecto:
   ```bash
   cp themes/hugo-theme-stack/exampleSite/config.yaml .
   ```

3. Edita `config.yaml` (o `hugo.toml`) para establecer información básica:
   ```yaml
   baseURL: "https://your-domain.com/"  # Reemplaza con tu dominio
   languageCode: "es"
   title: "Mi Blog"
   theme: "hugo-theme-stack"
   DefaultContentLanguage: "es"
   paginate: 5
   ```

Para más configuración del tema, consulta la documentación oficial del tema.

## Paso 4: Crear Tu Primera Publicación de Blog

1. Crea una nueva publicación:
   ```bash
   hugo new posts/mi-primera-publicacion.md
   ```
   Esto generará el archivo `mi-primera-publicacion.md` en el directorio `content/posts/`.

2. Edita el contenido de la publicación y modifica el Front Matter (metadatos de la publicación):
   ```markdown
   ---
   title: "Mi Primera Publicación de Blog"
   date: 2025-06-16T20:29:00+08:00
   draft: false
   ---
   ¡Bienvenido al blog de Hugo! Esta es mi primera publicación.
   ```

3. Inicia el servidor local de Hugo para previsualizar:
   ```bash
   hugo server -D
   ```
   Abre el navegador y ve a `http://localhost:1313/` para ver la vista previa local del blog.

## Paso 5: Enviar Código a GitHub

1. Crea un nuevo repositorio en GitHub (como `my-blog`), ya sea público o privado.
2. Envía el código local a GitHub:
   ```bash
   git add .
   git commit -m "Commit inicial"
   git remote add origin https://github.com/your-username/my-blog.git
   git branch -M main
   git push -u origin main
   ```

## Paso 6: Desplegar en Cloudflare Pages

1. Inicia sesión en el [Panel de Cloudflare](https://dash.cloudflare.com/), ve a "Workers and Pages" > "Pages" > "Create a Project".
![](https://img.music-poster.art/2025/06/460d03da3f5f0c737c60951d16dd12b4.png)
2. Conecta tu cuenta de GitHub y selecciona el repositorio `my-blog` recién creado.
![](https://img.music-poster.art/2025/06/5577398c00ea3e040f927f4272d7d5c9.png)
3. Configura los ajustes de construcción:
   - **Project Name**: Cualquier nombre (como `my-blog`), asignará un subdominio como `my-blog.pages.dev`.
   - **Production Branch**: Por defecto es `main`.
   - **Build Command**: `hugo --gc --minify` (optimiza los archivos de salida).
   - **Output Directory**: `public`.
   - **Environment Variables**: Agrega `HUGO_VERSION` (como `0.125.4`) para especificar la versión de Hugo, se recomienda usar la última versión; consulta las [versiones de Hugo](https://github.com/gohugoio/hugo/releases).
   ![](https://img.music-poster.art/2025/06/4ce72f3294fdc3f92e2a504e70a11b5a.png)
4. Haz clic en "Save and Deploy", Cloudflare Pages automáticamente extraerá el código, construirá y desplegará. Una vez que el despliegue esté completo, puedes acceder a tu blog a través de `my-blog.pages.dev`.
![](https://img.music-poster.art/2025/06/50fc6325948a3ddc3aa9a424b56a6f65.png)

## Paso 7: Vincular un Dominio Personalizado

1. Asegúrate de que tu dominio esté alojado en Cloudflare (puedes comprarlo a través de Cloudflare o migrarlo desde otros registradores).
2. En el proyecto de Cloudflare Pages, haz clic en "Custom Domain" > "Set Custom Domain".
3. Ingresa tu dominio (como `your-domain.com`), Cloudflare automáticamente agregará un registro CNAME.
4. Espera a que la resolución DNS surta efecto (generalmente de unos pocos minutos a unas pocas horas), luego accede a tu blog usando el dominio personalizado.

## Paso 8: Despliegue Automatizado

Cada vez que actualices el contenido de tu blog (como agregar nuevas publicaciones o modificar configuraciones), simplemente ejecuta los siguientes comandos para enviar el código:
```bash
git add .
git commit -m "Actualizar contenido del blog"
git push origin main
```
Cloudflare Pages detectará automáticamente las actualizaciones en el repositorio de GitHub, reconstruirá y redeplegará, típicamente completando en 1-2 minutos.

## Problemas y Soluciones

1. **Discrepancia en la Versión de Hugo**: Cloudflare Pages podría tener por defecto una versión antigua de Hugo, causando fallos en la construcción. La solución es especificar la última versión en las variables de entorno (como `HUGO_VERSION=0.125.4`).
2. **Publicaciones No Se Muestran**: Verifica si `draft: false` está configurado correctamente, ya que Hugo no renderiza publicaciones con `draft: true` por defecto.
3. **Velocidad de Acceso Lenta desde China**: Asegúrate de que el dominio esté acelerado por el CDN de Cloudflare y SSL esté habilitado.

## Resumen

Con Hugo y Cloudflare Pages, puedes construir rápidamente un blog personal de alto rendimiento y gratuito. Hugo proporciona gestión de contenido flexible y soporte rico de temas, mientras que el despliegue automático y la aceleración CDN global de Cloudflare Pages aseguran que la publicación y el acceso del blog sean más eficientes.

## Referencias
- [Documentación Oficial de Hugo](https://gohugo.io/documentation/)
- [Documentación Oficial de Cloudflare Pages](https://developers.cloudflare.com/pages/)
