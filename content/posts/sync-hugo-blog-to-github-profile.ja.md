---
title: "GitHubプロファイルにHugoブログを同期する方法"
date: 2025-06-21T22:00:00+08:00
draft: false
tags: ["Hugo", "GitHub", "ブログ同期", "GitHub Actions", "自動化"]
categories: ["技術", "ブログ構築"]
description: "gautamkrishnar/blog-post-workflowを使用して、GitHub Actionsを通じてHugoブログをGitHubプロファイルに自動同期する詳細なチュートリアル。設定手順と注意事項を含みます。"
---

## GitHubプロファイルにHugoブログを同期する方法

私たちのブログをデプロイした後、ブログが更新されるたびにGitHubプロファイルも自動的に更新されるようにしたいと思います。そうすることで、GitHubプロファイルは最新のブログ記事を表示できます。このことを実現するために、`GitHub Actions`を利用できます。

## 前提条件

始める前に、以下の準備作業を完了していることを確認してください：

- **Hugoブログ**：Hugoブログがセットアップされており、GitHubリポジトリにホストされています（例：`username/username.github.io`またはカスタムリポジトリ）。
- **GitHubリポジトリ**：ブログのソースファイルを保存するためのリポジトリ（例：`username/blog`）とGitHub Pages用のリポジトリ（例：`username/username.github.io`）を持っています。
- **GitHubプロファイルREADME**：GitHubでプロファイルREADMEが有効になっていること（ユーザー名と同名のリポジトリを作成：例：`username/username`、例えば [私のGitHubプロファイル](https://github.com/lxb1226/lxb1226)）。
- **基本的なGit知識**：コードのコミット方法、`.gitignore`の設定、GitHub Actionsの使用を理解しています。

## blog-post-workflowとは？

`blog-post-workflow`は、Gautam Krishnarによって開発されたGitHub Actionで、ブログの最新記事をGitHubプロファイルREADMEまたは他の指定された場所に同期するために特別に設計されています。さまざまなブログフレームワーク（Hugoを含む）をサポートしており、RSSフィードを解析して最新の記事を取得し、ターゲットファイルを自動的に更新します。

## ステップ1：Hugoブログリポジトリの設定

1. **HugoブログがRSSフィードを生成することを確認**：
   HugoはデフォルトでRSSフィードを生成します（通常は`public/index.xml`にあります）。Hugoの設定ファイル（`config.toml`または`config.yaml`）で、RSS出力が有効になっていることを確認してください：
   ```toml
   [outputs]
   home = ["HTML", "RSS"]
   ```
   `hugo`コマンドを実行した後、`public`ディレクトリに`index.xml`ファイルが存在するか確認します。

   ヒント：もしブログが多言語の場合、RSSフィードのアドレスは `https://your-blog-domain/index.xml` であり、`https://your-blog-domain/en/index.xml` または `https://your-blog-domain/zh/index.xml` ではありません。

2. **ブログコンテンツのホスティング**：
   - Hugoブログのソースファイルがリポジトリに保存されていることを確認します（例：`username/blog`）。
   - 静的ファイル（`public`ディレクトリ）はGitHub Pagesリポジトリにプッシュする必要があります（例：`username/username.github.io`）。
   - GitHub Pagesリポジトリの設定で、GitHub Pagesを有効にし、正しいブランチ（通常は`main`または`gh-pages`）を選択します。

3. **ブログへのアクセス確認**：
   カスタムドメイン（例：`https://username.github.io`）またはGitHub Pagesのデフォルトドメインを通じてブログにアクセスできることを確認します。

## ステップ2：GitHubプロファイルREADMEの設定

1. **プロファイルREADMEリポジトリを作成**：
   - GitHub上にあなたのユーザー名と同名のリポジトリを作成します（例：`username/username`）。
   - リポジトリのルートディレクトリに`README.md`ファイルを作成し、あなたのGitHubプロファイルコンテンツを表示します。

2. **ブログプレースホルダーを追加**：
   `README.md`にブログ記事を動的に挿入するためのプレースホルダーを追加します。例えば：
   ```markdown
   ## 私の最新のブログ記事
   <!-- BLOG-POST-LIST:START -->
   <!-- BLOG-POST-LIST:END -->
   ```

   `blog-post-workflow`はこのプレースホルダーを最新のブログ記事リンクに置き換えます。

## ステップ3：blog-post-workflowの設定

1. **GitHub Actionsワークフローを作成**：
   あなたのプロファイルREADMEリポジトリ（`username/username`）に以下のディレクトリ構造を作成します：
   ```
   .github/workflows/blog-post.yml
   ```

2. **ワークフローファイルを書く**：
   `blog-post.yml`に以下の内容を追加して、`blog-post-workflow`を設定します：
   ```yaml
   name: Sync Blog to Profile README

   on:
     schedule:
       - cron: "0 0 * * *" # 毎日1回実行
     workflow_dispatch: # 手動トリガーを許可

   jobs:
     update-readme-with-blog:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: gautamkrishnar/blog-post-workflow@v1
           with:
             feed_list: "https://username.github.io/index.xml" # あなたのブログRSSアドレスに置き換え
             max_post_count: 5 # 最近の5記事を同期
             readme_path: ./README.md # ターゲットREADMEファイル
             commit_message: "最新のブログ記事でREADMEを更新"
   ```
   - **feed_list**：HugoブログのRSSフィードアドレス（通常は `https://your-blog-domain/index.xml`）に置き換えます。
   - **max_post_count**：表示する最新記事数を設定します。
   - **readme_path**：正しいREADMEファイルパスを指していることを確認します。
   - **commit_message**：コミットメッセージをカスタマイズします。

3. **ワークフローファイルをコミット**：
   `blog-post.yml`をあなたのプロファイルREADMEリポジトリにコミットします。GitHub Actionsは毎日真夜中（UTC）に自動で実行されます。または、GitHubのActionsパネルから手動でトリガーできます。

## ステップ4：同期結果の確認

1. **GitHub Actionsログを確認**：
   - プロファイルREADMEリポジトリのActionsタブに移動し、`Sync Blog to Profile README`ワークフローの実行状況を確認します。
   - エラーがなく、ワークフローが成功したことを確認してください。
![](https://img.music-poster.art/2025/06/133d3d31fe568cbba71be00326fe6420.png)
   - また、手動でワークフローをトリガーして、READMEが更新されたかどうかを確認できます。`Run workflow`をクリックすると手動トリガーできます。
   ![](https://img.music-poster.art/2025/06/bd7d8b28b5a2538881cfd90a878dcd8e.png)

2. **README更新の確認**：
   - `username/username`リポジトリの`README.md`を開き、`<!-- blog-post-workflow -->`プレースホルダーが最新のブログ記事リストに置き換えられているか確認します。
   - 出力例は以下のようになる可能性があります：
     ```markdown
     ## 私の最新のブログ記事
     - [記事タイトル1](https://username.github.io/post/xxx) - 2025-06-21
     - [記事タイトル2](https://username.github.io/post/yyy) - 2025-06-20
     ```

3. **GitHubプロファイルにアクセス**：
   あなたのGitHubホームページ（`https://github.com/username`）を開き、最新のブログ記事がプロファイルREADMEに表示されていることを確認します。
   ![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

## 注意事項

- **RSSフィードの可用性**：あなたのブログRSSフィード（`index.xml`）が公共のURLからアクセスできることを確認してください。ブログがプライベートリポジトリにホストされている場合は、公共リポジトリに変更するか、他の方法でRSSを提供する必要があります。
- **GitHub Actionsの権限**：リポジトリがActionsの書き込み権限を有効にしていることを確認してください（Settings > Actions > General > Allow all actions and reusable workflows）。
- **同期頻度**：デフォルトの設定は毎日1回同期しますが、必要に応じて`cron`式を調整できます（例えば、毎時：`0 * * * *`）。
- **デバッグ**：同期が失敗した場合は、Actionsログを確認してください。一般的な問題は、RSSアドレスが間違っているか、READMEファイルのパスが不正であることです。

---

**参考リソース**：
- [gautamkrishnar/blog-post-workflow](https://github.com/gautamkrishnar/blog-post-workflow)
- [Hugo公式ドキュメント](https://gohugo.io/documentation/)
- [GitHub Actionsドキュメント](https://docs.github.com/en/actions)