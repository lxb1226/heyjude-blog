---
title: "Hugo 블로그에 Giscus 댓글 시스템 통합하기"
date: 2025-06-15
slug: "giscus-comments-hugo"
tags: ["Hugo", "댓글 시스템", "Giscus", "블로그 구축", "GitHub Discussions", "정적 블로그", "블로그 상호작용", "오픈소스 댓글 시스템", "제로 비용 배포"]
keywords: ["Giscus 댓글 시스템", "Hugo 블로그 댓글", "GitHub Discussions 댓글", "정적 블로그 댓글 솔루션", "오픈소스 댓글 도구", "블로그 상호작용 시스템", "무료 댓글 시스템", "Hugo 테마 커스터마이징", "블로그 기능 확장"]
description: "이 글에서는 Hugo 블로그에 Giscus 댓글 시스템을 통합하는 방법을 자세히 설명합니다. Giscus는 GitHub Discussions 기반의 현대 댓글 솔루션입니다. 이 튜토리얼을 통해, 여러분은 안전하고 신뢰할 수 있으며 Markdown을 지원하는 댓글 시스템을 제로 비용으로 구축하는 방법을 배울 것입니다. 어두운 모드 및 다국어 인터페이스를 지원하며, Hugo 정적 블로그에 완벽하게 적합합니다. 데이터베이스가 필요 없으며 모든 댓글 데이터는 GitHub에 저장되어 데이터의 안전성과 지속 가능성을 보장합니다."
---

이것은 나만의 블로그 시스템을 구축하는 세 번째 튜토리얼로, 블로그에 댓글 시스템을 추가하는 방법입니다.

블로그를 구축하는 과정에서, 훌륭한 댓글 시스템은 상호작용을 크게 향상시킬 수 있습니다. 오늘 저는 Hugo 블로그에 [Giscus](https://giscus.app/)라는 GitHub Discussions 기반의 오픈소스 댓글 시스템을 통합하는 방법을 소개할 것입니다.

## 왜 Giscus를 선택해야 할까요?

- 🚀 서버가 필요 없고, GitHub Discussions 기반
- 🔒 안전하고 신뢰할 수 있으며, 댓글 데이터는 GitHub에 저장
- 🧩 다크 모드 및 적응형 테마 지원
- 💬 익명 댓글 지원(선택적)
- 🌍 다국어 인터페이스 지원

## 준비 사항

시작하기 전에, 다음이 필요합니다:

1. GitHub에서 호스팅되는 리포지토리
2. Discussions 기능 활성화
3. Hugo 블로그 (어떤 테마도 가능)

## 단계 1: GitHub Discussions 활성화하기

1. 블로그 코드 리포지토리(예: `username/blog`)를 엽니다.
2. **Settings** → **Features**로 가서 **Discussions**를 체크합니다.
![](https://img.music-poster.art/2025/06/8c0271325d91ad29527d1acef14fd869.png)
## 단계 2: Giscus 설정하기

[https://giscus.app](https://giscus.app)로 이동하여:

1. 자신의 GitHub 리포지토리를 선택합니다.
2. 댓글을 어떤 Discussion 카테고리에서 생성할지 설정합니다(예: `announcement` 새로 만들기).
3. 사용자 정의 설정:
   - Mapping: `pathname`을 선택하는 것을 추천합니다. 즉 페이지 경로에 따라 논의를 연결합니다.
   - Reaction: 좋아요 등의 작업을 허용할지 여부.
   - 테마: `light`, `dark`, `preferred_color_scheme` 등을 지원합니다.
4. 생성된 `<script>` 코드를 복사합니다.
![](https://img.music-poster.art/2025/06/116ebde5a465cfbea4f3c5b84192be3d.png)
생성된 코드는 다음과 같습니다:

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
        data-lang="zh-CN"
        crossorigin="anonymous"
        async>
</script>
```

여기서 `data-repo`, `data-repo-id`, `data-category-id` 이 세 가지 매개변수를 기억해야 합니다. 이후 설정에서 사용될 것입니다.

## 단계 3: Giscus를 Hugo 테마에 통합하기
제가 사용하는 테마는 [hugo-narrow](https://github.com/tom2almighty/hugo-narrow)로, 이 테마는 Giscus 댓글 시스템이 통합되어 있습니다. 여러분은 간단하게 설정만 하면 됩니다. 다음은 저의 설정입니다:

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
      lang: "en"
```
여기서 `repo`, `repoId`, `categoryId`를 단계 2에서 저장한 값으로 바꿔야 합니다. 그래야 댓글이 정상적으로 표시됩니다.
또한 `enable`은 `true`로, `system`은 `giscus`로 설정해야 합니다. 그렇지 않으면 댓글이 표시되지 않습니다.

최종적으로, 웹 페이지의 마지막에 이렇게 생긴 인터페이스를 보게 될 것입니다:
![](https://img.music-poster.art/2025/06/2e3b16e884ac6d67db1651a8d44197db.png)

## 테스트

이 글 아래에 댓글을 달아보며 댓글이 정상적으로 표시되는지 확인해 보세요. 댓글 후에 남긴 댓글은 GitHub의 Discussion에서 확인할 수 있습니다.

여기에서 제 블로그의 댓글을 [여기](https://github.com/lxb1226/lxb1226.github.io/discussions)에서 확인할 수 있습니다.

![](https://img.music-poster.art/2025/06/fdc145c668e761fb68870ce841967e08.png)