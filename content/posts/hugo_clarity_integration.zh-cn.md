---
title: "如何为 Hugo 博客网站接入 Microsoft Clarity 分析工具"
date: 2025-06-21T22:00:00+08:00
draft: false
tags: [Hugo, Microsoft Clarity, 网站分析, SEO, 静态网站]
categories: ["技术", "博客搭建"]
description: "本文详细介绍如何在 Hugo 静态博客网站中集成 Microsoft Clarity 分析工具，通过简单的步骤实现用户行为分析和热图功能，提升网站优化与用户体验。"
---

---

## 前言

Microsoft Clarity 是一款免费的网站分析工具，能够提供用户行为热图、会话录制和详细的分析数据，帮助站长更好地了解用户行为，优化网站内容和用户体验。当你搭建好自己的blog的网站后，肯定希望能够关注到用户的具体行为，该工具能够帮你很好的了解用户行为，帮你实现分析的功能。 对于使用 Hugo 搭建的静态博客网站，接入 Clarity 非常简单，只需几步即可完成。

---

## 准备工作

在开始之前，您需要：

1. 一个已搭建好的 Hugo 博客网站。你可以在之前的文章里面看到对应的教程
2. Microsoft Clarity 账户（可在 [Clarity 官网](https://clarity.microsoft.com/) 注册）。
3. 基本的 Hugo 配置文件和主题知识。

---

## 步骤一：获取 Clarity 跟踪代码

1. **注册并创建项目**：
   - 访问 [Microsoft Clarity 官网](https://clarity.microsoft.com/)，使用 Microsoft 账户登录。
   - 创建一个新项目，输入您的博客网站 URL（如 `https://heyjude.blog`）。
   ![](https://img.music-poster.art/2025/06/1d4e1b96c05d92a6e5e10b94fa9a6a2e.png)
   ![](https://img.music-poster.art/2025/06/d2e9b6f461b2546bbf3cb32228ba23f6.png)
   - 保存项目后，Clarity 会生成一段跟踪代码，形如：

     ```html
     <script type="text/javascript">
         (function(c,l,a,r,i,t,y){
             c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
             t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;
             y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
         })(window, document, "clarity", "script", "your_project_id");
     </script>
     ```
      ![](https://img.music-poster.art/2025/06/e153583c872ea5a5724778e001a1a8d7.png)
   - 复制此代码中的 `your_project_id`（项目 ID），后续会用到。

---

## 步骤二：在 Hugo blog中添加 Clarity 跟踪代码

我们之前有基于Hugo搭建自己的博客，可以知道 Hugo 是一个静态网站生成器，所有的页面内容都通过模板文件（`layouts` 目录）生成。我们需要将 Clarity 的跟踪代码嵌入到网站的 `<head>` 标签中。

### 方法 1: 基于使用的主题来添加

一般来说，我们都会使用别人构建好的主题来搭建自己的博客，有的主题可能会自带Clarity的代码，我们只需要将自己的项目ID替换即可。
博主这里使用的是 [hugo-narrow](https://github.com/tom2almighty/hugo-narrow) 主题，该主题自带Clarity的代码，我们只需要将自己的项目ID替换即可。

```yaml
  analytics:
    enabled: true
    baidu:
      enabled: false
      id: "your-baidu-analytics-id"
    clarity:
      enabled: true
      id: "your_project_id"
```

这样即可完成部署。

### 方法 2：直接修改主题的 `head.html`

1. **找到主题的 `head.html` 文件**：
   - 打开 Hugo 项目的 `themes/你的主题/layouts/partials/` 目录，找到 `head.html` 或类似文件（不同主题可能文件名略有不同，例如 `header.html`）。
   - 如果您的主题没有 `head.html`，可以检查 `layouts/_default/baseof.html` 文件。

2. **添加 Clarity 跟踪代码**：
   - 在 `head.html` 文件的 `<head>` 标签内，粘贴 Clarity 提供的跟踪代码。例如：

     ```html
     {{ if not .Site.IsServer }}
     <script type="text/javascript">
         (function(c,l,a,r,i,t,y){
             c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
             t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;
             y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
         })(window, document, "clarity", "script", "your_project_id");
     </script>
     {{ end }}
     ```

   - **注意**：我们使用 `{{ if not .Site.IsServer }}` 条件语句，避免在本地开发模式（`hugo server`）下加载 Clarity 代码，以防止干扰本地测试数据。

3. **保存并测试**：
   - 保存文件后，运行 `hugo server -D` 在本地预览网站。
   - 部署网站到生产环境（例如 GitHub Pages 或 Vercel），然后访问 Clarity 仪表板，确认数据是否开始记录。

### 方法 3：通过 Hugo 配置文件添加

如果您不想直接修改主题文件（例如为了方便主题更新），可以通过 Hugo 的配置文件添加 Clarity 代码。

1. **编辑 `config.toml` 或 `config.yaml`**：
   - 打开 Hugo 项目的根目录下的 `config.toml`（或 `config.yaml`）。
   - 添加 Clarity 的跟踪代码到 `[params]` 部分。例如，在 `config.toml` 中：

     ```toml
     [params]
         customHeadHTML = """
         <script type='text/javascript'>
             (function(c,l,a,r,i,t,y){
                 c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
                 t=l.createElement(r);t.async=1;t.src='https://www.clarity.ms/tag/'+i;
                 y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
             })(window, document, 'clarity', 'script', 'your_project_id');
         </script>
         """
     ```

   - 如果使用 `config.yaml`，则添加：

     ```yaml
     params:
       customHeadHTML: |
         <script type='text/javascript'>
             (function(c,l,a,r,i,t,y){
                 c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
                 t=l.createElement(r);t.async=1;t.src='https://www.clarity.ms/tag/'+i;
                 y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
             })(window, document, 'clarity', 'script', 'your_project_id');
         </script>
     ```

2. **修改主题模板引用自定义 HTML**：
   - 在 `themes/你的主题/layouts/partials/head.html` 中，添加以下代码以引用配置文件中的 `customHeadHTML`：

     ```html
     {{ if .Site.Params.customHeadHTML }}
         {{ .Site.Params.customHeadHTML | safeHTML }}
     {{ end }}
     ```

   - 这将确保 Clarity 跟踪代码被正确加载到 `<head>` 标签中。

---

## 步骤三：验证 Clarity 是否正常工作

1. **部署网站**：
   - 使用 `hugo` 命令生成静态文件，并部署到您的托管平台（例如 GitHub Pages、Vercel 或 Netlify）。
   - 确保 Clarity 跟踪代码已正确嵌入到生成的 HTML 文件中（可通过浏览器开发者工具查看 `<head>` 标签）。

2. **检查 Clarity 仪表板**：
   - 登录 Clarity 仪表板，等待几分钟（通常 2小时）后，检查是否有用户访问数据、热图或会话录制。
   ![](https://img.music-poster.art/2025/06/75aaa3bce1bc23c1b5eec841eca1976c.png)
   - 如果没有数据，请检查：
     - 项目 ID 是否正确。
     - 跟踪代码是否正确嵌入 `<head>` 标签。
     - 网站是否已部署到公网。

---

## 步骤四：优化与注意事项

1. **避免本地开发干扰**：
   - 如上所述，使用 `{{ if not .Site.IsServer }}` 避免本地开发时的跟踪数据污染。

2. **隐私与合规性**：
   - Clarity 会收集用户行为数据，请确保您的网站隐私政策中已说明使用 Clarity 进行分析。
   - 如果您的博客面向欧盟用户，需遵守 GDPR 要求，可能需要添加 cookie 同意提示。

3. **与 Google Analytics 结合**：
   - Clarity 的热图和会话录制功能与 Google Analytics 的流量统计功能互补。您可以同时使用两者以获得更全面的分析数据。

4. **定期检查数据**：
   - 定期查看 Clarity 仪表板的热图和会话录制，分析用户点击行为和页面滚动深度，优化博客内容布局。

---

---

## 参考资料

- [Microsoft Clarity 官方文档](https://docs.microsoft.com/en-us/clarity/)
- [Hugo 官方文档 - 模板](https://gohugo.io/templates/)
- [Hugo 配置文件指南](https://gohugo.io/getting-started/configuration/)