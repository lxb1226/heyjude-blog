---
title: Hugoを使用してブログを構築し、Cloudflare Pagesにデプロイする
date: 2025-06-16T20:29:00+08:00
tags: [Hugo, Cloudflare, ブログ, 静的サイト, デプロイ]
categories: [技術チュートリアル]
description: 本記事では、Hugo静的サイトジェネレーターを使用してブログを作成し、Cloudflare Pagesを通じてデプロイする方法を詳しく説明します。環境設定、テーマのインストール、コンテンツの作成、ドメインのバインディングなどの完全な手順を含みます。
slug: deploy-hugo-to-cloudflare
---

# Hugoを使用してブログを構築し、Cloudflare Pagesにデプロイする

この記事では、[Hugo](https://gohugo.io/)を使用して個人ブログを構築し、[Cloudflare Pages](https://pages.cloudflare.com/)にデプロイするプロセスをステップバイステップで説明します。Hugoは高速で柔軟な静的サイトジェネレーターであり、Cloudflare Pagesは静的サイトのホスティングサービスを無料で提供します。グローバルCDNの加速により、あなたのブログは迅速に公開され、優れたアクセス体験を提供します。技術初心者でも一定の経験を持つ開発者でも、このチュートリアルは自分だけのブログを素早く立ち上げる手助けをします。

## なぜHugoとCloudflare Pagesを選ぶのか？

- **Hugo**：Go言語で書かれており、生成速度が非常に速く、豊富なテーマとMarkdown形式をサポートしているため、ブログやドキュメントサイトに適しています。
- **Cloudflare Pages**：シームレスなGitHub統合、自動デプロイ、無料のSSL証明書、グローバルCDN加速を提供し、国内のアクセス速度はGitHub Pagesよりも優れています。
- **コスト**：両者を組み合わせると完全に無料であり、個人ブログや小規模プロジェクトに適しています。

## 準備作業

始める前に、以下のツールとアカウントを準備する必要があります：

1. **Hugo**：最新のHugoをインストールします（より多くの機能をサポートする拡張版の使用を推奨します）。
2. **Git**：バージョン管理とコードをGitHubにプッシュするため。
3. **GitHubアカウント**：ブログのソースコードを保存するため。
4. **Cloudflareアカウント**：ブログをデプロイし、ホスティングするため。
5. **テキストエディタ**：VSCodeなど、Markdownファイルや設定ファイルの編集に使用します。

## ステップ1：Hugoのインストール

### Windows
1. Chocolateyパッケージマネージャーをインストールします（未インストールの場合）：
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
2. Chocolateyを使用してHugoの拡張版をインストールします：
   ```powershell
   choco install hugo-extended
   ```
3. インストールを確認します：
   ```powershell
   hugo version
   ```

### macOS
1. Homebrewを使用してインストールします：
   ```bash
   brew install hugo
   ```
2. インストールを確認します：
   ```bash
   hugo version
   ```

その他のインストール方法については、[Hugo公式ドキュメント](https://gohugo.io/getting-started/installing/)を参照してください。

## ステップ2：Hugoサイトの作成

1. ターミナルで新しいサイトを作成します：
   ```bash
   hugo new site my-blog
   cd my-blog
   ```
   これにより、`my-blog`フォルダー内にHugoサイトのディレクトリ構造が生成されます：
   ```
   ├── archetypes
   ├── content
   ├── data
   ├── layouts
   ├── public
   ├── static
   ├── themes
   └── hugo.toml
   ```

2. Gitリポジトリを初期化します：
   ```bash
   git init
   ```

3. 生成されたファイルを無視するために`.gitignore`ファイルを追加します：
   ```bash
   echo "public/" >> .gitignore
   echo "resources/" >> .gitignore
   ```

## ステップ3：テーマのインストールと設定

1. Hugoテーマを選択します。例えば[hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack)：
   ```bash
   git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
   ```

2. テーマのサンプル設定ファイルをプロジェクトのルートディレクトリにコピーします：
   ```bash
   cp themes/hugo-theme-stack/exampleSite/config.yaml .
   ```

3. `config.yaml`（または`hugo.toml`）を編集し、基本情報を設定します：
   ```yaml
   baseURL: "https://your-domain.com/"  # あなたのドメインに置き換えてください
   languageCode: "ja"
   title: "私のブログ"
   theme: "hugo-theme-stack"
   DefaultContentLanguage: "ja"
   hasCJKLanguage: true
   paginate: 5
   ```

テーマの公式ドキュメントを参照して、より多くの設定を確認できます。

## ステップ4：最初のブログ記事を作成する

1. 新しい記事を作成します：
   ```bash
   hugo new posts/my-first-post.md
   ```
   これにより、`content/posts/`ディレクトリに`my-first-post.md`ファイルが生成されます。

2. 記事の内容を編集し、Front Matter（記事のメタデータ）を変更します：
   ```markdown
   ---
   title: "私の最初のブログ"
   date: 2025-06-16T20:29:00+08:00
   draft: false
   ---
   Hugoブログを体験してみてください！これは私の最初の記事です。
   ```

3. Hugoのローカルサーバーを起動してプレビューします：
   ```bash
   hugo server -D
   ```
   ブラウザを開いて`http://localhost:1313/`にアクセスすると、ブログのローカルプレビューを見ることができます。

## ステップ5：コードをGitHubにプッシュする

1. GitHubで新しいリポジトリ（例えば`my-blog`）を作成します。公開またはプライベートを選択できます。
2. ローカルコードをGitHubにプッシュします：
   ```bash
   git add .
   git commit -m "初回コミット"
   git remote add origin https://github.com/your-username/my-blog.git
   git branch -M main
   git push -u origin main
   ```

## ステップ6：Cloudflare Pagesにデプロイする

1. [Cloudflare Dashboard](https://dash.cloudflare.com/)にログインし、「Workers & Pages」>「Pages」>「プロジェクトを作成」を選択します。
![](https://img.music-poster.art/2025/06/460d03da3f5f0c737c60951d16dd12b4.png)
2. GitHubアカウントを接続し、先ほど作成した`my-blog`リポジトリを選択します。
![](https://img.music-poster.art/2025/06/5577398c00ea3e040f927f4272d7d5c9.png)
3. ビルド設定を構成します：
   - **プロジェクト名**：任意の名前（例：`my-blog`）、`my-blog.pages.dev`というサブドメインが割り当てられます。
   - **プロダクションブランチ**：デフォルトの`main`です。
   - **ビルドコマンド**：`hugo --gc --minify`（出力ファイルを最適化します）。
   - **出力ディレクトリ**：`public`。
   - **環境変数**：Hugoのバージョンを指定するために`HUGO_VERSION`（例：`0.125.4`）を追加します。最新バージョンの使用を推奨します。詳細は[Hugo Releases](https://github.com/gohugoio/hugo/releases)を確認してください。
   ![](https://img.music-poster.art/2025/06/4ce72f3294fdc3f92e2a504e70a11b5a.png)
4. 「保存してデプロイ」をクリックすると、Cloudflare Pagesはコードを自動的に引っ張り、ビルドしてデプロイします。デプロイが完了した後、`my-blog.pages.dev`でブログにアクセスできます。
![](https://img.music-poster.art/2025/06/50fc6325948a3ddc3aa9a424b56a6f65.png)

## ステップ7：カスタムドメインのバインディング

1. ドメインがCloudflareにホスティングされていることを確認します（Cloudflareで購入するか、他のレジストラから移行できます）。
2. Cloudflare Pagesプロジェクトの中で、「カスタムドメイン」>「カスタムドメインの設定」をクリックします。
3. あなたのドメイン（例：`your-domain.com`）を入力し、CloudflareがCNAMEレコードを自動的に追加します。
4. DNS解決が有効になるのを待ちます（通常数分から数時間）と、カスタムドメインでブログにアクセスできるようになります。

## ステップ8：自動デプロイ

ブログの内容を更新するたびに（新しい記事を追加したり、設定を変更したりする場合）、次のコマンドを実行してコードをプッシュします：
```bash
git add .
git commit -m "ブログコンテンツを更新"
git push origin main
```
Cloudflare PagesはGitHubリポジトリの更新を自動的に検出し、再ビルドしてデプロイします。通常1〜2分以内に完了します。

## 発生した問題と解決方法

1. **Hugoのバージョン不一致**：Cloudflare Pagesはデフォルトで古いHugoバージョンを使用することがあり、ビルドに失敗する場合があります。解決策として、環境変数に最新バージョンを指定します（例：`HUGO_VERSION=0.125.4`）。
2. **記事が表示されない**：記事の`draft: false`が正しく設定されているか確認します。Hugoはデフォルトで`draft: true`の記事を描画しません。
3. **国内でのアクセス速度が遅い**：ドメインがCloudflareのCDNによって加速されており、SSLが有効になっていることを確認します。

## まとめ

HugoとCloudflare Pagesを使用することで、高性能で無料の個人ブログを迅速に構築することができます。Hugoは柔軟なコンテンツ管理と豊富なテーマサポートを提供し、Cloudflare Pagesの自動デプロイとグローバルCDN加速により、ブログの公開とアクセスがより効率的になります。

## 参考
- [Hugo公式ドキュメント](https://gohugo.io/documentation/)
- [Cloudflare Pages公式ドキュメント](https://developers.cloudflare.com/pages/)
