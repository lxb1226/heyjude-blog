---
title: "10分であなたのブログサイトをGitHub Pagesにデプロイする"
subtitle: "GitHub Pagesを使用してあなたのHugoブログを無料でホスティング"
date: 2025-05-18T17:01:07+08:00
lastmod: 2025-05-18T17:01:07+08:00
draft: false
authors: ["heyjude"]
description: "HugoブログをGitHub Pagesにデプロイする方法についての詳細なガイド、リポジトリの作成、GitHub Actionsの設定、自動デプロイプロセスなどの内容を含み、あなたがコストゼロでプロフェッショナルな個人ブログサイトを構築するのを助けます。"

tags: ["hugo", "github pages", "自動デプロイ", "静的サイト", "CI/CD"]
categories: ["ブログ構築", "技術チュートリアル", "自動デプロイ"]
series: ["ブログチュートリアル"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

ローカルでブログサイトを構築した後、次のステップはブログの内容をネット上に配信することです。そうすれば、他の人も見ることができます。

現在のホスティングサイトを調査したところ、以下の選択肢があります：

- **GitHub Pages**：GitHubが提供する無料の静的サイトホスティングサービスで、コードリポジトリと統合するのに適しています。
- **Netlify**：自動ビルドとデプロイをサポートし、無料プランは機能が豊富で、Hugoに対するサポートが非常に良いです。
- **Vercel**：Next.jsチームが開発したもので、デプロイ速度が速く、フロントエンドプロジェクトに適しています。
- **Cloudflare Pages**：Cloudflareが提供する静的サイトホスティングサービスで、CDNとセキュリティ加速を内蔵しています。
- **Firebase Hosting**：Googleが提供するフロントエンドホスティングプラットフォームで、フロントエンドアプリケーションと連携して使用するのに適しています。
- **Amazon S3 + CloudFront**：高性能なホスティングと配信ソリューションで、プロフェッショナルなデプロイに適しています。
- **GitLab Pages**：GitLabが提供する静的サイトホスティングサービスで、CIを通じて自動ビルドを構成することができます。
- **Render**：シンプルなフルスタックホスティングプラットフォームで、Hugoサイトの自動デプロイをサポートしています。
- **Surge.sh**：極簡スタイルの静的サイトホスティングツールで、コマンドラインからのデプロイが簡単で迅速です。
- **DigitalOcean App Platform**：クラウドサービスプラットフォームで、静的サイトとバックエンドサービスの自動デプロイをサポートしています。

これらのプラットフォームはそれぞれの特徴を持っています。次の記事でそれぞれのデプロイ方法を一つずつ紹介します。本記事では、ブログサイトをGitHub Pagesにデプロイする方法を紹介します。

## GitHub Pagesとは
GitHub Pagesは、GitHubが提供する無料の静的ウェブサイトホスティングサービスで、ブログやプロジェクトのホームページ、ドキュメントなどのホスティングに適しています。あなたは単一のGitHubリポジトリを持っているだけで、ウェブサイトを https://yourname.github.io またはカスタムドメイン上に公開することができます。

##ブログサイトをGitHub Pagesにデプロイする方法
### 全体的な考え方
* あなたの主リポジトリ（例： my-hugo-site）にはHugoのソースコード（content/、layouts/ など）が含まれています。
* ビルドされた静的ファイル（public/）は別のリポジトリ（yourusername.github.io）にプッシュされます。
* yourusername.github.ioリポジトリは、生成された静的ウェブサイトをホストするために特別に用意されています。

### プロジェクト構造
2つのGitHubリポジトリがあると仮定します：
* my-hugo-site（ソースリポジトリ）：Hugoのソースコードと記事を保存します。
* yourusername.github.io（デプロイリポジトリ）：ビルドされた静的ファイルを保存します。

プロジェクト構造は以下の通りです：
```
my-hugo-site/
├── content/            # ブログコンテンツ
├── layouts/            # Hugoのカスタムレイアウト
├── themes/             # Hugoのテーマ
├── config.toml        # Hugoの設定ファイル
└── .github/workflows/deploy.yml  # 自動デプロイの設定

yourusername.github.io/
├── (公開された静的サイトファイル)   # 静的ファイルはHugoがビルドした後に生成されます
```
### ステップ1：2つのリポジトリを作成する
1. GitHubで2つのリポジトリを作成します：
  * my-hugo-site：Hugoのソースコードを保存するためのもの。
  * yourusername.github.io：ビルドされた静的ファイルを保存するためのもの。

2. yourusername.github.ioリポジトリで、GitHub Pagesのソースブランチをmain（またはmaster）に設定します。

### ステップ2：GitHub Actionsを使った自動デプロイの設定
my-hugo-siteリポジトリで、.github/workflows/deploy.ymlファイルを作成し、自動ビルドと静的ファイルのyourusername.github.ioリポジトリへのプッシュを設定します。
```yaml
name: GitHub Pages

on:
  push:
    branches:
      - main  # ブログのルートディレクトリのデフォルトブランチ、ここではmain、または時にはmaster
  pull_request:

jobs:
  deploy:
    runs-on: ubuntu-24.04
    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.147.0'  # 使用しているhugoバージョンを記入。hugo versionで確認できます
          extended: true          # 使用しているのが非拡張バージョンのhugoであれば、trueをfalseに変更

      - name: Build
        run: git submodule update --init --recursive && hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: ${{ github.ref == 'refs/heads/main' }}  # mainまたはmasterを正しく記入してください
        with:
          personal_token: ${{ secrets.MY_PAT}} # secretが他の名前に設定されている場合は、MY_PATを変更してください
          external_repository: lxb1226/lxb1226.github.io # リモートリポジトリを記入、必ずこの形式である必要はなく、自分の状況に合わせて変更
          publish_dir: ./public
          #cname: www.example.com        # あなたのカスタムドメインを記入します。カスタムドメインを使用していない場合は、この行をコメントアウトしてください
```
私の[depoly.yaml](https://github.com/lxb1226/heyjude-blog/blob/main/.github/workflows/deploy.yaml)を参考にできます。

### GitHub secretsの取得
上記のyamlファイルで`personal_token`を取得する必要があります。my-hugo-siteリポジトリで取得できます。

リポジトリ -> Settings -> Secrets and variables -> Actionsから取得できます。
![personal_token](https://img.music-poster.art/2025/05/5331092ac30840b1bc967395cce01709.png)


### ステップ3：GitHub Pagesの設定
1. yourusername.github.ioリポジトリで、Settings → Pagesに入ります。
2. Sourceをmainブランチに設定し、GitHub Pagesの設定が正しいことを確認します。
3. 保存すると、静的ウェブサイトは https://yourusername.github.io/ でホスティングされます。
![](https://img.music-poster.art/2025/05/9052201a8331d0e293e23b1741d0fc80.png)

## ブログの自動公開プロセス
1. my-hugo-siteリポジトリで記事を書いたり、サイトを修正したりします。
2. mainブランチに更新をプッシュするたびに、GitHub Actionsは自動的にビルドし、静的ファイルをyourusername.github.ioリポジトリにプッシュします。
3. GitHub Pagesは自動的に更新され、 https://yourusername.github.io/ に表示されます。（一般的にしばらく時間がかかります）


## 参考
1. https://docs.github.com/en/actions
2. https://gohugo.io/documentation/
3. https://lxb1226.github.io/
4. https://github.com/lxb1226/heyjude-blog