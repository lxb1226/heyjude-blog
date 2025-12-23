---
title: "Cómo Crear un Blog en 10 Minutos"
date: 2025-05-05T20:28:24+08:00
lastmod: 2025-05-05T20:28:24+08:00
draft: false
keywords: ["crear blog", "Hugo tutorial", "sitio web estático", "blog gratis", "blog setup", "personal website", "static site generator", "blog theme", "web development"]
description: "Una guía detallada para crear un blog personal usando el generador de sitios estáticos Hugo, cubriendo instalación, selección de temas, configuración básica y gestión de contenido - todo en solo 10 minutos."
tags: ["hugo", "crear blog", "blog setup", "static site", "personal website", "tutorial"]
categories: ["Blog Setup", "Tutorials"]
series: ["blog tutorial"]
author: "heyjude"

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: true
toc: true
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# You can also define another contentCopyright. e.g. contentCopyright: "This is another copyright."
contentCopyright: false
reward: true
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# You unlisted posts you might want not want the header or footer to show
hideHeaderAndFooter: false

# You can enable or disable out-of-date content warning for individual post.
# Comment this out to use the global config.
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams:
  enable: false
  options: ""

---
## ¿Qué es Hugo?

Hugo es uno de los generadores de sitios estáticos de código abierto más populares. Los usuarios pueden construir rápidamente sus propios sitios web usando Hugo.

## Pasos de Configuración

### Instalar Hugo
En Mac, puedes usar el siguiente comando para instalar Hugo:
```bash
brew install hugo
```
![install](https://img.music-poster.art/2025/05/c9d27037a7d215ff8eaa14383cba62b6.png)

Después de la instalación, puedes verificar si está instalado correctamente usando `hugo version`:
![hugo_version](https://img.music-poster.art/2025/05/9368e5db6f1f18f70eba3017c7144a9b.png)

### Crear un Blog con Hugo
Una vez que Hugo esté instalado, puedes usarlo para crear tu propio blog.
Usa `hugo new site my-blog` para crear un sitio llamado my-blog.
![new-blog-site](https://img.music-poster.art/2025/05/c31b6d2f942a44af304823b9b2d40e76.png)
Después de ejecutar este comando, se creará un directorio llamado my-blog en el directorio actual.
Luego, navega a ese directorio e inicialízalo con git.
```bash
cd my-blog
git init
```

### Elegir un Tema
Después de crear el sitio web, necesitas elegir un tema. Hay muchos temas disponibles para seleccionar: [hugo themes](https://themes.gohugo.io/)
Aquí, estoy eligiendo el tema hugo-theme-even. En este punto, necesita ser agregado como un submódulo bajo themes/even.
```bash
git submodule add https://github.com/olOwOlo/hugo-theme-even.git themes/even
```
![pick-theme](https://img.music-poster.art/2025/05/10d92ec7695324dd4db2cb0772f764f8.png)
Después de eso, copia `themes/even/exampleSite/config.toml` al directorio actual y sobrescribe `hugo.toml`
```bash
cp themes/even/exampleSite/config.toml hugo.toml
```

### Crear una Publicación de Blog
Una vez que el tema esté configurado, puedes crear tu propia publicación de blog.
Usa `hugo new content/content/post/my-first-post.md` para crear una publicación de blog.
Puedes ver que aparecerá un nuevo archivo md bajo `content/post/` después de ejecutar este comando.
![my-first-blog](https://img.music-poster.art/2025/05/b6760e2f47eed1c8a962e475f69adc92.png)


### Ejecutar Hugo
Una vez que las configuraciones anteriores estén completas, puedes iniciar un servidor Hugo usando `hugo server`.
![](https://img.music-poster.art/2025/05/69da7f70c3795f266a83207d186d0ad4.png)
Haz clic en el enlace para acceder a la dirección del sitio web del blog.
![](https://img.music-poster.art/2025/05/10ebbce59ca6637b1b44c8d884c471bd.png)
En este punto, notarás que el blog creado anteriormente no aparece; la razón es que el blog creado anteriormente está configurado como `draft`, y no se mostrará en el modo `hugo server`.
Para mostrarlo, necesitas usar `hugo server -D`.
![](https://img.music-poster.art/2025/05/72c092d59ad8143fa61188eac94ace32.png)

Con esto, puedes completar la configuración de tu sitio web de blog.

### Guardar el Blog Local en GitHub
* Inicia sesión en GitHub y crea un nuevo repositorio (por ejemplo, heyjude-blog).
* Agrega el repositorio local como remoto:
```
git remote add origin https://github.com/yourusername/myblog.git
git push
```
De esta manera, puedes guardar tu blog en GitHub.

# Enlaces de Referencia
1. https://gohugo.io/getting-started/quick-start/
2. https://github.com/olOwOlo/hugo-theme-even
3. https://medium.com/@magstherdev/hugo-in-10-minutes-2dc4ac70ee11
