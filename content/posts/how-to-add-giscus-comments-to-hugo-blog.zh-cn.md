---
title: "为 Hugo 博客接入 Giscus 评论系统"
date: 2025-06-15
slug: "giscus-comments-hugo"
tags: ["Hugo", "评论系统", "Giscus", "博客搭建", "GitHub Discussions", "静态博客", "博客互动", "开源评论系统", "零成本部署"]
keywords: ["Giscus评论系统", "Hugo博客评论", "GitHub Discussions评论", "静态博客评论解决方案", "开源评论工具", "博客互动系统", "免费评论系统", "Hugo主题定制", "博客功能扩展"]
description: "本文详细介绍如何在 Hugo 博客中集成 Giscus 评论系统，这是一个基于 GitHub Discussions 的现代化评论解决方案。通过本教程，你将学会如何零成本搭建一个安全可靠、支持 Markdown 的评论系统，支持暗黑模式、多语言界面，完美适配 Hugo 静态博客。无需数据库，所有评论数据都存储在 GitHub 上，确保数据安全和可持续性。"
---

这是搭建自己的blog系统的第三篇教程，为博客添加评论系统。

在搭建博客的过程中，一个良好的评论系统能极大提升互动性。今天我将介绍如何在 Hugo 博客中集成 [Giscus](https://giscus.app/)，一个基于 GitHub Discussions 的开源评论系统。

## 为什么选择 Giscus？

- 🚀 无需服务器，基于 GitHub Discussions
- 🔒 安全可靠，评论数据存储在 GitHub 上
- 🧩 支持暗黑模式、自适应主题
- 💬 支持匿名评论（可选）
- 🌍 多语言界面支持

## 准备工作

在开始之前，你需要：

1. 一个使用 GitHub 托管的仓库
2. 启用了 Discussions 功能
3. 一个 Hugo 博客（任意主题都可以）

## 步骤一：开启 GitHub Discussions

1. 打开你的博客代码仓库（例如 `username/blog`）。
2. 点击 **Settings** → **Features** → 勾选 **Discussions**。
![](https://img.music-poster.art/2025/06/8c0271325d91ad29527d1acef14fd869.png)
## 步骤二：配置 Giscus

前往 [https://giscus.app](https://giscus.app)，在页面中：

1. 选择你的 GitHub 仓库。
2. 设置评论在哪个 Discussion category 中创建（可以新建一个如 `announcement`）。
3. 自定义配置：
   - Mapping：推荐选择 `pathname`，即按页面路径关联讨论。
   - Reaction：是否允许点赞等操作。
   - 主题：支持 `light`, `dark`, `preferred_color_scheme` 等。
4. 复制生成的 `<script>` 代码。
![](https://img.music-poster.art/2025/06/116ebde5a465cfbea4f3c5b84192be3d.png)
例如生成的代码如下：

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

在这里你需要记住 `data-repo`、`data-repo-id`、`data-category-id` 这三个参数，在后续的配置中会用到。 

## 步骤三：将giscus集成到你的hugo主题里面
我使用的主题是 [hugo-narrow](https://github.com/tom2almighty/hugo-narrow)，该主题集成了giscus评论系统，你只需要配置一下就行。以下是我的配置：

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
注意需要自己将 `repo`， `repoId`, `categoryId` 替换上步骤二中保存的值。这样才能正常显示评论。
同时需要将 `enable` 配置为 `true`, `system` 配置为 `giscus`。否则不会显示评论。

最终你会在文章底部看到这样一个界面：
![](https://img.music-poster.art/2025/06/2e3b16e884ac6d67db1651a8d44197db.png)

## 测试

你可以在这篇文章下面评论，看看评论是否正常显示。评论后的评论可以在Github的Discussion中查看。

例如，你可以在[这里](https://github.com/lxb1226/lxb1226.github.io/discussions)查看我的blog的评论。

![](https://img.music-poster.art/2025/06/fdc145c668e761fb68870ce841967e08.png)