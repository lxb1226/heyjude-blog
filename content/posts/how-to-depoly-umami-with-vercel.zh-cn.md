---
title: 在 Vercel 上部署 Umami 轻松实现网站流量统计
date: 2025-06-15
tags: [Umami, Vercel, Neon, 网站流量统计, 开源, Hugo]
categories: [技术教程]
description: 本文详细介绍如何在 Vercel 上部署开源网站统计工具 Umami，并在 Vercel Storage 中创建 Neon 数据库作为存储，快速搭建一个简单、轻量且注重隐私的网站流量分析系统，适配 Hugo 静态网站生成。
---

Umami 是一个简单、快速、注重隐私的开源网站统计工具，是 Google Analytics 的理想替代品。本文将指导你如何在 Vercel 上部署 Umami，并通过 Vercel Storage 创建 Neon PostgreSQL 数据库，搭建一个零成本、轻量级的网站流量统计系统。本教程特别为 Hugo 静态网站用户优化，确保生成的 Markdown 文件适配 Hugo 的静态网页生成。

## 前言

对于个人博客或中小型网站，Google Analytics 可能过于复杂，且在某些地区访问不便。而 Umami 提供了简洁的界面和核心指标，非常适合轻量级流量分析需求。通过 Vercel 的 Serverless 部署和 Vercel Storage 集成的 Neon 数据库，我们可以快速搭建一个高效的统计系统，无需服务器维护成本。

以下是详细的部署步骤。

## 准备工作

在开始之前，确保你已准备以下内容：

1. **GitHub 账户**：用于 Fork Umami 仓库。
2. **Vercel 账户**：用于部署 Umami 和创建 Neon 数据库。
3. **Neon 账户**：已注册，用于通过 Vercel Storage 连接。
4. 一个运行中的 Hugo 网站（或其他静态网站），用于嵌入 Umami 的跟踪代码。

## 步骤 1：Fork Umami 仓库

1. 访问 Umami 官方 GitHub 仓库：[https://github.com/umami-software/umami](https://github.com/umami-software/umami)。
2. 点击右上角的 **Fork** 按钮，将仓库 Fork 到你的 GitHub 账户。
3. （可选）如果你需要自定义 Umami，可以克隆仓库到本地进行修改，但本教程使用默认配置。

## 步骤 2：在 Vercel 部署 Umami

1. 登录 [Vercel 官网](https://vercel.com/)，点击 **Add New** > **Project**。
2. 在 **Import Git Repository** 页面，选择你刚刚 Fork 的 Umami 仓库。
3. 配置项目：
   - **Framework Preset**：选择 **Next.js**（Umami 基于 Next.js 构建）。
   - **Environment Variables**：暂时跳过，稍后配置 Neon 数据库的 `DATABASE_URL`。
4. 点击 **Deploy** 按钮，Vercel 将自动构建项目（此时可能因缺少数据库连接而失败，稍后修复）。

## 步骤 3：在 Vercel Storage 创建 Neon 数据库

1. 在 Vercel 仪表板中，进入你的 Umami 项目。
2. 点击顶部导航的 **Storage** 标签，然后选择 **Create Database**。
![](https://img.music-poster.art/2025/06/cba773362305001171fb5d0defb4f960.png)
3. 在数据库类型中选择 **Neon**，并登录你的 Neon 账户以授权 Vercel 访问。
4. 配置数据库：
   - **项目名称**：任意，例如 `umami-project`。
   - **数据库名称**：建议使用 `umami`。
   - **云服务托管商**：选择你所在的地区（如 AWS 亚洲区域）以降低延迟。
5. 创建完成后，Vercel 会自动生成一个 **DATABASE_URL** 并将其添加到项目的环境变量中，格式如下：
   ```
   postgresql://[username]:[password]@[host]/[database]
   ```
6. 返回项目设置，确认 **Environment Variables** 中已包含 `DATABASE_URL`。
7. 重新部署项目：点击 **Deployments** 标签，选择最新部署，点击 **Redeploy**。

## 步骤 4：配置 Umami

1. 部署完成后，点击 **Visit** 查看你的 Umami 实例，记下分配的默认域名（如 `your-project.vercel.app`）。
2. 访问 Umami 网站，首次登录默认账户为：
   - 用户名：`admin`
   - 密码：`umami`
3. 登录后立即更改密码以确保安全。
4. 在 Umami 仪表板中，点击 **Add Website**，输入你的网站信息（如域名、名称）。
![](https://img.music-poster.art/2025/06/2b0b37c13001ea761ffcd370f170defc.png)
5. Umami 会生成一段 JavaScript 跟踪代码，格式如下：
   ```html
   <script async src="https://your-project.vercel.app/umami.js" data-website-id="YOUR_WEBSITE_ID"></script>
   ```
   复制此代码。

## 步骤 5：在 Hugo 网站中嵌入跟踪代码

为了让 Umami 统计你的 Hugo 网站流量，需要将跟踪代码嵌入到网站中。这个一般需要你使用的hugo主题支持，如果不支持，则需要自己修改hugo主题。

在这里我使用的是 [hugo-narrow](https://github.com/luizdepra/hugo-narrow) 主题，其支持配置umami , 因此在 `hugo.yaml`文件中配置即可:
```yaml
  analytics:
    enabled: true
    umami: 
      enabled: true
      id: "YOUR_WEBSITE_ID"
      src: "https://your-project.vercel.app/umami.js"
      domains: ""
```
其中的 `YOUR_WEBSITE_ID` 替换为你在 Umami 中创建的网站 ID。`src` 也需要替换为你在 Vercel 中部署的 Umami 项目域名。

接着访问你的网站，Umami 将开始收集流量数据。

## 步骤 6：验证和优化

1. 返回 Umami 仪表板，等待几分钟后检查是否有流量数据记录。
2. 验证跟踪代码是否正常工作：
   - 打开浏览器的开发者工具（F12），切换到 **Network** 面板，刷新页面，确认是否有对 `your-project.vercel.app/api/collect` 的请求。
3. （可选）自定义 Umami 仪表板：
   - 添加多个网站进行跟踪。
   - 配置数据分享链接，方便与团队共享统计数据。
   - 调整 Umami 的主题或语言设置，支持中文界面。

## 注意事项

- **Neon 免费额度**：通过 Vercel Storage 创建的 Neon 数据库有存储和计算时间的限制，适合小型网站。如果流量较大，考虑升级到付费计划。
- **Vercel 免费额度**：Vercel 的免费计划每月提供 100GB 带宽，足以应对大多数个人网站需求。
- **隐私合规**：Umami 注重隐私，但需确保你的网站遵守 GDPR 或其他隐私法规（如在欧盟地区运营）。
- **安全**：定期备份 Neon 数据库，并确保 Umami 的管理员账户使用强密码。

## 结语

通过 Vercel 和其集成的 Neon 数据库，你可以在几分钟内搭建一个功能强大、成本为零的网站流量统计系统。Umami 的简洁界面和核心功能非常适合 Hugo 博客用户，无论是统计访问量、分析来源还是监控页面性能，都能满足需求。

如果你有任何问题或需要进一步优化，欢迎在评论区交流！希望这篇教程能帮助你更好地了解你的网站流量。

## 参考资料

- Umami 官方文档：[https://umami.is/docs](https://umami.is/docs)
- Vercel Storage 文档：[https://vercel.com/docs/storage](https://vercel.com/docs/storage)
- Neon 数据库配置指南：[https://neon.tech/docs](https://neon.tech/docs)
- Hugo 文档：[https://gohugo.io/documentation/](https://gohugo.io/documentation/)