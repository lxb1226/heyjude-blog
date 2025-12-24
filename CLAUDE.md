# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a multilingual Hugo blog (heyjude.blog) built with the hugo-narrow theme. It supports 6 languages (English, Chinese Simplified, Japanese, Korean, Spanish, Portuguese) with English as the default content language and Chinese as the source for translations. The site uses automated AI-powered translation workflows.

## Build and Development Commands

### Local Development
```bash
hugo server           # Start development server with live reload
hugo                  # Build the site (output to public/)
hugo --minify        # Build with minification for production
```

### Deployment
The site is automatically deployed via GitHub Actions when pushing to `main`. The workflow (`.github/workflows/deploy.yaml`) builds with Hugo 0.147.0 (extended) and deploys to `lxb1226/lxb1226.github.io` using a personal access token.

### Content Translation
```bash
./translate-posts.sh                         # Translate all posts to all target languages (en, zh-cn, ja, ko, es, pt)
TARGET_LANGS="en ja" ./translate-posts.sh    # Translate to specific languages only
OPENAI_MODEL="gpt-4" ./translate-posts.sh    # Use a different OpenAI model (default: gpt-3.5-turbo)
```

The translation script uses `ai-markdown-translator` (npm package) and requires `OPENAI_API_KEY` environment variable. The script:
- Processes all `*.zh-cn.md` files in `content/posts/`
- Skips existing translations automatically
- Tracks detailed statistics of processed files

## Content Architecture

### Multilingual Content Structure
Posts are stored in `content/posts/` with language suffixes:
- `post-title.zh-cn.md` - Source (Chinese Simplified)
- `post-title.en.md` - English translation
- `post-title.ja.md` - Japanese translation
- `post-title.ko.md` - Korean translation
- `post-title.es.md` - Spanish translation
- `post-title.pt.md` - Portuguese translation

Other pages (about, contact, privacy) follow the same pattern in `content/`.

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
- `translate-posts.sh` - Automated translation workflow script
- `.github/workflows/deploy.yaml` - CI/CD deployment pipeline
- `archetypes/default.md` - Template for new posts
- `layouts/partials/layout/head.html` - Custom HTML head overrides (if needed)

## Theme: hugo-narrow

The active theme is `hugo-narrow` (git submodule in `themes/hugo-narrow/`). Note that `themes/` also contains other themes (DoIt, LoveIt, even) that are not currently in use. Key theme features configured:

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
**Footer**: About, Contact, Privacy, RSS Feed, TmpMail, FreeConvert, MP3To, EasyPDF
**Social**: GitHub, Twitter, LinkedIn, Email

## Translation Workflow

1. Create source content in Chinese (`post-title.zh-cn.md`) in `content/posts/`
2. Run `./translate-posts.sh` to generate translations for all configured languages
3. Script automatically skips existing translations to avoid duplicate work
4. Review generated translations and commit to repository
5. Translations are deployed automatically via GitHub Actions on push to `main`

## Important Notes

- **Hugo Version**: Requires extended version (0.146.0+) for SCSS support (specified in `hugo.yaml`)
- **Default Language**: English (`defaultContentLanguage: en`)
- **Source Language**: Chinese Simplified (`zh-cn`) is used as the source for AI translations
- **Supported Languages**: en, zh-cn, ja, ko, es, pt (6 total)
- **Theme Submodules**: Run `git submodule update --init --recursive` before building if submodules are missing
- **Custom Overrides**: Place custom templates in `layouts/` directory to override theme defaults
- **Static Assets**: Store images and files in `static/` directory
- **GitHub Actions Secret**: Deployment requires `MY_PAT` secret (personal access token) for pushing to `lxb1226.github.io`
