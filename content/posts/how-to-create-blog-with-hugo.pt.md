---
title: "Como Criar um Blog em 10 Minutos"
date: 2025-05-05T20:28:24+08:00
lastmod: 2025-05-05T20:28:24+08:00
draft: false
keywords: ["criar blog", "tutorial Hugo", "site estático", "blog grátis", "blog setup", "personal website", "static site generator", "blog theme", "web development"]
description: "Um guia detalhado para criar um blog pessoal usando o gerador de sites estáticos Hugo, cobrindo instalação, seleção de temas, configuração básica e gerenciamento de conteúdo - tudo em apenas 10 minutos."
tags: ["hugo", "criar blog", "blog setup", "static site", "personal website", "tutorial"]
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
## O que é Hugo

O Hugo é um dos geradores de sites estáticos de código aberto mais populares. Os usuários podem rapidamente construir seus próprios sites usando o Hugo.

## Passos de Configuração

### Instalar o Hugo
No Mac, você pode usar o seguinte comando para instalar o Hugo:
```bash
brew install hugo
```
![install](https://img.music-poster.art/2025/05/c9d27037a7d215ff8eaa14383cba62b6.png)

Após a instalação, você pode verificar se está instalado corretamente usando `hugo version`:
![hugo_version](https://img.music-poster.art/2025/05/9368e5db6f1f18f70eba3017c7144a9b.png)

### Criar um Site de Blog com o Hugo
Uma vez que o Hugo esteja instalado, você pode usá-lo para criar seu próprio site de blog.
Use `hugo new site my-blog` para criar um site chamado my-blog.
![new-blog-site](https://img.music-poster.art/2025/05/c31b6d2f942a44af304823b9b2d40e76.png)
Após executar este comando, um diretório chamado my-blog será criado no diretório atual.
Então, navegue para esse diretório e inicialize-o com git.
```bash
cd my-blog
git init
```

### Escolher um Tema
Após criar o site, você precisa escolher um tema. Existem muitos temas disponíveis para seleção: [hugo themes](https://themes.gohugo.io/)
Aqui, estou escolhendo o tema hugo-theme-even. Neste ponto, ele precisa ser adicionado como um submódulo sob themes/even.
```bash
git submodule add https://github.com/olOwOlo/hugo-theme-even.git themes/even
```
![pick-theme](https://img.music-poster.art/2025/05/10d92ec7695324dd4db2cb0772f764f8.png)
Depois disso, copie `themes/even/exampleSite/config.toml` para o diretório atual e sobrescreva `hugo.toml`
```bash
cp themes/even/exampleSite/config.toml hugo.toml
```

### Criar uma Postagem do Blog
Uma vez que o tema esteja configurado, você pode criar sua própria postagem do blog.
Use `hugo new content/content/post/my-first-post.md` para criar uma postagem do blog.
Você pode ver que um novo arquivo md aparecerá sob `content/post/` após executar este comando.
![my-first-blog](https://img.music-poster.art/2025/05/b6760e2f47eed1c8a962e475f69adc92.png)


### Executar o Hugo
Uma vez que as configurações anteriores estejam concluídas, você pode iniciar um servidor Hugo usando `hugo server`.
![](https://img.music-poster.art/2025/05/69da7f70c3795f266a83207d186d0ad4.png)
Clique no link para acessar o endereço do site do blog.
![](https://img.music-poster.art/2025/05/10ebbce59ca6637b1b44c8d884c471bd.png)
Neste ponto, você notará que o blog criado anteriormente não aparece; o motivo é que o blog criado anteriormente está definido como `draft`, e não será exibido no modo `hugo server`.
Para exibi-lo, você precisa usar `hugo server -D`.
![](https://img.music-poster.art/2025/05/72c092d59ad8143fa61188eac94ace32.png)

Com isso, você pode completar a configuração do seu site de blog.

### Salvar o Blog Local no GitHub
* Faça login no GitHub e crie um novo repositório (por exemplo, heyjude-blog).
* Adicione o repositório local como remoto:
```
git remote add origin https://github.com/yourusername/myblog.git
git push
```
Desta forma, você pode salvar seu blog no GitHub.

# Links de Referência
1. https://gohugo.io/getting-started/quick-start/
2. https://github.com/olOwOlo/hugo-theme-even
3. https://medium.com/@magstherdev/hugo-in-10-minutes-2dc4ac70ee11
