---
title: "Como Preencher Automaticamente Códigos de Verificação SMS no Mac"
date: 2025-05-07T22:36:09+08:00
lastmod: 2025-05-07T22:36:09+08:00
draft: false
keywords: ["mac código de verificação", "auto-fill", "MessAuto", "AutoCode", "sincronização iPhone", "verificação SMS", "ferramenta de produtividade", "automation"]
description: "Um guia completo sobre como configurar e usar o MessAuto para sincronizar e preencher automaticamente códigos de verificação SMS do iPhone para o Mac, melhorando a eficiência do fluxo de trabalho diário."
tags: ["Mac", "Produtividade", "MessAuto", "Automation", "iPhone", "Código de Verificação"]
categories: ["Ferramentas de Produtividade", "Tutoriais", "Apps de Mac"]
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

Sabemos que o iOS suporta o preenchimento automático de códigos de verificação SMS, e o Safari no Mac também suporta. No entanto, navegadores que não são Safari não suportam este recurso. Porém, em plataformas nacionais, códigos de verificação são algo de que não podemos escapar, por isso fiz algumas pesquisas e encontrei algumas soluções atuais.

* [AutoCode](https://apps.apple.com/cn/app/id6472872202): Este é um aplicativo gratuito disponível na App Store, suportando encaminhamento no iOS e Android.
* [MessAuto](https://github.com/LeeeSe/MessAuto): MessAuto é um aplicativo para macOS que extrai automaticamente códigos de verificação de SMS e e-mail, desenvolvido em Rust e adequado para qualquer aplicativo.

Como o MessAuto é open-source, escolhi este software.

# Uso do MessAuto

Como o MessAuto é um software open-source e o autor não o distribuiu ou assinou, ele precisa ser compilado por você mesmo.

## 1. Compilação

```bash
# Baixar o código fonte
git clone https://github.com/LeeeSe/MessAuto.git
cd MessAuto

# Instalar cargo-bundle
cargo install cargo-bundle --git https://github.com/zed-industries/cargo-bundle.git --branch add-plist-extension
# Empacotar o aplicativo
cargo bundle --release
```

Após a compilação, o pacote será construído em `target/release/bundle/osx/MessAuto.app` no diretório atual.

![](https://img.music-poster.art/2025/05/c090074301dfda862dea2b0797bcdeec.png)

## 2. Uso

Ao abrir a versão ARM64, ele informará que o arquivo está danificado porque requer uma assinatura de desenvolvedor da Apple para iniciar normalmente. O autor não tem um certificado de desenvolvedor Apple, mas você ainda pode resolver o problema com um único comando:

* Mova MessAuto.app para a pasta /Applications
* Execute `xattr -cr /Applications/MessAuto.app` no terminal

Desta forma, você pode usar o aplicativo.

## 3. Configuração

Para que o programa funcione corretamente, os usuários precisam ativar o recurso "SMS Forwarding" no iOS. Isso pode ser encontrado em Settings > Messages > iMessage.

![](https://img.music-poster.art/2025/05/20e37bdec4c71f08fe4605b2534b2113.jpeg)

O MessAuto é um software de barra de menu sem GUI. Quando iniciado pela primeira vez, o MessAuto pedirá ao usuário que conceda permissões de acesso total ao disco; após conceder a permissão, o sistema exigirá que o software seja reaberto. O software pode ser visto na barra de menu. Suas funções são as seguintes:

* **Auto Paste**: O MessAuto armazenará os códigos de verificação detectados na sua área de transferência. Se você não quiser colar manualmente ao inserir o código de verificação, pode habilitar esta opção. Quando habilitada, o MessAuto lembrará proativamente você de autorizar os recursos de acessibilidade.
* **Auto Enter**: Pressiona automaticamente a tecla enter após o auto-colar do código de verificação.
* **Do Not Occupy Clipboard**: O MessAuto não afetará o conteúdo da sua área de transferência atual. Não significa "não ocupar" mas restaurará automaticamente o conteúdo anterior da sua área de transferência (seja imagem ou texto) após colar o código de verificação, então este recurso habilitará automaticamente o auto paste.
* **Temporarily Hide**: Oculta temporariamente o ícone, que reaparecerá quando o aplicativo for reiniciado (requer sair do fundo); adequado para usuários que não reiniciam seu Mac com frequência.
* **Permanently Hide**: Oculta permanentemente o ícone; não será exibido mesmo após o aplicativo ser reiniciado; adequado para usuários que reiniciam seu Mac com frequência. Se você quiser mostrar o ícone novamente, precisa editar o arquivo `~/.config/messauto/messauto.json`, definir `hide_forever` como false e reiniciar o aplicativo.
* **Configuration**: Ao clicar nisso, abrirá um arquivo de configuração formatado em JSON, onde você pode personalizar palavras-chave.
* **Log**: Abrir rapidamente o log.
* **Listen for Emails**: Quando habilitado, também ouvirá e-mails, exigindo que o aplicativo de mail esteja rodando em segundo plano.
* **Popup Window**: Uma janela pop-up conveniente aparecerá após obter o código de verificação.

Aqui é recomendado ligar **Auto Paste** e **Launch at Login**. Como o autor atualmente não precisa ouvir e-mails, este recurso está desabilitado, mas pode ser habilitado se necessário.

# Referências

1. https://github.com/LeeeSe/MessAuto
