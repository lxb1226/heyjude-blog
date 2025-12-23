---
title: Despliega Umami Fácilmente para Estadísticas de Tráfico Web en Vercel
date: 2025-06-15
tags: [Umami, Vercel, Neon, Estadísticas de Tráfico Web, Open Source, Hugo, Análisis Web, Análisis de Datos, Seguimiento de Visitantes, Alternativa a Google Analytics, PostgreSQL, Despliegue Sin Costo]
categories: [Tutorial Técnico]
keywords: [guía de despliegue Umami, hosting gratuito Vercel, base de datos Neon, análisis web, alternativa a Google Analytics, análisis de código abierto, estadísticas blog Hugo, configuración sin costo, seguimiento visitantes sitio web, protección privacidad datos]
description: Esta guía completa te muestra cómo aprovechar los servicios gratuitos de Vercel y la base de datos PostgreSQL Neon para configurar rápidamente un sistema de análisis web enfocado en la privacidad usando Umami. Esta solución sin costo es perfecta para blogs personales y sitios web pequeños y medianos, ofreciendo una alternativa más ligera y consciente de la privacidad a Google Analytics. A través de la arquitectura Serverless de Vercel, puedes implementar fácilmente el monitoreo de tráfico web que es totalmente compatible con Hugo y otros sitios estáticos.
---

Umami es una herramienta de estadísticas de sitios web de código abierto, simple, rápida y enfocada en la privacidad, lo que la convierte en una alternativa ideal a Google Analytics. Este artículo te guiará sobre cómo desplegar Umami en Vercel y crear una base de datos PostgreSQL Neon a través de Vercel Storage, para construir un sistema de estadísticas de tráfico web ligero y sin costo. Este tutorial está específicamente optimizado para usuarios de sitios estáticos Hugo, asegurando que los archivos Markdown generados sean compatibles con la generación de sitios estáticos de Hugo.

## Introducción

Para blogs personales o sitios web pequeños y medianos, Google Analytics puede ser demasiado complejo y inconveniente de acceder en ciertas regiones. Umami ofrece una interfaz limpia con métricas centrales, lo que lo hace adecuado para necesidades de análisis de tráfico ligero. Con el despliegue serverless de Vercel y la base de datos Neon integrada a través de Vercel Storage, podemos configurar rápidamente un sistema de estadísticas eficiente sin costos de mantenimiento del servidor.

Aquí están los pasos detallados de despliegue.

## Preparativos

Antes de comenzar, asegúrate de tener lo siguiente:

1. **Cuenta de GitHub**: Para hacer fork del repositorio Umami.
2. **Cuenta de Vercel**: Para desplegar Umami y crear la base de datos Neon.
3. **Cuenta de Neon**: Registrada, para conectarse a través de Vercel Storage.
4. Un sitio web Hugo en ejecución (u otro sitio estático) para incrustar el código de seguimiento de Umami.

## Paso 1: Hacer Fork del Repositorio Umami

1. Visita el repositorio GitHub oficial de Umami: [https://github.com/umami-software/umami](https://github.com/umami-software/umami).
2. Haz clic en el botón **Fork** en la esquina superior derecha para hacer fork del repositorio en tu cuenta de GitHub.
3. (Opcional) Si necesitas personalizar Umami, puedes clonar el repositorio localmente para modificaciones, pero este tutorial usa la configuración predeterminada.

## Paso 2: Desplegar Umami en Vercel

1. Inicia sesión en el [sitio web de Vercel](https://vercel.com/), haz clic en **Add New** > **Project**.
2. En la página **Import Git Repository**, selecciona el repositorio Umami que acabas de hacer fork.
3. Configura el proyecto:
   - **Framework Preset**: Elige **Next.js** (Umami está construido sobre Next.js).
   - **Environment Variables**: Salta por ahora; configurarás el `DATABASE_URL` para la base de datos Neon más tarde.
4. Haz clic en el botón **Deploy**, y Vercel construirá automáticamente el proyecto (puede fallar inicialmente debido a la falta de una conexión de base de datos, lo cual se corregirá más tarde).

## Paso 3: Crear Base de Datos Neon en Vercel Storage

1. En el panel de Vercel, ve a tu proyecto Umami.
2. Haz clic en la pestaña **Storage** en la navegación superior, luego selecciona **Create Database**.
![](https://img.music-poster.art/2025/06/cba773362305001171fb5d0defb4f960.png)
3. Selecciona **Neon** bajo Database Type e inicia sesión en tu cuenta de Neon para autorizar el acceso de Vercel.
4. Configura la base de datos:
   - **Project Name**: Cualquier nombre, por ejemplo, `umami-project`.
   - **Database Name**: Se recomienda usar `umami`.
   - **Cloud Service Provider**: Elige tu región (por ejemplo, región de Asia de AWS) para reducir la latencia.
5. Al crear, Vercel generará automáticamente un **DATABASE_URL** y lo agregará a las variables de entorno del proyecto en el siguiente formato:
   ```
   postgresql://[username]:[password]@[host]/[database]
   ```
6. Vuelve a la configuración del proyecto para confirmar que `DATABASE_URL` esté incluido en las **Environment Variables**.
7. Redespliega el proyecto: Haz clic en la pestaña **Deployments**, selecciona el despliegue más reciente y haz clic en **Redeploy**.

## Paso 4: Configurar Umami

1. Una vez desplegado, haz clic en **Visit** para ver tu instancia de Umami y toma nota del nombre de dominio predeterminado asignado (por ejemplo, `tu-proyecto.vercel.app`).
2. Visita el sitio web de Umami, y las credenciales de inicio de sesión predeterminadas para la primera vez son:
   - Nombre de usuario: `admin`
   - Contraseña: `umami`
3. Cambia la contraseña inmediatamente después de iniciar sesión por seguridad.
4. En el panel de Umami, haz clic en **Add Website**, e ingresa la información de tu sitio web (por ejemplo, dominio, nombre).
![](https://img.music-poster.art/2025/06/2b0b37c13001ea761ffcd370f170defc.png)
5. Umami generará un código de seguimiento JavaScript en el siguiente formato:
   ```html
   <script async src="https://tu-proyecto.vercel.app/umami.js" data-website-id="TU_WEBSITE_ID"></script>
   ```
   Copia este código.

## Paso 5: Incrustar Código de Seguimiento en el Sitio Web Hugo

Para permitir que Umami rastree el tráfico de tu sitio web Hugo, necesitas incrustar el código de seguimiento en tu sitio web. Esto generalmente requiere que el tema de Hugo que estés usando lo soporte; si no, necesitarás modificar el tema de Hugo tú mismo.

Aquí, estoy usando el tema [hugo-narrow](https://github.com/luizdepra/hugo-narrow), que admite la configuración de Umami. Por lo tanto, puedes configurarlo en el archivo `hugo.yaml`:
```yaml
  analytics:
    enabled: true
    umami:
      enabled: true
      id: "TU_WEBSITE_ID"
      src: "https://tu-proyecto.vercel.app/umami.js"
      domains: ""
```
Reemplaza `TU_WEBSITE_ID` con el ID del sitio web que creaste en Umami. El `src` también debe actualizarse a tu dominio de proyecto Umami desplegado en Vercel.

Luego visita tu sitio web, y Umami comenzará a recopilar datos de tráfico.

## Paso 6: Validación y Optimización

1. Vuelve al panel de Umami y espera unos minutos para verificar si se han registrado datos de tráfico.
2. Verifica si el código de seguimiento está funcionando correctamente:
   - Abre las Herramientas de Desarrollador del navegador (F12), cambia a la pestaña **Network**, actualiza la página y confirma si hay una solicitud a `tu-proyecto.vercel.app/api/collect`.
3. (Opcional) Personaliza el panel de Umami:
   - Agrega múltiples sitios web para seguimiento.
   - Configura enlaces de intercambio de datos para compartir fácilmente las estadísticas con tu equipo.
   - Ajusta el tema o la configuración de idioma de Umami para admitir una interfaz en español.

## Notas

- **Plan Gratuito de Neon**: La base de datos Neon creada a través de Vercel Storage tiene límites en almacenamiento y tiempo de cómputo, adecuada para sitios web pequeños. Si el tráfico es alto, considera actualizar a un plan pago.
- **Plan Gratuito de Vercel**: El plan gratuito de Vercel ofrece 100GB de ancho de banda por mes, suficiente para la mayoría de las necesidades de sitios web personales.
- **Cumplimiento de Privacidad**: Umami se enfoca en la privacidad, pero asegúrate de que tu sitio web cumpla con GDPR u otras regulaciones de privacidad (como operar en regiones como la UE).
- **Seguridad**: Haz copias de seguridad regulares de tu base de datos Neon y asegúrate de que la cuenta de administrador de Umami use una contraseña fuerte.

## Conclusión

Con Vercel y su base de datos Neon integrada, puedes configurar un poderoso sistema de estadísticas de tráfico web sin costo en solo minutos. La interfaz limpia y las características centrales de Umami son perfectas para los usuarios de blogs Hugo, satisfaciendo las necesidades de seguimiento de visitas, análisis de fuentes y monitoreo del rendimiento de páginas.

Si tienes alguna pregunta o necesitas más optimización, no dudes en discutir en los comentarios. Espero que este tutorial te ayude a comprender mejor el tráfico de tu sitio web.

## Referencias

- Documentación Oficial de Umami: [https://umami.is/docs](https://umami.is/docs)
- Documentación de Vercel Storage: [https://vercel.com/docs/storage](https://vercel.com/docs/storage)
- Guía de Configuración de Base de Datos Neon: [https://neon.tech/docs](https://neon.tech/docs)
- Documentación de Hugo: [https://gohugo.io/documentation/](https://gohugo.io/documentation/)
