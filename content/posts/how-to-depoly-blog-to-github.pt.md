---
title: "Como Implantar seu Blog no GitHub Pages em 10 Minutos"
subtitle: "Hospedagem Gratuita para seu Blog Hugo no GitHub Pages"
date: 2025-05-18T17:01:07+08:00
lastmod: 2025-05-18T17:01:07+08:00
draft: false
authors: ["heyjude"]
description: "Guia passo a passo para implantar seu blog Hugo no GitHub Pages, incluindo configuração do repositório, configuração do GitHub Actions e fluxo de trabalho de implantação automatizada, ajudando você a criar um site de blog profissional com custo zero."

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

Depois de construirmos nosso site de blog localmente, o próximo passo é distribuir o conteúdo do blog online para que outros possam vê-lo.

Pesquisei os sites de hospedagem atuais e encontrei as seguintes opções:

- **GitHub Pages**: Um serviço gratuito de hospedagem de sites estáticos fornecido pelo GitHub, adequado para integração com repositórios de código.
- **Netlify**: Suporta construção e implantação automáticas, recursos ricos no plano gratuito, com muito bom suporte para Hugo.
- **Vercel**: Desenvolvido pela equipe Next.js, implantação rápida, adequado para projetos frontend.
- **Cloudflare Pages**: Serviço de hospedagem de sites estáticos fornecido pela Cloudflare, vem com aceleração CDN e de segurança.
- **Firebase Hosting**: Uma plataforma de hospedagem frontend lançada pelo Google, adequada para uso com aplicativos frontend.
- **Amazon S3 + CloudFront**: Uma solução de alta performance de hospedagem e distribuição, adequada para implantações profissionais.
- **GitLab Pages**: Serviço de hospedagem de sites estáticos fornecido pelo GitLab, constrói automaticamente através da configuração CI.
- **Render**: Uma plataforma de hospedagem full-stack simplificada, suporta implantação automática de sites Hugo.
- **Surge.sh**: Uma ferramenta minimalista de hospedagem de sites estáticos, implantação de linha de comando simples e rápida.
- **DigitalOcean App Platform**: Plataforma de serviço em nuvem que suporta implantação automática de sites estáticos e serviços backend.

Essas plataformas têm suas próprias características, e apresentarei como implantar em cada uma em próximos artigos. Neste artigo, apresentarei como implantar um site de blog no GitHub Pages.

## O que é GitHub Pages?

GitHub Pages é um serviço gratuito de hospedagem de sites estáticos fornecido pelo GitHub, adequado para hospedar blogs, páginas iniciais de projetos, documentação, etc. Você só precisa de um repositório GitHub para publicar seu site em https://seunome.github.io ou um domínio personalizado.

## Como Implantar um Site de Blog no GitHub Pages

### Plano Geral
* Seu repositório principal (por exemplo, my-hugo-site) contém o código fonte Hugo (content/, layouts/, etc.).
* Os arquivos estáticos construídos (public/) serão enviados para outro repositório (seunomededeusuario.github.io).
* O repositório seunomededeusuario.github.io é especificamente para hospedar o site estático gerado.

### Estrutura do Projeto

Assumindo que você tem dois repositórios GitHub:
* my-hugo-site (repositório de origem): armazena o código fonte Hugo e os artigos.
* seunomededeusuario.github.io (repositório de implantação): armazena os arquivos estáticos construídos.

A estrutura do projeto é a seguinte:
```
my-hugo-site/
├── content/            # Conteúdo do blog
├── layouts/            # Layouts personalizados para Hugo
├── themes/             # Temas Hugo
├── config.toml        # Arquivo de configuração Hugo
└── .github/workflows/deploy.yml  # Configuração de implantação automática

seunomededeusuario.github.io/
├── (arquivos do site estático publicado)   # Arquivos estáticos gerados pelo Hugo
```

### Passo 1: Criar Dois Repositórios

1. Crie dois repositórios no GitHub:
  * my-hugo-site: para armazenar o código fonte Hugo.
  * seunomededeusuario.github.io: para armazenar os arquivos estáticos construídos.

2. No repositório seunomededeusuario.github.io, defina o branch de origem para GitHub Pages como main (ou master).

### Passo 2: Configurar GitHub Actions para Implantação Automatizada

No repositório my-hugo-site, crie o arquivo .github/workflows/deploy.yml para configurar construções automatizadas e enviar arquivos estáticos para o repositório seunomededeusuario.github.io.

```yaml
name: GitHub Pages

on:
  push:
    branches:
      - main  # O branch padrão para o diretório raiz do blog; aqui é main, às vezes é master
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
          hugo-version: '0.147.0'  # Especifique sua versão Hugo, pode verificar usando hugo version
          extended: true          # Se você estiver usando uma versão não estendida do Hugo, altere true para false

      - name: Build
        run: git submodule update --init --recursive && hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: ${{ github.ref == 'refs/heads/main' }}  # Certifique-se de usar main ou master
        with:
          personal_token: ${{ secrets.MY_PAT}} # Se o segredo tiver outro nome, substitua MY_PAT por esse nome
          external_repository: lxb1226/lxb1226.github.io # Preencha o repositório remoto, não necessariamente neste formato, escreva de acordo com sua situação
          publish_dir: ./public
          #cname: www.example.com        # Preencha seu domínio personalizado. Se nenhum domínio personalizado for usado, comente esta linha
```

Você pode consultar meu [deploy.yaml](https://github.com/lxb1226/heyjude-blog/blob/main/.github/workflows/deploy.yaml)

### Obtendo GitHub Secrets

No arquivo yaml acima, você precisa obter o `personal_token`. Você pode obtê-lo do repositório my-hugo-site.

Você pode recuperá-lo no repositório -> Settings -> Secrets and variables -> Actions.
![personal_token](https://img.music-poster.art/2025/05/5331092ac30840b1bc967395cce01709.png)

### Passo 3: Configurar GitHub Pages

1. No repositório seunomededeusuario.github.io, vá para Settings → Pages.
2. Defina o Source como o branch main e certifique-se de que GitHub Pages está configurado corretamente.
3. Depois de salvar, o site estático será hospedado em https://seunomededeusuario.github.io/.
![](https://img.music-poster.art/2025/05/9052201a8331d0e293e23b1741d0fc80.png)

## Processo de Publicação Automática do Blog

1. Escreva artigos e modifique o site no repositório my-hugo-site.
2. Cada vez que você envia atualizações para o branch main, GitHub Actions construirá automaticamente e enviará os arquivos estáticos para o repositório seunomededeusuario.github.io.
3. GitHub Pages atualizará automaticamente e mostrará em https://seunomededeusuario.github.io/. (Geralmente, isso leva algum tempo)

## Referências

1. https://docs.github.com/en/actions
2. https://gohugo.io/documentation/
3. https://lxb1226.github.io/
4. https://github.com/lxb1226/heyjude-blog
