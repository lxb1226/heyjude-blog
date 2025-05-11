---
title: "mac如何自动填充手机验证码"
date: 2025-05-07T22:36:09+08:00
lastmod: 2025-05-07T22:36:09+08:00
draft: false
keywords: ["mac", "验证码", "iphone手机", "MessAuto", "AutoCode"]
description: "mac如何自动填充手机验证码"
tags: ["mac", "software", "MessAuto"]
categories: ["tool"]
author: "heyjude"

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: false
toc: false
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# You can also define another contentCopyright. e.g. contentCopyright: "This is another copyright."
contentCopyright: false
reward: false
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

# 缘由
我们知道ios是支持自动填充短信验证码的，在mac上之后safari也是支持的，但是对于非safari浏览器来说，就不支持了。但是在国内平台上面，验证码又是一个逃不过的东西，因此我调研了一下，找到了目前的一些方案。

* [AutoCode](https://apps.apple.com/cn/app/id6472872202)： 这是在app store上面一款免费的软件，支持ios和Andriod转发。
* [MessAuto](https://github.com/LeeeSe/MessAuto)： MessAuto 是一款 macOS 平台自动提取短信和邮箱验证码的软件，由 Rust 开发，适用于任何 App。

由于MessAuto是开源的，因此我这里选择了该款软件。

# MessAuto使用
由于MessAuto是开源软件，并且作者也没有进行分发和签名，因此需要自己编译。

## 1.编译

```bash
# 下载源码
git clone https://github.com/LeeeSe/MessAuto.git
cd MessAuto

# 安装 cargo-bundle
cargo install cargo-bundle --git https://github.com/zed-industries/cargo-bundle.git --branch add-plist-extension
# 打包应用
cargo bundle --release
```
当编译好之后，会在当前目录下的`target/release/bundle/osx/MessAuto.app`构建包。
![](http://img.music-poster.art/2025/05/c090074301dfda862dea2b0797bcdeec.png)

## 2.使用
ARM64 版本打开时会提示文件损坏，因其需要 Apple 开发者签名才可以正常启动，作者没有 Apple 开发者证书，不过你仍然可以通过一条命令解决问题：
* 移动 MessAuto.app 到 /Applications 文件夹下
* 终端执行xattr -cr /Applications/MessAuto.app

这样你就可以使用该app了。

## 3.用法
要程序正常工作，用户需要在ios上打开“短信转发”功能。在设置>信息>iMessage信息即可看到。
![](http://img.music-poster.art/2025/05/20e37bdec4c71f08fe4605b2534b2113.jpeg)

MessAuto 是一个没有 GUI 的菜单栏软件，第一次启动时 MessAuto 会弹窗引导用户授权完全磁盘访问权限，授予权限后系统会要求重新打开软件。在 menubar 上可以看到该软件。其功能依次为：
* 自动粘贴：MessAuto 将检测到的验证码存储到你的剪贴板中，如果你在输入验证码时不想手动粘贴，可以启用此选项，启用选项时 MessAuto 会主动提醒您进行辅助功能授权
* 自动回车：在自动粘贴验证码后再自动帮你按下回车键
不占用剪贴板： MessAuto 不会影响你当前剪贴板中的内容，并不是不占用，而是在粘贴验证码后会自动恢复你之前的剪贴板内容，无论图片或文字，所以此功能开启时会自动开启自动粘贴功能
* 暂时隐藏：暂时隐藏图标，应用重启时图标重现（需先退出后台），适合不经常重启 Mac 的用户
* 永久隐藏：永久隐藏图标，应用重启也不会再显示图标，适合经常重启 Mac 的用户，若需重新显示图标，需要编辑 ~/.config/messauto/messauto.json 文件，将其中的 hide_forever 设置为 false，并重启应用
* 配置：点击后将打开json格式的配置文件，可以在其中自定义关键词
* 日志：快速打开日志
* 监听邮件：开启后将同时监听邮件,要求邮件 App 常驻后台
* 悬浮窗：获取验证码后将弹出一个方便的悬浮窗口

在这里建议把**自动粘贴**、**登陆时启动**打开。因为博主暂时没有监听邮件的需求，便没有打开 监听邮件。有需要的话可以打开。

# 参考
1. https://github.com/LeeeSe/MessAuto





