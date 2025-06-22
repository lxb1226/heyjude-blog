---
title: "How to Automatically Translate Your Hugo Blog Using AI"
subtitle: "Utilizing OpenAI for Multi-Language Support in Blogs"
date: 2024-01-20T10:00:00+08:00
lastmod: 2024-01-20T10:00:00+08:00
draft: false
authors: ["heyjude"] 
description: "This article explains how to use AI tools to automatically translate your Hugo blog into multiple languages, achieving the internationalization of your blog."

tags: ["Hugo", "Blog", "AI", "OpenAI", "Automation", "Internationalization", "i18n"]
categories: ["Tutorial"]

featuredImage: ""
featuredImagePreview: ""

hiddenFromHomePage: false
hiddenFromSearch: false
twemoji: false
lightgallery: true
ruby: true
fraction: true
fontawesome: true
linkToMarkdown: true
rssFullText: false

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
share:
  enable: true
comment:
  enable: true
---

## Introduction

Once we have created our own blog, we would like it to support multiple languages. This not only expands our audience but also enhances the SEO performance of the blog. However, manually translating blog posts is a time-consuming and labor-intensive task, requiring professional translators. But with the development of AI, things are different now; using AI, you can easily translate your blog into any desired language. To facilitate this, I created a tool that utilizes AI to automate the translation of your blog posts, allowing you to effortlessly support multiple languages.

You can find the tool at [hugo-translator](https://github.com/lxb1226/hugo-translator).

## Preparation

Before getting started, you need to prepare the following:

1. A running Hugo blog
2. Node.js and npm environment
3. OpenAI API key (for AI translation)
4. Basic command line operation knowledge

## Implementation Steps

### 1. Obtain the Tool

```bash
git clone https://github.com/lxb1226/hugo-translator.git
cd hugo-translator
```

### 2. Install AI Translation Tool

We will use the `ai-markdown-translator` tool to translate Markdown files. First, install it globally:

```bash
npm install -g ai-markdown-translator
```

### 3. Configure Environment Variables

Set the OpenAI API key:

```bash
export OPENAI_API_KEY='your-api-key'
```
If you do not have an OpenAI API key, you can also use a third-party API. You can purchase a third-party API key through this [link](https://aihubmix.com?aff=jqnC).
Afterwards, you can set:
```bash
export OPENAI_URL='your api url'
export API_KEY='your-api-key'
```

You can also add this configuration to your `.bashrc` or `.zshrc` file for it to take effect permanently.

### 4. Create the Translation Script

Create a script file named `translate-posts.sh` to automate the translation process. This script will:

- Automatically detect blog posts
- Support multi-language translation
- Skip already translated posts
- Provide detailed translation progress and statistics

Key features include:

1. **Multi-language Support**: Default support for multiple languages, including English, Japanese, and Korean.
2. **Intelligent Detection**: Automatically identify source and target languages.
3. **Incremental Updates**: Only translate new or changed content.
4. **Error Handling**: Comprehensive error handling and logging.
5. **Progress Display**: Real-time display of translation progress and status.

### 5. Usage

Basic usage:

```bash
./translate-posts.sh
```

Custom target languages:

```bash
TARGET_LANGS="en ja ko" ./translate-posts.sh
```
![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

### 6. File Naming Rules

The translated files will be automatically named according to Hugo's internationalization naming convention:

- English version: `post-name.en.md`
- Japanese version: `post-name.ja.md`
- Korean version: `post-name.ko.md`

## References

- [Official Hugo Multilingual Support Documentation](https://gohugo.io/content-management/multilingual/)
- [OpenAI API Documentation](https://platform.openai.com/docs/api-reference)
- [ai-markdown-translator Usage Guide](https://github.com/h7ml/ai-markdown-translator)
- [hugo-translator](https://github.com/lxb1226/hugo-translator)