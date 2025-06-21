---
title: VercelでUmamiをデプロイしてウェブサイトのトラフィック分析を簡単に実現
date: 2025-06-15
tags: [Umami, Vercel, Neon, ウェブサイトトラフィック統計, オープンソース, Hugo, ウェブサイト分析, データ統計, 訪問者統計, Google Analyticsの代替, PostgreSQL, ゼロコストデプロイ]
categories: [技術チュートリアル]
keywords: [Umamiデプロイチュートリアル, Vercel無料デプロイ, Neonデータベース, ウェブサイトトラフィック分析, Google Analyticsの代替案, オープンソース統計ツール, Hugoブログ統計, ゼロコストウェブサイト構築, ウェブサイト訪問数統計, データプライバシー保護]
description: この記事では、Umamiデプロイに関する詳細なガイドを提供し、Vercelの無料サービスとNeon PostgreSQLデータベースを利用して、プライバシー重視のウェブサイトトラフィック統計システムを迅速に構築する方法を教えます。このゼロコストソリューションは、個人ブログや中小規模のウェブサイトに特に適しており、Google Analyticsよりも軽量でプライバシーを重視した統計サービスを提供します。Vercelのサーバーレスアーキテクチャを使用することで、ウェブサイトのトラフィック監視を簡単に実現でき、Hugoなどの静的ウェブサイトとも完全に互換性があります。
---

Umamiは、Google Analyticsの理想的な代替品であるシンプルで高速、プライバシー重視のオープンソースウェブサイト統計ツールです。この記事では、VercelでUmamiをデプロイし、Vercel Storageを通じてNeon PostgreSQLデータベースを作成して、ゼロコストで軽量なウェブサイトトラフィック統計システムを構築する方法を指示します。このチュートリアルは、特にHugo静的ウェブサイトユーザー向けに最適化されており、生成されるMarkdownファイルがHugoの静的ウェブページ生成に適合するように保証されています。

## 前書き

個人ブログや中小規模のウェブサイトの場合、Google Analyticsは複雑すぎることがあり、特に特定の地域ではアクセスしにくいことがあります。Umamiはシンプルなインターフェースとコア指標を提供しており、軽量なトラフィック分析のニーズに非常に適しています。VercelのサーバーレスデプロイとVercel Storage統合のNeonデータベースを使用することで、高効率な統計システムを迅速に構築し、サーバー維持コストを不要にできます。

以下は、詳細なデプロイ手順です。

## 準備作業

開始する前に、以下の内容を用意しておいてください：

1. **GitHubアカウント**：Umamiリポジトリをフォークするため。
2. **Vercelアカウント**：Umamiをデプロイし、Neonデータベースを作成するため。
3. **Neonアカウント**：Vercel Storageを通じて接続するために登録済み。
4. Umamiのトラッキングコードを埋め込むための、稼働中のHugoサイト（または他の静的ウェブサイト）。

## ステップ 1：Umamiリポジトリをフォーク

1. Umami公式GitHubリポジトリにアクセス：[https://github.com/umami-software/umami](https://github.com/umami-software/umami)。
2. 右上の **Fork** ボタンをクリックし、リポジトリをあなたのGitHubアカウントにフォークします。
3. （オプション）Umamiをカスタマイズする必要がある場合は、リポジトリをローカルにクローンして修正できますが、本チュートリアルではデフォルト設定を使用します。

## ステップ 2：VercelでUmamiをデプロイ

1. [Vercel公式サイト](https://vercel.com/)にログインし、**Add New** > **Project**をクリックします。
2. **Import Git Repository**ページで、先ほどフォークしたUmamiリポジトリを選択します。
3. プロジェクトを設定します：
   - **Framework Preset**：**Next.js**を選択します（UmamiはNext.jsを基に構築されています）。
   - **Environment Variables**：一時的にスキップし、後でNeonデータベースの`DATABASE_URL`を設定します。
4. **Deploy**ボタンをクリックすると、Vercelは自動的にプロジェクトをビルドします（この時点でデータベース接続が不足しているために失敗することがありますが、後で修正します）。

## ステップ 3：Vercel StorageでNeonデータベースを作成

1. Vercelダッシュボードで、あなたのUmamiプロジェクトに移動します。
2. 上部ナビゲーションの **Storage** タブをクリックし、次に **Create Database** を選択します。
![](https://img.music-poster.art/2025/06/cba773362305001171fb5d0defb4f960.png)
3. データベースの種類で **Neon** を選択し、VercelがアクセスできるようにNeonアカウントにログインします。
4. データベースを設定します：
   - **プロジェクト名**：任意、例えば `umami-project`。
   - **データベース名**：`umami`を使用することをお勧めします。
   - **クラウドサービスプロバイダ**：遅延を低減するために、地域に適したプロバイダ（例えばAWSのアジア地域）を選択します。
5. 作成が完了すると、Vercelは自動的に **DATABASE_URL** を生成し、それをプロジェクトの環境変数に追加します。形式は以下の通りです：
   ```
   postgresql://[username]:[password]@[host]/[database]
   ```
6. プロジェクト設定に戻り、**Environment Variables** に `DATABASE_URL` が含まれていることを確認します。
7. プロジェクトを再デプロイ：**Deployments**タブをクリックし、最新のデプロイを選択して **Redeploy** をクリックします。

## ステップ 4：Umamiを設定

1. デプロイが完了すると、**Visit**をクリックしてあなたのUmamiインスタンスを表示し、割り当てられたデフォルトドメイン名（例： `your-project.vercel.app`）を忘れずにメモします。
2. Umamiウェブサイトにアクセスし、初回ログイン時のデフォルトアカウントは以下の通りです：
   - ユーザー名：`admin`
   - パスワード：`umami`
3. ログイン後、すぐにパスワードを変更して安全を確保します。
4. Umamiダッシュボードで、**Add Website**をクリックし、あなたのウェブサイト情報（ドメイン名、名称など）を入力します。
![](https://img.music-poster.art/2025/06/2b0b37c13001ea761ffcd370f170defc.png)
5. Umamiは次の形式のJavaScriptトラッキングコードを生成します：
   ```html
   <script async src="https://your-project.vercel.app/umami.js" data-website-id="YOUR_WEBSITE_ID"></script>
   ```
   このコードをコピーします。

## ステップ 5：Hugoサイトにトラッキングコードを埋め込む

UmamiがあなたのHugoサイトのトラフィックを統計取り込むには、トラッキングコードをウェブサイトに埋め込む必要があります。これは通常、あなたの使用しているHugoテーマがサポートしている必要があります。サポートしていない場合は、自分でHugoテーマを修正する必要があります。

ここでは、[hugo-narrow](https://github.com/luizdepra/hugo-narrow)テーマを使用しています。このテーマはUmamiの設定をサポートしているため、`hugo.yaml`ファイルに次のように設定できます：
```yaml
  analytics:
    enabled: true
    umami: 
      enabled: true
      id: "YOUR_WEBSITE_ID"
      src: "https://your-project.vercel.app/umami.js"
      domains: ""
```
ここでの `YOUR_WEBSITE_ID`はUmamiで作成したウェブサイトのIDに置き換えてください。`src`もVercelにデプロイしたUmamiプロジェクトのドメイン名に置き換える必要があります。

次に、あなたのウェブサイトにアクセスすると、Umamiはトラフィックデータを収集し始めます。

## ステップ 6：検証と最適化

1. Umamiダッシュボードに戻り、数分待ってからトラフィックデータの記録があるか確認します。
2. トラッキングコードが正常に動作しているか確認します：
   - ブラウザの開発者ツール（F12）を開き、**Network**パネルに切り替え、ページをリフレッシュして、`your-project.vercel.app/api/collect`へのリクエストがあるか確認します。
3. （オプション）Umamiダッシュボードのカスタマイズ：
   - 保持する複数のウェブサイトを追加します。
   - データ共有リンクを設定し、チームと統計データを共有しやすくします。
   - Umamiのテーマや言語設定を調整し、中国語インターフェースをサポートします。

## 注意事項

- **Neon無料枠**：Vercel Storageを通じて作成したNeonデータベースにはストレージおよび計算時間の制限があります。小規模なウェブサイトに適しています。トラフィックが多い場合は、有料プランへのアップグレードを検討してください。
- **Vercel無料枠**：Vercelの無料プランは、月に100GBの帯域幅を提供し、大多数の個人ウェブサイトのニーズには十分です。
- **プライバシー準拠**：Umamiはプライバシーを重視していますが、あなたのウェブサイトがGDPRまたは他のプライバシー規制（例えばEU地域で運営）を遵守していることを確認してください。
- **セキュリティ**：Neonデータベースを定期的にバックアップし、Umamiの管理者アカウントには強力なパスワードを使用してください。

## 結論

Vercelとその統合されたNeonデータベースを使用すれば、数分で機能的でゼロコストのウェブサイトトラフィック統計システムを構築できます。Umamiのシンプルなインターフェースとコア機能は、Hugoブログユーザーに非常に適しており、訪問数の統計、ソース分析、ページパフォーマンスの監視など、ニーズを満たします。

質問がある場合やさらなる最適化が必要な場合は、コメントセクションで交流してください！このチュートリアルがあなたのウェブサイトのトラフィックをよりよく理解する手助けとなれば幸いです。

## 参考資料

- Umami公式ドキュメント：[https://umami.is/docs](https://umami.is/docs)
- Vercel Storageドキュメント：[https://vercel.com/docs/storage](https://vercel.com/docs/storage)
- Neonデータベースの設定ガイド：[https://neon.tech/docs](https://neon.tech/docs)
- Hugoドキュメント：[https://gohugo.io/documentation/](https://gohugo.io/documentation/)