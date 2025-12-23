---
title: "Como Sincronizar seu Blog Hugo ao Perfil do GitHub com GitHub Actions Automaticamente"
date: 2025-06-21T22:00:00+08:00
draft: false
tags: ["Hugo", "GitHub", "Blog Sync", "GitHub Actions", "Automation"]
categories: ["Technology", "Blog Setup"]
description: "Um tutorial detalhado sobre o uso de GitHub Actions com gautamkrishnar/blog-post-workflow para sincronizar automaticamente seu blog Hugo ao perfil do GitHub, incluindo passos de configuração e precauções."
---

## Como Sincronizar seu Blog Hugo ao Perfil do GitHub

Depois de implantarmos nosso blog, queremos que nosso perfil do GitHub seja atualizado automaticamente sempre que houver uma nova publicação no blog, para que nosso perfil possa exibir nossos últimos artigos. Podemos achieving isso com `GitHub Actions`.

## Pré-requisitos

Antes de começar, certifique-se de ter completado os seguintes preparativos:

- **Blog Hugo**: Um blog Hugo configurado e hospedado em um repositório do GitHub (como `username/username.github.io` ou um repositório personalizado).
- **Repositório do GitHub**: Um repositório para armazenar os arquivos fonte do seu blog (por exemplo, `username/blog`) e um repositório para GitHub Pages (por exemplo, `username/username.github.io`).
- **README do Perfil do GitHub**: O Profile README está habilitado no GitHub (crie um repositório com o mesmo nome que seu nome de usuário, como `username/username`, por exemplo, [Meu Perfil do GitHub](https://github.com/lxb1226/lxb1226)).
- **Conhecimentos Básicos de Git**: Entender como fazer commit de código, configurar `.gitignore` e usar GitHub Actions.

## O que é blog-post-workflow?

`blog-post-workflow` é uma GitHub Action desenvolvida por Gautam Krishnar, projetada para sincronizar as últimas publicações do blog ao GitHub Profile README ou outras localizações especificadas. Suporta múltiplos frameworks de blog (incluindo Hugo) e recupera as últimas publicações analisando o feed RSS, atualizando automaticamente o arquivo de destino.

## Passo 1: Configurar o Repositório do Blog Hugo

1. **Garantir que o Blog Hugo Gere um Feed RSS**:
   O Hugo gera um feed RSS por padrão (geralmente localizado em `public/index.xml`). No seu arquivo de configuração do Hugo (`config.toml` ou `config.yaml`), certifique-se de que a saída RSS esteja habilitada:
   ```toml
   [outputs]
   home = ["HTML", "RSS"]
   ```
   Depois de executar o comando `hugo`, verifique o arquivo `index.xml` no diretório `public`.

   Dicas: Se o seu blog for multilíngue, o endereço do feed RSS deve ser `https://seu-dominio-blog/index.xml`, não `https://seu-dominio-blog/en/index.xml` ou `https://seu-dominio-blog/zh/index.xml`, etc.

2. **Hospedar Conteúdo do Blog**:
   - Certifique-se de que os arquivos fonte do seu blog Hugo estejam armazenados em um repositório (por exemplo, `username/blog`).
   - Os arquivos estáticos (o diretório `public`) devem ser enviados para o repositório do GitHub Pages (por exemplo, `username/username.github.io`).
   - Nas configurações do repositório do GitHub Pages, habilite o GitHub Pages e selecione a branch correta (geralmente `main` ou `gh-pages`).

3. **Verificar Acesso ao Blog**:
   Certifique-se de que seu blog seja acessível através de um domínio personalizado (por exemplo, `https://username.github.io`) ou do domínio padrão do GitHub Pages.

## Passo 2: Configurar o README do Perfil do GitHub

1. **Criar Repositório README do Perfil**:
   - Crie um repositório no GitHub que tenha o mesmo nome que seu nome de usuário (por exemplo, `username/username`).
   - Crie um arquivo `README.md` no diretório raiz do repositório para exibir o conteúdo do seu Perfil do GitHub.

2. **Adicionar Marcador de Posição do Blog**:
   Adicione um marcador de posição em `README.md` para inserir dinamicamente artigos do blog. Por exemplo:
   ```markdown
   ## Meus Últimos Artigos do Blog
   <!-- BLOG-POST-LIST:START -->
   <!-- BLOG-POST-LIST:END -->
   ```

   O `blog-post-workflow` substituirá este marcador de posição por links para os últimos artigos do blog.

## Passo 3: Configurar blog-post-workflow

1. **Criar Fluxo de Trabalho do GitHub Actions**:
   No seu repositório README do Perfil (`username/username`), crie a seguinte estrutura de diretórios:
   ```
   .github/workflows/blog-post.yml
   ```

2. **Escrever Arquivo de Fluxo de Trabalho**:
   Adicione o seguinte conteúdo a `blog-post.yml` para configurar `blog-post-workflow`:
   ```yaml
   name: Sync Blog to Profile README

   on:
     schedule:
       - cron: "0 0 * * *" # Executar uma vez ao dia
     workflow_dispatch: # Permitir disparo manual

   jobs:
     update-readme-with-blog:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: gautamkrishnar/blog-post-workflow@v1
           with:
             feed_list: "https://username.github.io/index.xml" # Substitua pelo endereço RSS do seu blog
             max_post_count: 5 # Sincronizar os últimos 5 artigos
             readme_path: ./README.md # Arquivo README de destino
             commit_message: "Update README with latest blog posts"
   ```
   - **feed_list**: Substitua pelo endereço do feed RSS do seu blog Hugo (geralmente `https://seu-dominio-blog/index.xml`).
   - **max_post_count**: Defina o número de artigos recentes a exibir.
   - **readme_path**: Certifique-se de que aponta para o caminho correto do arquivo README.
   - **commit_message**: Personalize a mensagem de commit.

3. **Confirmar Arquivo de Fluxo de Trabalho**:
   Faça commit de `blog-post.yml` no seu repositório README do Perfil. O GitHub Actions será executado automaticamente à meia-noite (UTC) diariamente ou pode ser acionado manualmente através do painel do GitHub Actions.

## Passo 4: Verificar Resultados da Sincronização

1. **Verificar Registros do GitHub Actions**:
   - Vá para a aba Actions do repositório README do Perfil para ver o status do fluxo de trabalho `Sync Blog to Profile README`.
   - Certifique-se de que não há erros e de que o fluxo de trabalho foi concluído com sucesso.
   ![](https://img.music-poster.art/2025/06/133d3d31fe568cbba71be00326fe6420.png)
   - Você também pode acionar manualmente o fluxo de trabalho para verificar se o README foi atualizado. Clique em `Run workflow` para acioná-lo manualmente.
   ![](https://img.music-poster.art/2025/06/bd7d8b28b5a2538881cfd90a878dcd8e.png)

2. **Ver Atualização do README**:
   - Abra o `README.md` do repositório `username/username` para verificar se o marcador de posição `<!-- blog-post-workflow -->` foi substituído pela lista das últimas publicações do blog.
   - A saída de exemplo pode parecer:
     ```markdown
     ## Meus Últimos Artigos do Blog
     - [Título do Artigo 1](https://username.github.io/post/xxx) - 2025-06-21
     - [Título do Artigo 2](https://username.github.io/post/yyy) - 2025-06-20
     ```

3. **Acessar o Perfil do GitHub**:
   Abra sua página de perfil do GitHub (por exemplo, `https://github.com/username`) e confirme que os últimos artigos do blog são exibidos no Profile README.
   ![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

## Notas

- **Disponibilidade do Feed RSS**: Certifique-se de que o feed RSS do seu blog (`index.xml`) seja acessível através de uma URL pública. Se o blog estiver hospedado em um repositório privado, considere mudar para um repositório público ou fornecer RSS através de outro meio.
- **Permissões do GitHub Actions**: Certifique-se de que seu repositório tenha permissões de gravação do Actions habilitadas (Settings > Actions > General > Allow all actions and reusable workflows).
- **Frequência de Sincronização**: A configuração padrão é sincronizar uma vez ao dia, mas você pode ajustar a expressão `cron` conforme necessário (por exemplo, a cada hora: `0 * * * *`).
- **Depuração**: Se a sincronização falhar, verifique os registros do Actions. Problemas comuns incluem um endereço RSS incorreto ou um caminho de arquivo README incorreto.

---

**Recursos de Referência**:
- [gautamkrishnar/blog-post-workflow](https://github.com/gautamkrishnar/blog-post-workflow)
- [Documentação Oficial do Hugo](https://gohugo.io/documentation/)
- [Documentação do GitHub Actions](https://docs.github.com/en/actions)
