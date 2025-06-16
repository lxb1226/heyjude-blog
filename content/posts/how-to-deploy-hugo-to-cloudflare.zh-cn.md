---
title: 使用 Hugo 构建博客并部署到 Cloudflare Pages
date: 2025-06-16T20:29:00+08:00
tags: [Hugo, Cloudflare, 博客, 静态网站, 部署]
categories: [技术教程]
description: 本文详细介绍如何使用 Hugo 静态网站生成器创建博客，并通过 Cloudflare Pages 进行部署，包含环境配置、主题安装、内容创建及域名绑定等完整步骤。
slug: deploy-hugo-to-cloudflare
---

# 使用 Hugo 构建博客并部署到 Cloudflare Pages

在这篇文章中，我将带你一步步完成使用 [Hugo](https://gohugo.io/) 构建一个个人博客，并将其部署到 [Cloudflare Pages](https://pages.cloudflare.com/) 的完整过程。Hugo 是一个快速、灵活的静态网站生成器，而 Cloudflare Pages 提供免费的静态网站托管服务，结合全球 CDN 加速，能够让你的博客快速上线并拥有良好的访问体验。无论你是技术新手还是有一定经验的开发者，这篇教程都将帮助你快速搭建一个属于自己的博客。

## 为什么选择 Hugo 和 Cloudflare Pages？

- **Hugo**：以 Go 语言编写，生成速度极快，支持丰富的主题和 Markdown 格式，适合博客和文档网站。
- **Cloudflare Pages**：提供无缝的 GitHub 集成、自动部署、免费 SSL 证书和全球 CDN 加速，国内访问速度优于 GitHub Pages。
- **成本**：两者结合完全免费，适合个人博客或小型项目。

## 准备工作

在开始之前，你需要准备以下工具和账户：

1. **Hugo**：安装最新版本的 Hugo（建议使用扩展版本以支持更多功能）。
2. **Git**：用于版本管理和将代码推送到 GitHub。
3. **GitHub 账户**：用于存储博客源代码。
4. **Cloudflare 账户**：用于部署和托管博客。
5. **文本编辑器**：如 VSCode，用于编辑 Markdown 文件和配置文件。

## 步骤一：安装 Hugo

### Windows
1. 安装 Chocolatey 包管理器（如果尚未安装）：
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
2. 使用 Chocolatey 安装 Hugo 扩展版本：
   ```powershell
   choco install hugo-extended
   ```
3. 验证安装：
   ```powershell
   hugo version
   ```

### macOS
1. 使用 Homebrew 安装：
   ```bash
   brew install hugo
   ```
2. 验证安装：
   ```bash
   hugo version
   ```

更多安装方法可参考 [Hugo 官方文档](https://gohugo.io/getting-started/installing/)。

## 步骤二：创建 Hugo 站点

1. 在终端中创建一个新站点：
   ```bash
   hugo new site my-blog
   cd my-blog
   ```
   这会在 `my-blog` 文件夹中生成 Hugo 站点的目录结构：
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

2. 初始化 Git 仓库：
   ```bash
   git init
   ```

3. 添加 `.gitignore` 文件以忽略生成的文件：
   ```bash
   echo "public/" >> .gitignore
   echo "resources/" >> .gitignore
   ```

## 步骤三：安装和配置主题

1. 选择一个 Hugo 主题，例如 [hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack)：
   ```bash
   git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
   ```

2. 将主题的示例配置文件复制到项目根目录：
   ```bash
   cp themes/hugo-theme-stack/exampleSite/config.yaml .
   ```

3. 编辑 `config.yaml`（或 `hugo.toml`），设置基本信息：
   ```yaml
   baseURL: "https://your-domain.com/"  # 替换为你的域名
   languageCode: "zh-cn"
   title: "我的博客"
   theme: "hugo-theme-stack"
   DefaultContentLanguage: "zh-cn"
   hasCJKLanguage: true
   paginate: 5
   ```

更多主题配置可参考主题的官方文档。

## 步骤四：创建第一篇博客文章

1. 创建一篇新文章：
   ```bash
   hugo new posts/my-first-post.md
   ```
   这会在 `content/posts/` 目录下生成 `my-first-post.md` 文件。

2. 编辑文章内容，修改 Front Matter（文章元数据）：
   ```markdown
   ---
   title: "我的第一篇博客"
   date: 2025-06-16T20:29:00+08:00
   draft: false
   ---
   欢迎体验 Hugo 博客！这是我的第一篇文章。
   ```

3. 启动 Hugo 本地服务器预览：
   ```bash
   hugo server -D
   ```
   打开浏览器访问 `http://localhost:1313/`，即可看到博客的本地预览。

## 步骤五：推送代码到 GitHub

1. 在 GitHub 上创建一个新仓库（如 `my-blog`），可以选择公开或私有。
2. 将本地代码推送到 GitHub：
   ```bash
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/your-username/my-blog.git
   git branch -M main
   git push -u origin main
   ```

## 步骤六：部署到 Cloudflare Pages

1. 登录 [Cloudflare Dashboard](https://dash.cloudflare.com/)，进入“Workers 和 Pages” > “Pages” > “创建项目”。
![](https://img.music-poster.art/2025/06/460d03da3f5f0c737c60951d16dd12b4.png)
2. 连接 GitHub 账户，选择刚刚创建的 `my-blog` 仓库。
![](https://img.music-poster.art/2025/06/5577398c00ea3e040f927f4272d7d5c9.png)
3. 配置构建设置：
   - **项目名称**：任意名称（如 `my-blog`），将分配一个 `my-blog.pages.dev` 的二级域名。
   - **生产分支**：默认 `main`。
   - **构建命令**：`hugo --gc --minify`（优化输出文件）。
   - **输出目录**：`public`。
   - **环境变量**：添加 `HUGO_VERSION`（如 `0.125.4`）以指定 Hugo 版本，建议使用最新版本，查看 [Hugo Releases](https://github.com/gohugoio/hugo/releases)。
   ![](https://img.music-poster.art/2025/06/4ce72f3294fdc3f92e2a504e70a11b5a.png)
4. 点击“保存并部署”，Cloudflare Pages 将自动拉取代码、构建并部署。部署完成后，你可以通过 `my-blog.pages.dev` 访问博客。
![](https://img.music-poster.art/2025/06/50fc6325948a3ddc3aa9a424b56a6f65.png)
## 步骤七：绑定自定义域名

1. 确保你的域名已托管到 Cloudflare（可通过 Cloudflare 购买或从其他注册商迁移）。
2. 在 Cloudflare Pages 项目中，点击“自定义域名” > “设置自定义域名”。
3. 输入你的域名（如 `your-domain.com`），Cloudflare 会自动添加 CNAME 记录。
4. 等待 DNS 解析生效（通常几分钟到几小时），即可通过自定义域名访问博客。

## 步骤八：自动化部署

每次更新博客内容（如新增文章或修改配置），只需执行以下命令推送代码：
```bash
git add .
git commit -m "Update blog content"
git push origin main
```
Cloudflare Pages 会自动检测 GitHub 仓库的更新，重新构建并部署，通常在 1-2 分钟内完成。

## 遇到的问题及解决方法

1. **Hugo 版本不匹配**：Cloudflare Pages 默认可能使用较旧的 Hugo 版本，导致构建失败。解决方法是在环境变量中指定最新版本（如 `HUGO_VERSION=0.125.4`）。
2. **文章未显示**：检查文章的 `draft: false` 是否设置正确，Hugo 默认不渲染 `draft: true` 的文章。
3. **国内访问速度慢**：确保域名通过 Cloudflare 的 CDN 加速，并启用 SSL。

## 总结

通过 Hugo 和 Cloudflare Pages，你可以快速构建一个高性能、免费的个人博客。Hugo 提供了灵活的内容管理和丰富的主题支持，而 Cloudflare Pages 的自动部署和全球 CDN 加速让博客的发布和访问变得更加高效。

## 参考
- [Hugo 官方文档](https://gohugo.io/documentation/)
- [Cloudflare Pages 官方文档](https://developers.cloudflare.com/pages/)
