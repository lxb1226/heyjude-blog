---
title: "10分钟部署你的blog网站到github pages"
subtitle: ""
date: 2025-05-18T17:01:07+08:00
lastmod: 2025-05-18T17:01:07+08:00
draft: false
authors: []
description: ""

tags: ["hugo", "github pages", "depoly"]
categories: ["hugo", "github pages", "depoly"]
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

当我们在本地建立了我们的blog网站后，下一步就可以将blog内容分发到网络上，这样别人就可以看到了。

我调研了一下目前的托管网站，有以下选择：

- **GitHub Pages**：GitHub 提供的免费静态站点托管服务，适合与代码仓库集成。
- **Netlify**：支持自动构建和部署，免费套餐功能丰富，Hugo 支持非常好。
- **Vercel**：由 Next.js 团队开发，部署速度快，适合前端项目。
- **Cloudflare Pages**：Cloudflare 提供的静态站点托管服务，自带 CDN 和安全加速。
- **Firebase Hosting**：谷歌推出的前端托管平台，适合与前端应用配合使用。
- **Amazon S3 + CloudFront**：高性能的托管和分发解决方案，适合专业部署。
- **GitLab Pages**：GitLab 提供的静态站点托管服务，通过 CI 配置自动构建。
- **Render**：简洁的全栈托管平台，支持自动部署 Hugo 网站。
- **Surge.sh**：极简风格的静态站点托管工具，命令行部署简单快速。
- **DigitalOcean App Platform**：云服务平台，支持自动部署静态网站和后端服务。

这些平台各有特点，在后面的文章中我会一一介绍如何部署。在本篇文章中，我将介绍如何将blog网站部署到github page上。

## 什么是 Github Pages
GitHub Pages 是 GitHub 提供的免费静态网站托管服务，适合托管博客、项目主页、文档等。你只需要一个 GitHub 仓库，就可以将网站发布到 https://yourname.github.io 或自定义域名上。

## 如何部署blog网站到Github Pages
### 总体思路
* 你的主仓库（例如 my-hugo-site）包含 Hugo 源代码（content/、layouts/ 等）。
* 构建后的静态文件（public/）将被推送到 另一个仓库（yourusername.github.io）。
* yourusername.github.io 仓库专门用于托管生成的静态网站。

### 项目结构
假设你有两个 GitHub 仓库：
* my-hugo-site（源仓库）：存储 Hugo 源代码和文章。
* yourusername.github.io（部署仓库）：存储构建后的静态文件。

项目结构如下：
```
my-hugo-site/
├── content/            # 博客内容
├── layouts/            # Hugo 自定义布局
├── themes/             # Hugo 主题
├── config.toml        # Hugo 配置文件
└── .github/workflows/deploy.yml  # 自动部署配置

yourusername.github.io/
├── (发布的静态网站文件)   # 静态文件由 Hugo 构建后生成
```
### 步骤一：创建两个仓库
1. 在 GitHub 上创建两个仓库：
  * my-hugo-site：用于存储 Hugo 源代码。
  * yourusername.github.io：用于存储构建后的静态文件。

2. 在 yourusername.github.io 仓库中，设置 GitHub Pages 的源分支为 main（或者 master）。

### 步骤二：设置 GitHub Actions 自动化部署
在 my-hugo-site 仓库中，创建 .github/workflows/deploy.yml 文件，设置自动构建并将静态文件推送到 yourusername.github.io 仓库。
```yaml
name: GitHub Pages

on:
  push:
    branches:
      - main  # 博客根目录的默认分支，这里是main，有时也是master
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
          hugo-version: '0.147.0'  # 填写你的hugo版本，可用hugo version查看
          extended: true          # 如果你使用的不是extended版本的hugo，将true改为false

      - name: Build
        run: git submodule update --init --recursive && hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: ${{ github.ref == 'refs/heads/main' }}  # 注意填写main或者master
        with:
          personal_token: ${{ secrets.MY_PAT}} # 如果secret取了其他名称，将MY_PAT替换掉
          external_repository: lxb1226/lxb1226.github.io # 填写远程仓库，不一定是这个格式，按照自己的情况写 
          publish_dir: ./public
          #cname: www.example.com        # 填写你的自定义域名。如果没有用自定义域名，注释掉这行
```
可以参考我的[depoly.yaml](https://github.com/lxb1226/heyjude-blog/blob/main/.github/workflows/deploy.yaml)

### GitHub secrets 获取
在上面的yaml文件中，需要获取到 `personal_token`。你可以在my-hugo-site 仓库中获取。

你可以在仓库->Settings->Secrets and variables->Actions中获取。
![personal_token](https://img.music-poster.art/2025/05/5331092ac30840b1bc967395cce01709.png)


### 步骤三：配置Github Pages
1. 在 yourusername.github.io 仓库中，进入 Settings → Pages。
2. 设置 Source 为 main 分支，确保正确配置了 GitHub Pages。
3. 保存后，静态网站会托管在 https://yourusername.github.io/。
![](https://img.music-poster.art/2025/05/9052201a8331d0e293e23b1741d0fc80.png)

## blog自动发布流程
1. 在 my-hugo-site 仓库中编写文章、修改站点。
2. 每次推送更新到 main 分支时，GitHub Actions 自动构建并将静态文件推送到 yourusername.github.io 仓库。
3. GitHub Pages 自动更新并展示在 https://yourusername.github.io/。（这个一般要等一段时间）


## 参考
1. https://docs.github.com/en/actions
2. https://gohugo.io/documentation/
3. https://lxb1226.github.io/
4. https://github.com/lxb1226/heyjude-blog



