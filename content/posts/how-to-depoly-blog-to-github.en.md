---
title: "Deploy Your Blog Website to GitHub Pages in 10 Minutes"
subtitle: "Free Hosting for Your Hugo Blog on GitHub Pages"
date: 2025-05-18T17:01:07+08:00
lastmod: 2025-05-18T17:01:07+08:00
draft: false
authors: ["heyjude"]
description: "Step-by-step guide on deploying your Hugo blog to GitHub Pages, including repository setup, GitHub Actions configuration, and automated deployment workflow, helping you create a professional blog website at zero cost."

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

Once we have built our blog website locally, the next step is to distribute the blog content online so that others can see it.

I researched the current hosting websites and found the following options:

- **GitHub Pages**: A free static site hosting service provided by GitHub, suitable for integration with code repositories.
- **Netlify**: Supports automatic building and deployment, rich features in free tier, with very good Hugo support.
- **Vercel**: Developed by the Next.js team, fast deployment, suitable for frontend projects.
- **Cloudflare Pages**: Static site hosting service provided by Cloudflare, comes with CDN and security acceleration.
- **Firebase Hosting**: A frontend hosting platform launched by Google, suitable for use with frontend applications.
- **Amazon S3 + CloudFront**: A high-performance hosting and distribution solution, suitable for professional deployments.
- **GitLab Pages**: Static site hosting service provided by GitLab, automatically builds through CI configuration.
- **Render**: A streamlined full-stack hosting platform, supports automatic deployment of Hugo sites.
- **Surge.sh**: A minimalist static site hosting tool, simple and quick command line deployment.
- **DigitalOcean App Platform**: Cloud service platform that supports automatic deployment of static websites and backend services.

These platforms each have their own characteristics, and I will introduce how to deploy on each one in upcoming articles. In this article, I will introduce how to deploy a blog website to GitHub Pages.

## What is GitHub Pages?
GitHub Pages is a free static website hosting service provided by GitHub, suitable for hosting blogs, project homepages, documentation, etc. You only need a GitHub repository to publish your website at https://yourname.github.io or a custom domain.

## How to Deploy a Blog Website to GitHub Pages
### Overall Plan
* Your main repository (for example, my-hugo-site) contains the Hugo source code (content/, layouts/, etc.).
* The built static files (public/) will be pushed to another repository (yourusername.github.io).
* The yourusername.github.io repository is specifically for hosting the generated static website.

### Project Structure
Assuming you have two GitHub repositories:
* my-hugo-site (source repository): stores the Hugo source code and articles.
* yourusername.github.io (deployment repository): stores the built static files.

The project structure is as follows:
```
my-hugo-site/
├── content/            # Blog content
├── layouts/            # Custom layouts for Hugo
├── themes/             # Hugo themes
├── config.toml        # Hugo configuration file
└── .github/workflows/deploy.yml  # Automatic deployment configuration

yourusername.github.io/
├── (published static website files)   # Static files generated by Hugo
```
### Step 1: Create Two Repositories
1. Create two repositories on GitHub:
  * my-hugo-site: for storing the Hugo source code.
  * yourusername.github.io: for storing the built static files.

2. In the yourusername.github.io repository, set the source branch for GitHub Pages to main (or master).

### Step 2: Set Up GitHub Actions for Automated Deployment
In the my-hugo-site repository, create the .github/workflows/deploy.yml file to set up automated builds and push static files to the yourusername.github.io repository.
```yaml
name: GitHub Pages

on:
  push:
    branches:
      - main  # The default branch for the blog root directory; here it is main, sometimes it's master
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
          hugo-version: '0.147.0'  # Specify your Hugo version, can check using hugo version
          extended: true          # If you are using a non-extended version of Hugo, change true to false

      - name: Build
        run: git submodule update --init --recursive && hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: ${{ github.ref == 'refs/heads/main' }}  # Make sure to use either main or master
        with:
          personal_token: ${{ secrets.MY_PAT}} # If the secret has another name, replace MY_PAT with that name
          external_repository: lxb1226/lxb1226.github.io # Fill in the remote repository, not necessarily this format, write according to your situation
          publish_dir: ./public
          #cname: www.example.com        # Fill in your custom domain. If no custom domain is used, comment out this line
```
You can refer to my [deploy.yaml](https://github.com/lxb1226/heyjude-blog/blob/main/.github/workflows/deploy.yaml)

### Obtaining GitHub Secrets
In the above yaml file, you need to obtain the `personal_token`. You can get it from the my-hugo-site repository.

You can retrieve it in the repository -> Settings -> Secrets and variables -> Actions.
![personal_token](https://img.music-poster.art/2025/05/5331092ac30840b1bc967395cce01709.png)

### Step 3: Configure GitHub Pages
1. In the yourusername.github.io repository, go to Settings → Pages.
2. Set the Source to the main branch and ensure that GitHub Pages is configured correctly.
3. After saving, the static website will be hosted at https://yourusername.github.io/.
![](https://img.music-poster.art/2025/05/9052201a8331d0e293e23b1741d0fc80.png)

## Automatic Blog Publishing Process
1. Write articles and modify the site in the my-hugo-site repository.
2. Each time you push updates to the main branch, GitHub Actions will automatically build and push the static files to the yourusername.github.io repository.
3. GitHub Pages will automatically update and show at https://yourusername.github.io/. (Usually, this takes some time)

## References
1. https://docs.github.com/en/actions
2. https://gohugo.io/documentation/
3. https://lxb1226.github.io/
4. https://github.com/lxb1226/heyjude-blog