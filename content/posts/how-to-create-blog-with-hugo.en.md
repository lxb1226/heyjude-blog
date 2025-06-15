---
title: "Build Your Own Blog Website in 10 Minutes"
date: 2025-05-05T20:28:24+08:00
lastmod: 2025-05-05T20:28:24+08:00
draft: false
keywords: ["hugo", "blog setup", "personal website", "static site generator", "blog theme", "web development"]
description: "A detailed guide on creating a personal blog using Hugo static site generator, covering installation, theme selection, basic configuration, and content management - all in just 10 minutes."
tags: ["hugo", "blog setup", "static site", "personal website", "tutorial"]
categories: ["Blog Setup", "Tutorials"]
series: ["blog tutorial"]
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
## What is Hugo

Hugo is one of the most popular open-source static site generators. Users can quickly build their own websites using Hugo.

## Setup Steps

### Install Hugo
On a Mac, you can use the following command to install Hugo:
```bash
brew install hugo
```
![install](https://img.music-poster.art/2025/05/c9d27037a7d215ff8eaa14383cba62b6.png)

After installation, you can check if it's installed properly using `hugo version`:
![hugo_version](https://img.music-poster.art/2025/05/9368e5db6f1f18f70eba3017c7144a9b.png)

### Create a Blog Website with Hugo
Once Hugo is installed, you can use it to create your own blog website.
Use `hugo new site my-blog` to create a site named my-blog.
![new-blog-site](https://img.music-poster.art/2025/05/c31b6d2f942a44af304823b9b2d40e76.png)
After running this command, a directory named my-blog will be created in the current directory.
Then, navigate into that directory and initialize it with git.
```bash
cd my-blog
git init
```

### Choose a Theme
After creating the website, you need to choose a theme. There are many themes available for selection: [hugo themes](https://themes.gohugo.io/)
Here, I am choosing the hugo-theme-even theme. At this point, it needs to be added as a submodule under themes/even.
```bash
git submodule add https://github.com/olOwOlo/hugo-theme-even.git themes/even
```
![pick-theme](https://img.music-poster.art/2025/05/10d92ec7695324dd4db2cb0772f764f8.png)
After that, copy `themes/even/exampleSite/config.toml` to the current directory and overwrite `hugo.toml`
```bash
cp themes/even/exampleSite/config.toml hugo.toml
```

### Create a Blog Post
Once the theme is configured, you can create your own blog post.
Use `hugo new content/content/post/my-first-post.md` to create a blog post.
You can see that a new md file will appear under `content/post/` after executing this command.
![my-first-blog](https://img.music-poster.art/2025/05/b6760e2f47eed1c8a962e475f69adc92.png)


### Run Hugo
Once the previous configurations are done, you can start a Hugo server using `hugo server`.
![](https://img.music-poster.art/2025/05/69da7f70c3795f266a83207d186d0ad4.png)
Click the link to access the blog website address.
![](https://img.music-poster.art/2025/05/10ebbce59ca6637b1b44c8d884c471bd.png)
At this point, you will notice that the previously created blog does not appear; the reason is that the blog created earlier is set as `draft`, and it will not be displayed in `hugo server` mode.
To show it, you need to use `hugo server -D`.
![](https://img.music-poster.art/2025/05/72c092d59ad8143fa61188eac94ace32.png)

With this, you can complete the setup of your blog website.

### Save the Local Blog to GitHub
* Log in to GitHub and create a new repository (e.g., heyjude-blog).
* Add the local repository as a remote:
```
git remote add origin https://github.com/yourusername/myblog.git
git push
```
This way, you can save your blog to GitHub.

# Reference Links
1. https://gohugo.io/getting-started/quick-start/
2. https://github.com/olOwOlo/hugo-theme-even
3. https://medium.com/@magstherdev/hugo-in-10-minutes-2dc4ac70ee11