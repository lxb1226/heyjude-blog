---
title: "Cómo Rellenar Automáticamente Códigos de Verificación SMS en Mac"
date: 2025-05-07T22:36:09+08:00
lastmod: 2025-05-07T22:36:09+08:00
draft: false
keywords: ["mac código de verificación", "auto-fill", "MessAuto", "AutoCode", "sincronización iPhone", "verificación SMS", "herramienta de productividad", "automation"]
description: "Una guía completa sobre cómo configurar y usar MessAuto para sincronizar y rellenar automáticamente códigos de verificación SMS desde iPhone hacia Mac, mejorando la eficiencia del flujo de trabajo diario."
tags: ["Mac", "Productividad", "MessAuto", "Automation", "iPhone", "Código de Verificación"]
categories: ["Herramientas de Productividad", "Tutoriales", "Apps de Mac"]
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

# Motivo

Sabemos que iOS soporta el auto-fill de códigos de verificación SMS, y Safari en Mac también lo soporta. Sin embargo, los navegadores que no son Safari no soportan esta función. Sin embargo, en plataformas nacionales, los códigos de verificación son algo de lo que no podemos escapar, por lo que realicé algunas investigaciones y encontré algunas soluciones actuales.

* [AutoCode](https://apps.apple.com/cn/app/id6472872202): Esta es una aplicación gratuita disponible en la App Store, que soporta el reenvío en iOS y Android.
* [MessAuto](https://github.com/LeeeSe/MessAuto): MessAuto es una aplicación para macOS que extrae automáticamente códigos de verificación de SMS y correo electrónico, desarrollada en Rust y adecuada para cualquier aplicación.

Dado que MessAuto es de código abierto, elegí este software.

# Uso de MessAuto

Dado que MessAuto es software de código abierto y el autor no lo ha distribuido o firmado, debe ser compilado por ti mismo.

## 1. Compilación

```bash
# Descargar el código fuente
git clone https://github.com/LeeeSe/MessAuto.git
cd MessAuto

# Instalar cargo-bundle
cargo install cargo-bundle --git https://github.com/zed-industries/cargo-bundle.git --branch add-plist-extension
# Empaquetar la aplicación
cargo bundle --release
```

Después de la compilación, el paquete se construirá en `target/release/bundle/osx/MessAuto.app` en el directorio actual.

![](https://img.music-poster.art/2025/05/c090074301dfda862dea2b0797bcdeec.png)

## 2. Uso

Al abrir la versión ARM64, indicará que el archivo está dañado ya que requiere una firma de desarrollador de Apple para iniciarse normalmente. El autor no tiene un certificado de desarrollador de Apple, pero aún puedes resolver el problema con un solo comando:

* Mueve MessAuto.app a la carpeta /Applications
* Ejecuta `xattr -cr /Applications/MessAuto.app` en la terminal

De esta manera, puedes usar la aplicación.

## 3. Configuración

Para que el programa funcione correctamente, los usuarios necesitan habilitar la función "SMS Forwarding" en iOS. Esto se puede encontrar en Settings > Messages > iMessage.

![](https://img.music-poster.art/2025/05/20e37bdec4c71f08fe4605b2534b2113.jpeg)

MessAuto es un software de barra de menú sin GUI. Cuando se inicia por primera vez, MessAuto pedirá al usuario que otorgue permisos de acceso completo al disco; después de otorgar el permiso, el sistema requerirá que el software se reinicie. El software se puede ver en la barra de menús. Sus funciones son las siguientes:

* **Auto Paste**: MessAuto almacenará los códigos de verificación detectados en tu portapapeles. Si no quieres pegar manualmente al ingresar el código de verificación, puedes habilitar esta opción. Cuando está habilitada, MessAuto te recordará proactivamente que autorices las funciones de accesibilidad.
* **Auto Enter**: Presiona automáticamente la tecla enter después de auto-pegar el código de verificación.
* **Do Not Occupy Clipboard**: MessAuto no afectará el contenido de tu portapapeles actual. No significa "no ocupar" sino que restaurará automáticamente tu contenido anterior del portapapeles (ya sea imagen o texto) después de pegar el código de verificación, por lo que esta función habilitará automáticamente auto paste.
* **Temporarily Hide**: Oculta temporalmente el icono, que volverá a aparecer cuando se reinicie la aplicación (requiere salir del fondo); adecuado para usuarios que no reinician su Mac con frecuencia.
* **Permanently Hide**: Oculta permanentemente el icono; no se mostrará incluso después de que se reinicie la aplicación; adecuado para usuarios que reinician su Mac con frecuencia. Si quieres volver a mostrar el icono, necesitas editar el archivo `~/.config/messauto/messauto.json`, establecer `hide_forever` en false y reiniciar la aplicación.
* **Configuration**: Al hacer clic en esto se abrirá un archivo de configuración en formato JSON, donde puedes personalizar palabras clave.
* **Log**: Abrir rápidamente el log.
* **Listen for Emails**: Cuando está habilitado, también escuchará correos electrónicos, requiriendo que la aplicación de mail se esté ejecutando en segundo plano.
* **Popup Window**: Una ventana emergente conveniente aparecerá después de obtener el código de verificación.

Se recomienda activar **Auto Paste** y **Launch at Login**. Dado que el autor actualmente no necesita escuchar correos electrónicos, esta función está deshabilitada, pero puede habilitarse si es necesario.

# Referencias

1. https://github.com/LeeeSe/MessAuto
