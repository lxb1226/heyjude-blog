---
title: "HugoブログにGiscusコメントシステムを統合する"
date: 2025-06-15
slug: "giscus-comments-hugo"
tags: ["Hugo", "コメントシステム", "Giscus", "ブログ構築", "GitHub Discussions", "静的ブログ", "ブログインタラクション", "オープンソースコメントシステム", "ゼロコストデプロイ"]
keywords: ["Giscusコメントシステム", "Hugoブログコメント", "GitHub Discussionsコメント", "静的ブログコメントソリューション", "オープンソースコメントツール", "ブログインタラクションシステム", "無料コメントシステム", "Hugoテーマカスタマイズ", "ブログ機能拡張"]
description: "この記事では、GitHub Discussionsに基づく現代的なコメントソリューションであるGiscusコメントシステムをHugoブログに統合する方法について詳しく説明します。このチュートリアルを通じて、Markdownをサポートし、ダークモードや多言語インターフェースを備えた、安全で信頼性の高いコメントシステムをゼロコストで構築する方法を学ぶことができます。データベースは不要で、すべてのコメントデータはGitHubに保存され、データの安全性と持続可能性が確保されています。"
---

これは自分のブログシステムを構築するための第三回目のチュートリアルで、ブログにコメントシステムを追加します。

ブログを構築する過程で、良いコメントシステムはインタラクションを大幅に向上させることができます。今日は、GitHub Discussionsに基づくオープンソースコメントシステムである[Giscus](https://giscus.app/)をHugoブログに統合する方法を紹介します。

## なぜGiscusを選ぶのか？

- 🚀 サーバー不要、GitHub Discussionsに基づく
- 🔒 安全かつ信頼性が高い、コメントデータはGitHub上に保存
- 🧩 ダークモードと適応型テーマをサポート
- 💬 匿名コメント（オプション）をサポート
- 🌍 多言語インターフェースのサポート

## 準備

始める前に、以下が必要です：

1. GitHubでホスティングされているリポジトリ
2. Discussions機能が有効化されている
3. Hugoブログ（任意のテーマで構いません）

## ステップ1：GitHub Discussionsを有効化する

1. あなたのブログコードリポジトリを開きます（例：`username/blog`）。
2. **Settings** → **Features** をクリックし、**Discussions** にチェックを入れます。
![](https://img.music-poster.art/2025/06/8c0271325d91ad29527d1acef14fd869.png)
## ステップ2：Giscusを設定する

[https://giscus.app](https://giscus.app)に移動し、ページ内で：

1. あなたのGitHubリポジトリを選択します。
2. コメントをどのDiscussionカテゴリーに作成するか設定します（新しく`announcement`などを作成できます）。
3. カスタム設定：
   - Mapping：`pathname`を選択することをお勧めします。つまり、ページパスに関連付けられた議論です。
   - Reaction：いいねなどの操作を許可するかどうか。
   - テーマ：`light`, `dark`, `preferred_color_scheme`などをサポート。
4. 生成された`<script>`コードをコピーします。
![](https://img.music-poster.art/2025/06/116ebde5a465cfbea4f3c5b84192be3d.png)
生成されたコードの例は以下の通りです：

```html
<script src="https://giscus.app/client.js"
        data-repo="yourname/yourrepo"
        data-repo-id="REPO_ID"
        data-category="General"
        data-category-id="CATEGORY_ID"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="ja"
        crossorigin="anonymous"
        async>
</script>
```

ここで`data-repo`、`data-repo-id`、`data-category-id`の3つのパラメータを記憶しておく必要があります。後の設定で使用します。

## ステップ3：giscusをあなたのhugoテーマに統合する
私が使用しているテーマは[hugo-narrow](https://github.com/tom2almighty/hugo-narrow)で、giscusコメントシステムが統合されていますので、ちょっと設定するだけで済みます。以下が私の設定です：

```yaml
  comments:
    enabled: true
    # giscus, disqus, utterances, waline, artalk, twikoo
    system: "giscus"

    giscus:
      repo: "data-repo"
      repoId: "data-repo-id"
      category: "Announcements"
      categoryId: "data-category-id"
      mapping: "pathname"
      strict: "0"
      reactionsEnabled: "1"
      emitMetadata: "0"
      inputPosition: "bottom"
      theme: "preferred_color_scheme"
      lang: "ja"
```
ここでは、`repo`、`repoId`、`categoryId`をステップ2で保存した値に置き換えることを忘れないでください。そうしないと、コメントが正常に表示されません。また、`enable`を`true`に、`system`を`giscus`に設定する必要があります。そうしないとコメントは表示されません。

最終的に、記事の下部にこのようなインターフェースが表示されます：
![](https://img.music-poster.art/2025/06/2e3b16e884ac6d67db1651a8d44197db.png)

## テスト

この記事の下にコメントを書いて、コメントが正常に表示されるか確認できます。コメント後のコメントはGitHubのDiscussionで確認できます。

例えば、[こちら](https://github.com/lxb1226/lxb1226.github.io/discussions)で私のブログのコメントを見ることができます。

![](https://img.music-poster.art/2025/06/fdc145c668e761fb68870ce841967e08.png)