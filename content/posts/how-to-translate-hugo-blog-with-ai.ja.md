---
title: "AIを使ってHugoブログを自動翻訳する方法"
subtitle: "OpenAIを利用してブログの多言語サポートを実現"
date: 2024-01-20T10:00:00+08:00
lastmod: 2024-01-20T10:00:00+08:00
draft: false
authors: ["heyjude"] 
description: "この記事では、AIツールを使ってHugoブログを自動で多言語に翻訳し、ブログの国際化を実現する方法をご紹介します。"

tags: ["Hugo", "ブログ", "AI", "OpenAI", "自動化", "国際化", "i18n"]
categories: ["チュートリアル"]

featuredImage: ""
featuredImagePreview: ""

hiddenFromHomePage: false
hiddenFromSearch: false
twemoji: false
lightgallery: true
ruby: true
fraction: true
fontawesome: true
linkToMarkdown: true
rssFullText: false

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
share:
  enable: true
comment:
  enable: true
---

## 前書き

自分のブログを作成した際には、多言語をサポートしたいと思います。これは、読者を広げるだけでなく、ブログのSEOパフォーマンスを向上させることにも繋がります。しかし、ブログ記事の手動翻訳は時間と労力がかかり、専門の翻訳者が必要です。しかし、AIの進化により、今ではAIを使って簡単にブログをお好きな言語に翻訳できるようになりました。そのために、AIを活用してブログ記事を自動的に翻訳するツールを作成しました。これを使用すれば、多言語を簡単にサポートできます。

このツールは、[hugo-translator](https://github.com/lxb1226/hugo-translator) から入手できます。

## 準備事項

始める前に、次のものを用意してください：

1. 作動中のHugoブログ
2. Node.jsとnpm環境
3. OpenAI APIキー（AI翻訳用）
4. 基本的なコマンドライン操作の知識

## 実装手順

### 1. ツールを取得する

```bash
git clone https://github.com/lxb1226/hugo-translator.git
cd hugo-translator
```

### 2. AI翻訳ツールをインストールする

Markdownファイルを翻訳するために`ai-markdown-translator`というツールを使用します。まず、グローバルにインストールします：

```bash
npm install -g ai-markdown-translator
```

### 3. 環境変数を設定する

OpenAI APIキーを設定します：

```bash
export OPENAI_API_KEY='your-api-key'
```
OpenAI APIキーを持っていない場合は、サードパーティのAPIを使用することもできます。この[リンク](https://aihubmix.com?aff=jqnC)からサードパーティのAPIキーを購入できます。
その後、次のように設定できます：
```bash
export OPENAI_URL='your api url'
export API_KEY='your-api-key'
```

この設定を`.bashrc`や`.zshrc`ファイルに追加して恒久的に有効にすることもできます。

### 4. 翻訳スクリプトを作成する

`translate-posts.sh`という名前のスクリプトファイルを作成し、自動翻訳プロセスを実行します。このスクリプトは以下を行います：

- ブログ記事を自動検出
- 多言語翻訳をサポート
- 既に翻訳された記事をスキップ
- 詳細な翻訳進捗と統計情報を提供

主な機能は次の通りです：

1. **多言語サポート**：デフォルトで英語、日本語、韓国語など多くの言語をサポート
2. **インテリジェント検出**：ソース言語とターゲット言語を自動識別
3. **インクリメンタル更新**：新規または変更された内容のみを翻訳
4. **エラーハンドリング**：完全なエラーハンドリングとログ記録
5. **進捗表示**：リアルタイムで翻訳進捗と状態を表示

### 5. 使用方法

基本的な使用法：

```bash
./translate-posts.sh
```

ターゲット言語をカスタマイズ：

```bash
TARGET_LANGS="en ja ko" ./translate-posts.sh
```
![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

### 6. ファイル命名規則

翻訳されたファイルは、Hugoの国際化命名規則に従って自動的に命名されます：

- 英語版：`post-name.en.md`
- 日本語版：`post-name.ja.md`
- 韓国語版：`post-name.ko.md`

## 参考資料

- [Hugo多言語サポート公式ドキュメント](https://gohugo.io/content-management/multilingual/)
- [OpenAI APIドキュメント](https://platform.openai.com/docs/api-reference)
- [ai-markdown-translator使用ガイド](https://github.com/h7ml/ai-markdown-translator)
- [hugo-translator](https://github.com/lxb1226/hugo-translator)