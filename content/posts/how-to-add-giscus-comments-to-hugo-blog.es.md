---
title: "Integrar Sistema de Comentarios Giscus en Blog de Hugo"
date: 2025-06-15
slug: "giscus-comments-hugo"
tags: ["Hugo", "Sistema de Comentarios", "Giscus", "Configuración de Blog", "GitHub Discussions", "Blog Estático", "Interacción de Blog", "Comentarios Open Source", "Configuración Sin Costo"]
keywords: ["sistema de comentarios Giscus", "comentarios blog Hugo", "comentarios GitHub Discussions", "solución comentarios blog estático", "herramienta comentarios open source", "sistema interacción blog", "sistema comentarios gratis", "personalización tema Hugo", "extensión características blog"]
description: "Esta guía completa demuestra cómo integrar el sistema de comentarios Giscus en tu blog de Hugo, una solución moderna de comentarios impulsada por GitHub Discussions. Aprende a configurar un sistema de comentarios seguro con soporte Markdown y sin costo, con modo oscuro y soporte multilingüe, perfecto para blogs estáticos de Hugo. No se requiere base de datos: todos los datos de comentarios se almacenan de forma segura en GitHub, garantizando la seguridad y sostenibilidad de los datos."
---

Este es el tercer tutorial sobre la construcción de tu propio sistema de blog, enfocado en agregar un sistema de comentarios.

Durante el proceso de configuración del blog, un buen sistema de comentarios puede mejorar enormemente la interactividad. Hoy, presentaré cómo integrar [Giscus](https://giscus.app/), un sistema de comentarios open source basado en GitHub Discussions, en un blog de Hugo.

## ¿Por Qué Elegir Giscus?

- 🚀 No requiere servidor, basado en GitHub Discussions
- 🔒 Seguro y confiable, los datos de comentarios se almacenan en GitHub
- 🧩 Soporta modo oscuro y temas adaptativos
- 💬 Soporta comentarios anónimos (opcional)
- 🌍 Soporte de interfaz multilingüe

## Preparación

Antes de comenzar, necesitas:

1. Un repositorio alojado en GitHub
2. Funcionalidad de Discussions habilitada
3. Un blog de Hugo (cualquier tema funciona)

## Paso 1: Habilitar GitHub Discussions

1. Abre el repositorio de código de tu blog (por ejemplo, `usuario/blog`).
2. Haz clic en **Settings** → **Features** → Marca **Discussions**.
![](https://img.music-poster.art/2025/06/8c0271325d91ad29527d1acef14fd869.png)
## Paso 2: Configurar Giscus

Ve a [https://giscus.app](https://giscus.app), y en la página:

1. Selecciona tu repositorio de GitHub.
2. Configura en qué categoría de Discussion crear los comentarios (puedes crear una nueva como `announcement`).
3. Configuración personalizada:
   - Mapping: Se recomienda elegir `pathname`, que asocia discussions por la ruta de la página.
   - Reaction: Si permitir me gusta y otras acciones.
   - Theme: Soporta `light`, `dark`, `preferred_color_scheme`, etc.
4. Copia el código `<script>` generado.
![](https://img.music-poster.art/2025/06/116ebde5a465cfbea4f3c5b84192be3d.png)
Por ejemplo, el código generado se ve así:

```html
<script src="https://giscus.app/client.js"
        data-repo="yourname/yourrepo"
        data-repo-id="REPO_ID"
        data-category="General"
        data-category-id="CATEGORY_ID"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="zh-CN"
        crossorigin="anonymous"
        async>
</script>
```

Aquí necesitas recordar los tres parámetros: `data-repo`, `data-repo-id` y `data-category-id`, que se usarán en la siguiente configuración.

## Paso 3: Integrar Giscus en Tu Tema de Hugo
El tema que estoy usando es [hugo-narrow](https://github.com/tom2almighty/hugo-narrow), que integra el sistema de comentarios Giscus, y solo necesitas hacer un poco de configuración. Aquí está mi configuración:

```yaml
  comments:
    enabled: true
    # giscus, disqus, utterances, waline, artalk, twikoo
    system: "giscus"

    giscus:
      repo: "data-repo"
      repoId: "data-repo-id"
      category: "Announcements"
      categoryId: "data-category-id"
      mapping: "pathname"
      strict: "0"
      reactionsEnabled: "1"
      emitMetadata: "0"
      inputPosition: "bottom"
      theme: "preferred_color_scheme"
      lang: "en"
```
Ten en cuenta que necesitas reemplazar `repo`, `repoId` y `categoryId` con los valores guardados en el Paso 2. Esto es necesario para que los comentarios se muestren correctamente.
Además, asegúrate de que `enabled` esté configurado como `true` y `system` esté configurado como `giscus`. De lo contrario, los comentarios no se mostrarán.

Finalmente, verás una interfaz como esta en la parte inferior del artículo:
![](https://img.music-poster.art/2025/06/2e3b16e884ac6d67db1651a8d44197db.png)

## Pruebas

Puedes comentar en este artículo y ver si los comentarios se muestran correctamente. Los comentarios se pueden verificar en GitHub Discussions.

Por ejemplo, puedes ver los comentarios en mi blog [aquí](https://github.com/lxb1226/lxb1226.github.io/discussions).

![](https://img.music-poster.art/2025/06/fdc145c668e761fb68870ce841967e08.png)
