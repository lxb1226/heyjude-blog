---
title: "Integrate Giscus Comment System into Hugo Blog"
date: 2025-06-15
slug: "giscus-comments-hugo"
tags: ["Hugo", "Comment System", "Giscus", "Blog Setup", "GitHub Discussions", "Static Blog", "Blog Interaction", "Open Source Comments", "Zero-Cost Setup"]
keywords: ["Giscus comment system", "Hugo blog comments", "GitHub Discussions comments", "static blog comment solution", "open source commenting tool", "blog interaction system", "free comment system", "Hugo theme customization", "blog feature extension"]
description: "This comprehensive guide demonstrates how to integrate the Giscus comment system into your Hugo blog, a modern commenting solution powered by GitHub Discussions. Learn how to set up a secure, Markdown-supported comment system with zero cost, featuring dark mode and multi-language support, perfectly suited for Hugo static blogs. No database required - all comment data is stored securely on GitHub, ensuring data safety and sustainability."
---

This is the third tutorial on building your own blog system, focusing on adding a comment system.

During the blog setup process, a good comment system can greatly enhance interactivity. Today, I will introduce how to integrate [Giscus](https://giscus.app/), an open-source comment system based on GitHub Discussions, into a Hugo blog.

## Why Choose Giscus?

- 🚀 No server required, based on GitHub Discussions
- 🔒 Secure and reliable, comment data is stored on GitHub
- 🧩 Supports dark mode and adaptive themes
- 💬 Supports anonymous comments (optional)
- 🌍 Multi-language interface support

## Preparation

Before you start, you need:

1. A repository hosted on GitHub
2. Discussions feature enabled
3. A Hugo blog (any theme will do)

## Step 1: Enable GitHub Discussions

1. Open your blog's code repository (e.g., `username/blog`).
2. Click **Settings** → **Features** → Check **Discussions**.
![](https://img.music-poster.art/2025/06/8c0271325d91ad29527d1acef14fd869.png)
## Step 2: Configure Giscus

Go to [https://giscus.app](https://giscus.app), and on the page:

1. Select your GitHub repository.
2. Set which Discussion category to create comments in (you can create a new one like `announcement`).
3. Custom configuration:
   - Mapping: It is recommended to choose `pathname`, which associates discussions by page path.
   - Reaction: Whether to allow likes and other actions.
   - Theme: Supports `light`, `dark`, `preferred_color_scheme`, etc.
4. Copy the generated `<script>` code.
![](https://img.music-poster.art/2025/06/116ebde5a465cfbea4f3c5b84192be3d.png)
For example, the generated code looks like this:

```html
<script src="https://giscus.app/client.js"
        data-repo="yourname/yourrepo"
        data-repo-id="REPO_ID"
        data-category="General"
        data-category-id="CATEGORY_ID"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="zh-CN"
        crossorigin="anonymous"
        async>
</script>
```

Here you need to remember the three parameters: `data-repo`, `data-repo-id`, and `data-category-id`, which will be used in the following configuration.

## Step 3: Integrate Giscus into Your Hugo Theme
The theme I am using is [hugo-narrow](https://github.com/tom2almighty/hugo-narrow), which integrates the Giscus comment system, and you just need to do a little configuration. Here is my configuration:

```yaml
  comments:
    enabled: true
    # giscus, disqus, utterances, waline, artalk, twikoo
    system: "giscus"

    giscus:
      repo: "data-repo"
      repoId: "data-repo-id"
      category: "Announcements"
      categoryId: "data-category-id"
      mapping: "pathname"
      strict: "0"
      reactionsEnabled: "1"
      emitMetadata: "0"
      inputPosition: "bottom"
      theme: "preferred_color_scheme"
      lang: "en"
```
Note that you need to replace `repo`, `repoId`, and `categoryId` with the values saved in Step 2. This is necessary for comments to display correctly.
Also, ensure that `enabled` is configured as `true` and `system` is set to `giscus`. Otherwise, comments will not show.

Finally, you will see an interface like this at the bottom of the article:
![](https://img.music-poster.art/2025/06/2e3b16e884ac6d67db1651a8d44197db.png)

## Testing

You can comment on this article and see if the comments display correctly. The comments can be checked in the GitHub Discussions.

For example, you can view the comments on my blog [here](https://github.com/lxb1226/lxb1226.github.io/discussions).

![](https://img.music-poster.art/2025/06/fdc145c668e761fb68870ce841967e08.png)