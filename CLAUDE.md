# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a multilingual Hugo blog (heyjude.blog) built with the hugo-narrow theme. It supports 4 languages (English, Chinese Simplified, Japanese, Korean) and uses automated translation workflows.

## Build and Development Commands

### Local Development
```bash
hugo server           # Start development server with live reload
hugo                  # Build the site (output to public/)
hugo --minify        # Build with minification for production
```

### Deployment
The site is automatically deployed via GitHub Actions when pushing to `main`. The workflow builds with Hugo 0.147.0 (extended) and deploys to `lxb1226/lxb1226.github.io`.

### Content Translation
```bash
./translate-posts.sh              # Translate all posts to target languages
TARGET_LANGS="en ja" ./translate-posts.sh  # Translate to specific languages only
```

The translation script uses `ai-markdown-translator` (npm package) and requires `OPENAI_API_KEY` to be set.

## Content Architecture

### Multilingual Content Structure
Posts are stored in `content/posts/` with language suffixes:
- `post-title.zh-cn.md` - Source (Chinese)
- `post-title.en.md` - English translation
- `post-title.ja.md` - Japanese translation
- `post-title.ko.md` - Korean translation

### Frontmatter Template
All posts use this frontmatter structure (defined in `archetypes/default.md`):
```yaml
---
title: "Post Title"
subtitle: ""
date: YYYY-MM-DD
lastmod: YYYY-MM-DD
draft: true
authors: []
description: ""
tags: []
categories: []
series: []
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
```

### Creating New Posts
```bash
hugo new posts/new-post.zh-cn.md   # Create new post with archetype template
```

## Key Configuration Files

- `hugo.yaml` - Main configuration (languages, menus, theme params, analytics, comments)
- `translate-posts.sh` - Automated translation workflow
- `.github/workflows/deploy.yaml` - CI/CD deployment pipeline
- `layouts/partials/layout/head.html` - Custom HTML head overrides

## Theme: hugo-narrow

The theme is a git submodule in `themes/hugo-narrow/`. Key theme features configured:

- **Color schemes**: Default, Claude, Bumblebee, Emerald, Nord, Sunset, Abyss, Dracula
- **UI toggles**: Theme switcher, dark mode, language switcher (all enabled)
- **Sticky header**: Enabled
- **Reading progress bar**: 3px height, hidden on homepage
- **Pagination**: 6 posts per page
- **Related posts**: Shows 3 related posts at bottom

### Comments System
Uses Giscus as primary (GitHub discussions-based). Fallback systems configured: Disqus, Utterances, Waline, Artalk, Twikoo.

### Analytics
- Google Analytics (G-3L0SCGCQNM)
- Microsoft Clarity (s5isr8tvb4)
- Umami (self-hosted)

## Site Structure

```
content/
├── posts/           # Blog posts (multilingual)
├── about.{lang}.md  # About page
├── contact.{lang}.md # Contact page
└── privacy.{lang}.md # Privacy policy

layouts/partials/layout/
└── head.html        # Custom head overrides

static/
├── img/             # Images
└── logo/            # Logo files (logo.jpg referenced in config)

themes/              # Git submodules
└── hugo-narrow/     # Active theme
```

## Navigation Menus

**Main**: Posts, Categories, Tags, Archives
**Footer**: About, Contact, Privacy, RSS Feed, TmpMail, FreeConvert
**Social**: GitHub, Twitter, LinkedIn, Email

## Translation Workflow

1. Create source content in Chinese (`post-title.zh-cn.md`)
2. Run `./translate-posts.sh` to generate translations
3. Script automatically skips existing translations
4. Supports both single-language and multi-language file formats

## Important Notes

- Hugo requires extended version for SCSS support (specified in hugo.yaml)
- Default content language is English (`defaultContentLanguage: en`)
- Source language for translation is Chinese Simplified (`zh-cn`)
- Custom templates should go in `layouts/` directory
- Static assets go in `static/` directory
