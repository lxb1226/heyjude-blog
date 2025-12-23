---
title: Criar um Blog com Hugo e Implantar no Cloudflare Pages
date: 2025-06-16T20:29:00+08:00
tags: [Hugo, Cloudflare, criar blog, Blog, Static Site, Deployment]
categories: [Technical Tutorial]
description: Este artigo detalha como criar um blog usando o gerador de sites estáticos Hugo e implantá-lo através do Cloudflare Pages, incluindo passos completos para configuração do ambiente, instalação de temas, criação de conteúdo e vinculação de domínios.
slug: deploy-hugo-to-cloudflare
keywords: ["criar blog", "tutorial Hugo", "site estático", "blog grátis", "Cloudflare Pages", "deployment", "web hosting"]
---

# Criar um Blog com Hugo e Implantar no Cloudflare Pages

Neste artigo, vou guiá-lo passo a passo através do processo completo de construção de um blog pessoal usando [Hugo](https://gohugo.io/) e implantá-lo no [Cloudflare Pages](https://pages.cloudflare.com/). O Hugo é um gerador de sites estáticos rápido e flexível, enquanto o Cloudflare Pages oferece serviços de hospedagem gratuita com aceleração CDN global, permitindo que seu blog entre no ar rapidamente e proporcion uma boa experiência de usuário. Seja você um iniciante técnico ou um desenvolvedor experiente, este tutorial ajudará você a configurar rapidamente seu próprio blog.

## Por Que Escolher Hugo e Cloudflare Pages?

- **Hugo**: Escrito em Go, é extremamente rápido, suporta uma rica variedade de temas e formato Markdown, sendo adequado para blogs e sites de documentação.
- **Cloudflare Pages**: Fornece integração perfeita com GitHub, implantação automática, certificados SSL gratuitos e aceleração CDN global, oferecendo melhores velocidades de acesso que o GitHub Pages.
- **Custo**: A combinação de ambos é completamente gratuita, ideal para blogs pessoais ou pequenos projetos.

## Preparação

Antes de começar, você precisa preparar as seguintes ferramentas e contas:

1. **Hugo**: Instale a versão mais recente do Hugo (recomenda-se usar a versão extended para mais recursos).
2. **Git**: Para controle de versão e envio de código para o GitHub.
3. **Conta do GitHub**: Para armazenar o código fonte do blog.
4. **Conta do Cloudflare**: Para implantar e hospedar o blog.
5. **Editor de Texto**: Como VSCode, para editar arquivos Markdown e arquivos de configuração.

## Passo 1: Instalar o Hugo

### Windows
1. Instale o gerenciador de pacotes Chocolatey (se ainda não estiver instalado):
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
2. Use o Chocolatey para instalar a versão extended do Hugo:
   ```powershell
   choco install hugo-extended
   ```
3. Verifique a instalação:
   ```powershell
   hugo version
   ```

### macOS
1. Instale usando Homebrew:
   ```bash
   brew install hugo
   ```
2. Verifique a instalação:
   ```bash
   hugo version
   ```

Para mais métodos de instalação, consulte a [documentação oficial do Hugo](https://gohugo.io/getting-started/installing/).

## Passo 2: Criar um Site Hugo

1. Crie um novo site no terminal:
   ```bash
   hugo new site my-blog
   cd my-blog
   ```
   Isso gerará a estrutura de diretórios do site Hugo na pasta `my-blog`:
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

2. Inicialize um repositório Git:
   ```bash
   git init
   ```

3. Adicione um arquivo `.gitignore` para ignorar arquivos gerados:
   ```bash
   echo "public/" >> .gitignore
   echo "resources/" >> .gitignore
   ```

## Passo 3: Instalar e Configurar o Tema

1. Escolha um tema do Hugo, por exemplo, [hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack):
   ```bash
   git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
   ```

2. Copie o arquivo de configuração de exemplo do tema para a raiz do projeto:
   ```bash
   cp themes/hugo-theme-stack/exampleSite/config.yaml .
   ```

3. Edite `config.yaml` (ou `hugo.toml`) para definir informações básicas:
   ```yaml
   baseURL: "https://your-domain.com/"  # Substitua pelo seu domínio
   languageCode: "pt-br"
   title: "Meu Blog"
   theme: "hugo-theme-stack"
   DefaultContentLanguage: "pt-br"
   paginate: 5
   ```

Para mais configurações do tema, consulte a documentação oficial do tema.

## Passo 4: Criar Seu Primeiro Post do Blog

1. Crie um novo post:
   ```bash
   hugo new posts/meu-primeiro-post.md
   ```
   Isso gerará o arquivo `meu-primeiro-post.md` no diretório `content/posts/`.

2. Edite o conteúdo do post e modifique o Front Matter (metadados do post):
   ```markdown
   ---
   title: "Meu Primeiro Post no Blog"
   date: 2025-06-16T20:29:00+08:00
   draft: false
   ---
   Bem-vindo ao blog Hugo! Este é o meu primeiro post.
   ```

3. Inicie o servidor local do Hugo para visualizar:
   ```bash
   hugo server -D
   ```
   Abra o navegador e vá para `http://localhost:1313/` para ver a visualização local do blog.

## Passo 5: Enviar Código para o GitHub

1. Crie um novo repositório no GitHub (como `my-blog`), seja público ou privado.
2. Envie o código local para o GitHub:
   ```bash
   git add .
   git commit -m "Commit inicial"
   git remote add origin https://github.com/your-username/my-blog.git
   git branch -M main
   git push -u origin main
   ```

## Passo 6: Implantar no Cloudflare Pages

1. Faça login no [Painel do Cloudflare](https://dash.cloudflare.com/), vá em "Workers and Pages" > "Pages" > "Create a Project".
![](https://img.music-poster.art/2025/06/460d03da3f5f0c737c60951d16dd12b4.png)
2. Conecte sua conta do GitHub e selecione o repositório `my-blog` recém-criado.
![](https://img.music-poster.art/2025/06/5577398c00ea3e040f927f4272d7d5c9.png)
3. Configure as configurações de build:
   - **Project Name**: Qualquer nome (como `my-blog`), atribuirá um subdomínio como `my-blog.pages.dev`.
   - **Production Branch**: O padrão é `main`.
   - **Build Command**: `hugo --gc --minify` (otimiza os arquivos de saída).
   - **Output Directory**: `public`.
   - **Environment Variables**: Adicione `HUGO_VERSION` (como `0.125.4`) para especificar a versão do Hugo, recomenda-se usar a versão mais recente; consulte as [versões do Hugo](https://github.com/gohugoio/hugo/releases).
   ![](https://img.music-poster.art/2025/06/4ce72f3294fdc3f92e2a504e70a11b5a.png)
4. Clique em "Save and Deploy", o Cloudflare Pages automaticamente puxará o código, construirá e implantará. Uma vez que a implantação esteja completa, você pode acessar seu blog através de `my-blog.pages.dev`.
![](https://img.music-poster.art/2025/06/50fc6325948a3ddc3aa9a424b56a6f65.png)

## Passo 7: Vincular um Domínio Personalizado

1. Certifique-se de que seu domínio esteja hospedado no Cloudflare (você pode comprá-lo através do Cloudflare ou migrar de outros registradores).
2. No projeto do Cloudflare Pages, clique em "Custom Domain" > "Set Custom Domain".
3. Digite seu domínio (como `your-domain.com`), o Cloudflare automaticamente adicionará um registro CNAME.
4. Aguarde a resolução DNS entrar em vigor (geralmente de alguns minutos a algumas horas), depois acesse seu blog usando o domínio personalizado.

## Passo 8: Implantação Automatizada

Cada vez que você atualizar o conteúdo do seu blog (como adicionar novos posts ou modificar configurações), basta executar os seguintes comandos para enviar o código:
```bash
git add .
git commit -m "Atualizar conteúdo do blog"
git push origin main
```
O Cloudflare Pages detectará automaticamente as atualizações no repositório do GitHub, reconstruirá e reimplantará, tipicamente completando em 1-2 minutos.

## Problemas e Soluções

1. **Incompatibilidade na Versão do Hugo**: O Cloudflare Pages pode ter por padrão uma versão antiga do Hugo, causando falhas no build. A solução é especificar a versão mais recente nas variáveis de ambiente (como `HUGO_VERSION=0.125.4`).
2. **Posts Não São Exibidos**: Verifique se `draft: false` está configurado corretamente, pois o Hugo não renderiza posts com `draft: true` por padrão.
3. **Velocidade de Acesso Lenta da China**: Certifique-se de que o domínio esteja acelerado pelo CDN do Cloudflare e SSL esteja habilitado.

## Resumo

Com o Hugo e o Cloudflare Pages, você pode construir rapidamente um blog pessoal de alto desempenho e gratuito. O Hugo fornece gerenciamento de conteúdo flexível e suporte rico de temas, enquanto a implantação automática e a aceleração CDN global do Cloudflare Pages garantem que a publicação e o acesso do blog sejam mais eficientes.

## Referências
- [Documentação Oficial do Hugo](https://gohugo.io/documentation/)
- [Documentação Oficial do Cloudflare Pages](https://developers.cloudflare.com/pages/)
