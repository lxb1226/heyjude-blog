---
title: "10分で自分のブログサイトを構築する"
date: 2025-05-05T20:28:24+08:00
lastmod: 2025-05-05T20:28:24+08:00
draft: false
keywords: ["hugo", "ブログ構築", "個人サイト", "静的サイトジェネレーター", "ブログテーマ", "サイト開発"]
description: "Hugo静的サイトジェネレーターを使用して、個人ブログサイトを迅速に構築するための詳細なチュートリアルです。Hugoのインストール、テーマの選択、基本設定、コンテンツ管理などのステップを含み、10分以内でプロフェッショナルな個人ブログを持つことができます。"
tags: ["hugo", "ブログ構築", "静的サイト", "個人サイト", "技術チュートリアル"]
categories: ["ブログ構築", "技術チュートリアル"]
series: ["ブログチュートリアル"]
author: "heyjude"

# コンテンツのために何かを閉じたり(true)開いたり(false)できます。
# P.S. コメントは閉じることができます
comment: true
toc: true
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# 別のコンテンツ著作権を定義することもできます。例：contentCopyright: "これは別の著作権です。"
contentCopyright: false
reward: true
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# ヘッダーやフッターを表示しない投稿
hideHeaderAndFooter: false

# 個々の投稿に対して期限切れコンテンツ警告を有効または無効にできます。
# グローバル設定を使用するにはこれをコメントアウトしてください。
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""

---
## hugoとは

Hugoは最も人気のあるオープンソースの静的サイトジェネレーターの一つです。ユーザーはHugoを使用して自分のサイトを迅速に構築できます。

## 構築手順

### hugoのインストール
Macでは、以下のコマンドを使用してhugoをインストールできます：
```bash
brew install hugo
```
![install](https://img.music-poster.art/2025/05/c9d27037a7d215ff8eaa14383cba62b6.png)

インストール後、`hugo version`を使用して正しくインストールされたか確認できます：
![hugo_version](https://img.music-poster.art/2025/05/9368e5db6f1f18f70eba3017c7144a9b.png)

### hugoを使ってブログサイトを作成
hugoをインストールした後、hugoを使用して自分のブログサイトを構築できます。
`hugo new site my-blog`を使用して、my-blogという名前のサイトを作成します。
![new-blog-site](https://img.music-poster.art/2025/05/c31b6d2f942a44af304823b9b2d40e76.png)
このコマンドを実行すると、現在のディレクトリにmy-blogというディレクトリが作成されます。
その後、そのディレクトリに移動し、gitで初期化します。
```bash
cd my-blog
git init
```

### テーマを選択
サイトを作成した後、テーマを選択する必要があります。ここには多くのテーマが用意されています：[hugo themes](https://themes.gohugo.io/)
ここでは、hugo-theme-evenというテーマを選択しました。このテーマをsubmoduleとしてthemes/evenの下に置く必要があります。
```bash
git submodule add https://github.com/olOwOlo/hugo-theme-even.git themes/even
```
![pick-theme](https://img.music-poster.art/2025/05/10d92ec7695324dd4db2cb0772f764f8.png)
その後、`themes/even/exampleSite/config.toml`を現在のディレクトリにコピーし、`hugo.toml`を上書きします。
```bash
cp themes/even/exampleSite/config.toml hugo.toml
```

### ブログを作成
テーマの設定が完了したら、自分のブログを作成できます。
`hugo new content content/post/my-first-post.md`を使用してブログを作成します。
このコマンドを実行後、`content/post/`の下に新しいmdファイルが生成されます。
![my-first-blog](https://img.music-poster.art/2025/05/b6760e2f47eed1c8a962e475f69adc92.png)


### hugoを実行
各種設定が完了したら、`hugo server`を使ってhugoサーバーを起動できます。
![](https://img.music-poster.art/2025/05/69da7f70c3795f266a83207d186d0ad4.png)
リンクをクリックすれば、ブログサイトのアドレスにアクセスできます。
![](https://img.music-poster.art/2025/05/10ebbce59ca6637b1b44c8d884c471bd.png)
この時、以前作成したブログが表示されないことに気づくかもしれません。その理由は、最初に作成したブログは`draft`として設定されているため、`hugo server`モードではドラフトのブログが表示されません。
表示する必要がある場合は、`hugo server -D`を使用する必要があります。
![](https://img.music-poster.art/2025/05/72c092d59ad8143fa61188eac94ace32.png)

以上でブログサイトの構築が完了です。

### GitHubにローカルブログを保存
* GitHubにログインして、新しいリポジトリを作成します（例：heyjude-blog）
* ローカルリポジトリをリモートとして追加します：
```
git remote add origin https://github.com/yourusername/myblog.git
git push
```
これでブログをGitHubに保存できます。

# 参考リンク
1. https://gohugo.io/getting-started/quick-start/
2. https://github.com/olOwOlo/hugo-theme-even
3. https://medium.com/@magstherdev/hugo-in-10-minutes-2dc4ac70ee11
