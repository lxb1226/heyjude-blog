---
title: "How to Auto-fill SMS Verification Codes on Mac"
date: 2025-05-07T22:36:09+08:00
lastmod: 2025-05-07T22:36:09+08:00
draft: false
keywords: ["mac", "verification code", "iphone", "MessAuto", "AutoCode"]
description: "How to auto-fill SMS verification codes on Mac"
tags: ["mac", "software", "MessAuto"]
categories: ["tool"]
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

# Reason
We know that iOS supports auto-filling SMS verification codes, and Safari on Mac also supports it. However, non-Safari browsers do not support this feature. Yet in domestic platforms, verification codes are something we cannot escape from, so I conducted some research and found some current solutions.

* [AutoCode](https://apps.apple.com/cn/app/id6472872202): This is a free app available on the App Store, supporting forwarding on iOS and Android.
* [MessAuto](https://github.com/LeeeSe/MessAuto): MessAuto is an application for macOS that automatically extracts SMS and email verification codes, developed in Rust and suitable for any app.

Since MessAuto is open-source, I chose this software.

# MessAuto Usage
Since MessAuto is open-source software, and the author has not distributed or signed it, it needs to be compiled by yourself.

## 1. Compilation

```bash
# Download the source code
git clone https://github.com/LeeeSe/MessAuto.git
cd MessAuto

# Install cargo-bundle
cargo install cargo-bundle --git https://github.com/zed-industries/cargo-bundle.git --branch add-plist-extension
# Package the application
cargo bundle --release
```
After compilation, the package will be built at `target/release/bundle/osx/MessAuto.app` in the current directory.
![](https://img.music-poster.art/2025/05/c090074301dfda862dea2b0797bcdeec.png)

## 2. Usage
When opening the ARM64 version, it will prompt that the file is damaged as it requires an Apple developer signature to start normally. The author does not have an Apple developer certificate, but you can still resolve the issue with a single command:
* Move MessAuto.app to the /Applications folder
* Execute `xattr -cr /Applications/MessAuto.app` in the terminal

This way, you can use the app.

## 3. Usage
For the program to work properly, users need to enable the “SMS Forwarding” feature on iOS. This can be found under Settings > Messages > iMessage.
![](https://img.music-poster.art/2025/05/20e37bdec4c71f08fe4605b2534b2113.jpeg)

MessAuto is a menu bar software without a GUI. When launched for the first time, MessAuto will prompt the user to grant full disk access permissions; after granting permission, the system will require the software to be reopened. The software can be seen in the menu bar. Its functions are as follows:
* Auto Paste: MessAuto will store detected verification codes in your clipboard. If you don’t want to manually paste when entering the verification code, you can enable this option. When enabled, MessAuto will proactively remind you to authorize the accessibility features.
* Auto Enter: Automatically presses the enter key after auto-pasting the verification code.
* Do Not Occupy Clipboard: MessAuto will not affect the content of your current clipboard. It doesn't mean "not occupying" but will automatically restore your previous clipboard content (whether image or text) after pasting the verification code, so this feature will automatically enable auto paste.
* Temporarily Hide: Temporarily hide the icon, which will reappear when the app restarts (requires exiting background); suitable for users who do not frequently restart their Mac.
* Permanently Hide: Permanently hide the icon; it will not display even after the application restarts; suitable for users who frequently restart their Mac. If you want to show the icon again, you need to edit the `~/.config/messauto/messauto.json` file, set `hide_forever` to false, and restart the application.
* Configuration: Clicking this will open a JSON-formatted configuration file, where you can customize keywords.
* Log: Quickly open the log.
* Listen for Emails: When enabled, it will also listen for emails, requiring the mail app to be running in the background.
* Popup Window: A convenient popup window will appear after obtaining the verification code.

Here it is recommended to turn on **Auto Paste** and **Launch at Login**. Since the author currently does not need to listen for emails, this feature is disabled, but it can be enabled if needed.

# References
1. https://github.com/LeeeSe/MessAuto