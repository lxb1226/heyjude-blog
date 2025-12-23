---
title: "Integrar Sistema de Comentários Giscus no Blog Hugo"
date: 2025-06-15
slug: "giscus-comments-hugo"
tags: ["Hugo", "Sistema de Comentários", "Giscus", "Configuração de Blog", "GitHub Discussions", "Blog Estático", "Interação de Blog", "Comentários Open Source", "Configuração Sem Custo"]
keywords: ["sistema de comentários Giscus", "comentários blog Hugo", "comentários GitHub Discussions", "solução comentários blog estático", "ferramenta comentários open source", "sistema interação blog", "sistema comentários grátis", "personalização tema Hugo", "extensão recursos blog"]
description: "Este guia completo demonstra como integrar o sistema de comentários Giscus no seu blog Hugo, uma solução moderna de comentários powered por GitHub Discussions. Aprenda a configurar um sistema de comentários seguro com suporte Markdown e sem custo, com modo escuro e suporte multilíngue, perfeito para blogs estáticos Hugo. Não requer banco de dados: todos os dados de comentários são armazenados com segurança no GitHub, garantindo segurança e sustentabilidade dos dados."
---

Este é o terceiro tutorial sobre a construção do seu próprio sistema de blog, focado em adicionar um sistema de comentários.

Durante o processo de configuração do blog, um bom sistema de comentários pode melhorar enormemente a interatividade. Hoje, apresentarei como integrar [Giscus](https://giscus.app/), um sistema de comentários open source baseado em GitHub Discussions, em um blog Hugo.

## Por Que Escolher Giscus?

- 🚀 Não requer servidor, baseado em GitHub Discussions
- 🔒 Seguro e confiável, dados de comentários armazenados no GitHub
- 🧩 Suporta modo escuro e temas adaptativos
- 💬 Suporta comentários anônimos (opcional)
- 🌍 Suporte de interface multilíngue

## Preparação

Antes de começar, você precisa:

1. Um repositório hospedado no GitHub
2. Recurso Discussions habilitado
3. Um blog Hugo (qualquer tema serve)

## Passo 1: Habilitar GitHub Discussions

1. Abra o repositório de código do seu blog (por exemplo, `usuario/blog`).
2. Clique em **Settings** → **Features** → Marque **Discussions**.
![](https://img.music-poster.art/2025/06/8c0271325d91ad29527d1acef14fd869.png)
## Passo 2: Configurar Giscus

Vá para [https://giscus.app](https://giscus.app), e na página:

1. Selecione seu repositório GitHub.
2. Configure em qual categoria de Discussion criar os comentários (você pode criar uma nova como `announcement`).
3. Configuração personalizada:
   - Mapping: É recomendado escolher `pathname`, que associa discussions pelo caminho da página.
   - Reaction: Se permitir curtidas e outras ações.
   - Theme: Suporta `light`, `dark`, `preferred_color_scheme`, etc.
4. Copie o código `<script>` gerado.
![](https://img.music-poster.art/2025/06/116ebde5a465cfbea4f3c5b84192be3d.png)
Por exemplo, o código gerado parece assim:

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

Aqui você precisa lembrar os três parâmetros: `data-repo`, `data-repo-id` e `data-category-id`, que serão usados na configuração a seguir.

## Passo 3: Integrar Giscus no Seu Tema Hugo
O tema que estou usando é [hugo-narrow](https://github.com/tom2almighty/hugo-narrow), que integra o sistema de comentários Giscus, e você só precisa fazer um pouco de configuração. Aqui está minha configuração:

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
Note que você precisa substituir `repo`, `repoId` e `categoryId` pelos valores salvos no Passo 2. Isso é necessário para que os comentários sejam exibidos corretamente.
Além disso, certifique-se de que `enabled` esteja configurado como `true` e `system` esteja configurado como `giscus`. Caso contrário, os comentários não serão exibidos.

Finalmente, você verá uma interface como esta na parte inferior do artigo:
![](https://img.music-poster.art/2025/06/2e3b16e884ac6d67db1651a8d44197db.png)

## Testes

Você pode comentar neste artigo e ver se os comentários são exibidos corretamente. Os comentários podem ser verificados no GitHub Discussions.

Por exemplo, você pode ver os comentários no meu blog [aqui](https://github.com/lxb1226/lxb1226.github.io/discussions).

![](https://img.music-poster.art/2025/06/fdc145c668e761fb68870ce841967e08.png)
