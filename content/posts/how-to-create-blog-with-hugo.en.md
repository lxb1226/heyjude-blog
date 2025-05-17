---
title: "10分钟搭建属于自己的blog网站"
date: 2025-05-05T20:28:24+08:00
lastmod: 2025-05-05T20:28:24+08:00
draft: false
keywords: ["hugo", "blog", "theme"]
description: "How to Create Blog With Hugo"
tags: ["hugo", "blog"]
categories: ["hugo", "blog"]
author: "heyjude"

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: true
toc: true
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# You can also define another contentCopyright. e.g. contentCopyright: "This is another copyright."
contentCopyright: false
reward: true
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# You unlisted posts you might want not want the header or footer to show
hideHeaderAndFooter: false

# You can enable or disable out-of-date content warning for individual post.
# Comment this out to use the global config.
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""

---
# hugo是什么

Hugo 是最受欢迎的开源静态网站生成器之一。用户可以使用 Hugo 来快速搭建自己的网站。

# 搭建步骤

## 1.安装hugo
在mac上面，可以使用以下命令来安装hugo:
```bash
brew install hugo
```
![install](http://img.music-poster.art/2025/05/c9d27037a7d215ff8eaa14383cba62b6.png)

安装完之后可以使用 `hugo version` 来查看是否安装好:
![hugo_version](http://img.music-poster.art/2025/05/9368e5db6f1f18f70eba3017c7144a9b.png)

## 2.使用hugo创建blog网站
安装完 hugo 之后，就可以使用 hugo 来搭建自己的blog网站了。
使用`hugo new site my-blog` 来创建一个名为 my-blog 的网站。
![new-blog-site](http://img.music-poster.art/2025/05/c31b6d2f942a44af304823b9b2d40e76.png)
运行完之后就会在当前目录创建一个 my-blog 的目录。
之后进入该目录，并使用 git 进行初始化。
```bash
cd my-blog
git init
```

## 3.选择一个theme
在创建好网站之后，需要选择一个theme。这里有很多主题可供选择：[hugo themes](https://themes.gohugo.io/)
在这里我选择的是 hugo-theme-even 这个主题。此时需要将其作为一个 submodule 放在themes/even下面。
```bash
git submodule add https://github.com/olOwOlo/hugo-theme-even.git themes/even
```
![pick-theme](http://img.music-poster.art/2025/05/10d92ec7695324dd4db2cb0772f764f8.png)
之后将 `themes/even/exampleSite/config.toml` 拷贝到当前目录，并覆盖 `hugo.toml`
```bash
cp themes/even/exampleSite/config.toml hugo.toml
```



## 4.创建一篇blog
当配置好主题之后，就可以创建自己的blog了。
使用`hugo new content content/post/my-first-post.md` 即可创建一篇blog。
可以看到当执行完该命令后，在 `content/post/` 下面会出现一个新的md文件。
![my-first-blog](http://img.music-poster.art/2025/05/b6760e2f47eed1c8a962e475f69adc92.png)


## 5.运行hugo
当前面的配置好之后，就可以使用 `hugo server` 来启动一个hugo server。
![](http://img.music-poster.art/2025/05/69da7f70c3795f266a83207d186d0ad4.png)
点击链接，即可访问blog网站的地址
![](http://img.music-poster.art/2025/05/10ebbce59ca6637b1b44c8d884c471bd.png)
此时会发现，之前创建的那篇blog并没有在里面显示，原因是一开始创建的blog是`draft`,在`hugo server` 模式下并不会显示draft的blog。
如果需要显示，则需要使用`hugo server -D`。
![](http://img.music-poster.art/2025/05/72c092d59ad8143fa61188eac94ace32.png)

以上就可以完成了blog网站的搭建了。

# 参考链接
1. https://gohugo.io/getting-started/quick-start/
2. https://github.com/olOwOlo/hugo-theme-even
3. https://medium.com/@magstherdev/hugo-in-10-minutes-2dc4ac70ee11
