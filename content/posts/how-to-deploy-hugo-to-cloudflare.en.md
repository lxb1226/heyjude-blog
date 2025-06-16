---
title: Build a Blog with Hugo and Deploy it to Cloudflare Pages
date: 2025-06-16T20:29:00+08:00
tags: [Hugo, Cloudflare, Blog, Static Site, Deployment]
categories: [Technical Tutorial]
description: This article details how to create a blog using the Hugo static site generator and deploy it via Cloudflare Pages, including complete steps for environment configuration, theme installation, content creation, and domain binding.
slug: deploy-hugo-to-cloudflare
---

# Build a Blog with Hugo and Deploy it to Cloudflare Pages

In this article, I will guide you step by step through the complete process of building a personal blog using [Hugo](https://gohugo.io/) and deploying it to [Cloudflare Pages](https://pages.cloudflare.com/). Hugo is a fast and flexible static site generator, while Cloudflare Pages offers free static site hosting services with global CDN acceleration, allowing your blog to go live quickly and provide a good user experience. Whether you're a technical novice or an experienced developer, this tutorial will help you quickly set up your own blog.

## Why Choose Hugo and Cloudflare Pages?

- **Hugo**: Written in Go, it is extremely fast, supports a rich set of themes and Markdown format, making it suitable for blogs and documentation sites.
- **Cloudflare Pages**: Provides seamless GitHub integration, automatic deployment, free SSL certificates, and global CDN acceleration, offering better access speeds than GitHub Pages in China.
- **Cost**: The combination of both is completely free, making it ideal for personal blogs or small projects.

## Preparation

Before you begin, you need to prepare the following tools and accounts:

1. **Hugo**: Install the latest version of Hugo (it is recommended to use the extended version for more features).
2. **Git**: For version control and pushing code to GitHub.
3. **GitHub Account**: To store the source code of the blog.
4. **Cloudflare Account**: To deploy and host the blog.
5. **Text Editor**: Such as VSCode, to edit Markdown files and configuration files.

## Step 1: Install Hugo

### Windows
1. Install the Chocolatey package manager (if not already installed):
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
2. Use Chocolatey to install the extended version of Hugo:
   ```powershell
   choco install hugo-extended
   ```
3. Verify the installation:
   ```powershell
   hugo version
   ```

### macOS
1. Install using Homebrew:
   ```bash
   brew install hugo
   ```
2. Verify the installation:
   ```bash
   hugo version
   ```

For more installation methods, refer to the [Hugo official documentation](https://gohugo.io/getting-started/installing/) .

## Step 2: Create a Hugo Site

1. Create a new site in the terminal:
   ```bash
   hugo new site my-blog
   cd my-blog
   ```
   This will generate the directory structure for the Hugo site in the `my-blog` folder:
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

2. Initialize a Git repository:
   ```bash
   git init
   ```

3. Add a `.gitignore` file to ignore generated files:
   ```bash
   echo "public/" >> .gitignore
   echo "resources/" >> .gitignore
   ```

## Step 3: Install and Configure Theme

1. Choose a Hugo theme, for example, [hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack):
   ```bash
   git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
   ```

2. Copy the theme’s example configuration file to the project root:
   ```bash
   cp themes/hugo-theme-stack/exampleSite/config.yaml .
   ```

3. Edit `config.yaml` (or `hugo.toml`) to set basic information:
   ```yaml
   baseURL: "https://your-domain.com/"  # Replace with your domain
   languageCode: "zh-cn"
   title: "My Blog"
   theme: "hugo-theme-stack"
   DefaultContentLanguage: "zh-cn"
   hasCJKLanguage: true
   paginate: 5
   ```

For more theme configuration, refer to the theme's official documentation.

## Step 4: Create Your First Blog Post

1. Create a new post:
   ```bash
   hugo new posts/my-first-post.md
   ```
   This will generate the `my-first-post.md` file in the `content/posts/` directory.

2. Edit the content of the post and modify the Front Matter (post metadata):
   ```markdown
   ---
   title: "My First Blog Post"
   date: 2025-06-16T20:29:00+08:00
   draft: false
   ---
   Welcome to the Hugo blog! This is my first post.
   ```

3. Start the Hugo local server to preview:
   ```bash
   hugo server -D
   ```
   Open the browser and go to `http://localhost:1313/` to see the local preview of the blog.

## Step 5: Push Code to GitHub

1. Create a new repository on GitHub (like `my-blog`), either public or private.
2. Push the local code to GitHub:
   ```bash
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/your-username/my-blog.git
   git branch -M main
   git push -u origin main
   ```

## Step 6: Deploy to Cloudflare Pages

1. Log in to the [Cloudflare Dashboard](https://dash.cloudflare.com/), go to "Workers and Pages" > "Pages" > "Create a Project".
![](https://img.music-poster.art/2025/06/460d03da3f5f0c737c60951d16dd12b4.png)
2. Connect your GitHub account and select the newly created `my-blog` repository.
![](https://img.music-poster.art/2025/06/5577398c00ea3e040f927f4272d7d5c9.png)
3. Configure the build settings:
   - **Project Name**: Any name (like `my-blog`), it will assign a subdomain like `my-blog.pages.dev`.
   - **Production Branch**: Defaults to `main`.
   - **Build Command**: `hugo --gc --minify` (optimizes output files).
   - **Output Directory**: `public`.
   - **Environment Variables**: Add `HUGO_VERSION` (like `0.125.4`) to specify the Hugo version, it is recommended to use the latest version; check the [Hugo Releases](https://github.com/gohugoio/hugo/releases).
   ![](https://img.music-poster.art/2025/06/4ce72f3294fdc3f92e2a504e70a11b5a.png)
4. Click "Save and Deploy", Cloudflare Pages will automatically pull the code, build, and deploy it. Once deployment is complete, you can access your blog through `my-blog.pages.dev`.
![](https://img.music-poster.art/2025/06/50fc6325948a3ddc3aa9a424b56a6f65.png)
## Step 7: Bind a Custom Domain

1. Ensure your domain is hosted on Cloudflare (you can purchase it through Cloudflare or migrate from other registrars).
2. In the Cloudflare Pages project, click "Custom Domain" > "Set Custom Domain".
3. Enter your domain (like `your-domain.com`), Cloudflare will automatically add a CNAME record.
4. Wait for the DNS resolution to take effect (usually a few minutes to a few hours), then access your blog using the custom domain.

## Step 8: Automated Deployment

Each time you update your blog content (like adding new posts or modifying configurations), just run the following commands to push the code:
```bash
git add .
git commit -m "Update blog content"
git push origin main
```
Cloudflare Pages will automatically detect updates in the GitHub repository, rebuild and redeploy, typically completing in 1-2 minutes.

## Issues and Solutions

1. **Mismatch in Hugo Version**: Cloudflare Pages might default to an older version of Hugo, causing build failures. The solution is to specify the latest version in the environment variables (like `HUGO_VERSION=0.125.4`).
2. **Posts Not Displaying**: Check if the `draft: false` is set correctly, as Hugo does not render posts with `draft: true` by default.
3. **Slow Access Speed from China**: Ensure the domain is accelerated by Cloudflare's CDN and SSL is enabled.

## Summary

With Hugo and Cloudflare Pages, you can quickly build a high-performance, free personal blog. Hugo provides flexible content management and rich theme support, while Cloudflare Pages' automatic deployment and global CDN acceleration ensure that the blog's publishing and access are more efficient.

## References
- [Hugo Official Documentation](https://gohugo.io/documentation/)
- [Cloudflare Pages Official Documentation](https://developers.cloudflare.com/pages/)