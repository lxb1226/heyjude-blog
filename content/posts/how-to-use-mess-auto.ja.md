---
title: "Macで携帯電話の認証コードを自動入力する方法"
date: 2025-05-07T22:36:09+08:00
lastmod: 2025-05-07T22:36:09+08:00
draft: false
keywords: ["mac認証コード", "自動入力", "MessAuto", "AutoCode", "iPhone同期", "SMS認証コード", "効率ツール", "自動化ツール"]
description: "MacでMessAutoツールを設定し、iPhoneの認証コードを自動的に同期・入力する方法について詳しく説明します。日常操作の効率を向上させる実用的なチュートリアルです。"
tags: ["Mac", "効率ツール", "MessAuto", "自動化", "iPhone", "認証コード同期"]
categories: ["効率ツール", "技術チュートリアル", "Macアプリ"]
author: "heyjude"

# このコンテンツに対して何かを閉じる(false)または開く(true)こともできます。
# P.S. コメントは閉じることだけできます
comment: true
toc: true
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# 別のcontentCopyrightを定義することもできます。例: contentCopyright: "これは別の著作権です。"
contentCopyright: false
reward: true
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# ヘッダーやフッターを表示させたくない非公開の投稿
hideHeaderAndFooter: false

# 各投稿について、時代遅れのコンテンツ警告を有効または無効にできます。
# これをコメントアウトしてグローバル設定を使用します。
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""

---

# 背景
iOSはSMS認証コードの自動入力をサポートしていますが、Mac上ではSafariがこれをサポートしています。しかし、非Safariブラウザではサポートされていません。しかし、中国のプラットフォームでは、認証コードは避けられないものです。そのため、私は調査を行い、現在のいくつかの解決策を見つけました。

* [AutoCode](https://apps.apple.com/cn/app/id6472872202)：これはApp Storeにある無料のソフトウェアで、iOSとAndroidの転送をサポートしています。
* [MessAuto](https://github.com/LeeeSe/MessAuto)：MessAutoはmacOSプラットフォームでSMSおよびメール認証コードを自動抽出するソフトウェアで、Rustで開発されており、任意のアプリに適しています。

MessAutoはオープンソースであるため、私はこのソフトウェアを選択しました。

# MessAutoの使用
MessAutoはオープンソースソフトウェアで、作者は配布や署名を行っていないため、自分でコンパイルする必要があります。

## 1. コンパイル

```bash
# ソースコードをダウンロード
git clone https://github.com/LeeeSe/MessAuto.git
cd MessAuto

# cargo-bundleをインストール
cargo install cargo-bundle --git https://github.com/zed-industries/cargo-bundle.git --branch add-plist-extension
# アプリをパッケージ化
cargo bundle --release
```
コンパイルが完了すると、現在のディレクトリの`target/release/bundle/osx/MessAuto.app`にビルドパッケージが生成されます。
![](https://img.music-poster.art/2025/05/c090074301dfda862dea2b0797bcdeec.png)

## 2. 使用
ARM64バージョンを開くと、ファイルが破損しているという警告が表示されます。これは、Appleの開発者署名が必要だからです。作者はAppleの開発者証明書を持っていませんが、次のコマンドで問題を解決できます：
* MessAuto.appを/Applicationsフォルダーに移動します
* ターミナルでxattr -cr /Applications/MessAuto.appを実行します

これでアプリを使用できるようになります。

## 3. 使用法
プログラムが正常に動作するためには、iOSで「SMS転送」機能を有効にする必要があります。設定 > メッセージ > iMessage情報で確認できます。
![](https://img.music-poster.art/2025/05/20e37bdec4c71f08fe4605b2534b2113.jpeg)

MessAutoはGUIのないメニューバーソフトウェアです。最初に起動すると、MessAutoはユーザーに完全なディスクアクセス権の付与を促すポップアップウィンドウを表示します。権限を付与した後、システムはソフトウェアを再起動するよう要求します。メニューバーにはこのソフトウェアが表示されます。その機能は次のとおりです：
* 自動ペースト：MessAutoは検出された認証コードをクリップボードに保存します。認証コードを入力する際に手動でペーストしたくない場合は、このオプションを有効にします。このオプションを有効にすると、MessAutoは補助機能の権限を付与するように自動的に通知します。
* 自動エンター：認証コードを自動的にペーストした後、エンターキーを自動的に押します。
* クリップボードを占有しない：MessAutoは現在のクリップボードの内容に影響を与えず、ペースト後には以前のクリップボード内容（画像やテキスト）を自動的に復元します。そのため、この機能を有効にすると、自動ペースト機能も自動的に有効になります。
* 一時的に非表示：アイコンを一時的に隠し、アプリを再起動するとアイコンが再表示されます（バックグラウンドを終了する必要があります）。Macを頻繁に再起動しないユーザーに適しています。
* 永久に非表示：アイコンを永久に隠し、アプリを再起動してもアイコンは表示されません。Macを頻繁に再起動するユーザーに適しています。再表示する必要がある場合は、~/.config/messauto/messauto.jsonファイルを編集し、hide_foreverをfalseに設定し、アプリを再起動する必要があります。
* 設定：クリックするとJSON形式の設定ファイルが開き、キーワードをカスタマイズできます。
* ログ：ログを素早く開きます。
* メールを監視：有効にすると、メールも同時に監視され、メールアプリがバックグラウンドで常駐する必要があります。
* ポップアップウィンドウ：認証コード取得後、便利なポップアップウィンドウが表示されます。

ここで、**自動ペースト**と**ログイン時に起動**をオンにすることをお勧めします。著者は現時点でメール監視の必要がないため、メール監視をオンにしていません。必要であれば、有効にしてください。

# 参考文献
1. https://github.com/LeeeSe/MessAuto