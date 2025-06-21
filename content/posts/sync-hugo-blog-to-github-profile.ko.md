---
title: "Hugo 블로그를 GitHub 프로필에 동기화하는 방법"
date: 2025-06-21T22:00:00+08:00
draft: false
tags: ["Hugo", "GitHub", "블로그 동기화", "GitHub Actions", "자동화"]
categories: ["기술", "블로그 구축"]
description: "gautamkrishnar/blog-post-workflow를 사용하여 GitHub Actions를 통해 Hugo 블로그를 GitHub 프로필에 자동으로 동기화하는 상세 튜토리얼로, 구성 단계와 주의사항이 포함되어 있습니다."
---

## Hugo 블로그를 GitHub 프로필에 동기화하는 방법

블로그를 배포한 후, 블로그가 업데이트될 때마다 GitHub 프로필도 자동으로 업데이트되기를 원합니다. 이렇게 하면 GitHub 프로필에서 최신 블로그 기사를 보여줄 수 있습니다. 이를 위해 `GitHub action`을 활용할 수 있습니다.

## 전제 조건

시작하기 전에 다음 준비 작업을 완료했는지 확인하세요:

- **Hugo 블로그**: Hugo 블로그가 설정되고 GitHub 저장소에 호스팅되어야 합니다 (예: `username/username.github.io` 또는 사용자 정의 저장소).
- **GitHub 저장소**: 블로그 소스 파일을 저장할 저장소(예: `username/blog`)와 GitHub Pages를 위한 저장소(예: `username/username.github.io`)가 있어야 합니다.
- **GitHub 프로필 README**: GitHub에서 프로필 README를 활성화해야 합니다 (사용자 이름과 동일한 이름의 저장소를 생성, 예: `username/username`, 예를 들어 [내 GitHub 프로필](https://github.com/lxb1226/lxb1226)).
- **기본 Git 지식**: 코드 제출, `.gitignore` 구성 및 GitHub Actions 사용 방법을 이해해야 합니다.

## blog-post-workflow란 무엇인가요?

`blog-post-workflow`는 Gautam Krishnar가 개발한 GitHub Action으로, 블로그의 최신 기사를 GitHub 프로필 README나 다른 지정된 위치에 동기화하는 데 특화되어 있습니다. 다양한 블로그 프레임워크(포함된 Hugo)를 지원하며, RSS 피드를 분석하여 최신 기사를 가져와 목표 파일을 자동으로 업데이트합니다.

## 단계 1: Hugo 블로그 저장소 설정

1. **Hugo 블로그가 RSS 피드를 생성하도록 확인**:
   Hugo는 기본적으로 RSS 피드(`public/index.xml`에 위치)를 생성합니다. Hugo 구성 파일(`config.toml` 또는 `config.yaml`)에서 RSS 출력을 활성화했는지 확인하세요:
   ```toml
   [outputs]
   home = ["HTML", "RSS"]
   ```
   `hugo` 명령을 실행한 후, `public` 디렉토리 아래에 `index.xml` 파일이 존재하는지 확인하세요.

   팁: 블로그가 다국어인 경우, RSS 피드의 주소는 `https://your-blog-domain/index.xml`이어야 하며, `https://your-blog-domain/en/index.xml` 또는 `https://your-blog-domain/zh/index.xml` 등의 주소가 아니라는 점에 유의하세요.

2. **블로그 내용 호스팅**:
   - Hugo 블로그의 소스 파일이 하나의 저장소에 저장되어 있는지 확인하세요(예: `username/blog`).
   - 정적 파일(`public` 디렉토리)은 GitHub Pages 저장소(예: `username/username.github.io`)에 푸시해야 합니다.
   - GitHub Pages 저장소의 Settings > Pages에서 GitHub Pages를 활성화하고 올바른 브랜치(보통 `main` 또는 `gh-pages`)를 선택하세요.

3. **블로그 접근성 확인**:
   블로그를 사용자 정의 도메인(예: `https://username.github.io`) 또는 GitHub Pages 기본 도메인에서 접근할 수 있는지 확인하세요.

## 단계 2: GitHub 프로필 README 설정

1. **프로필 README 저장소 생성**:
   - GitHub에서 사용자 이름과 동일한 이름의 저장소를 생성하세요(예: `username/username`).
   - 저장소의 루트 디렉토리에 `README.md` 파일을 생성하여 GitHub 프로필 내용을 표시하세요.

2. **블로그 자리 표시자 추가**:
   `README.md`에 블로그 기사를 동적으로 삽입할 자리 표시자를 추가하세요. 예를 들어:
   ```markdown
   ## 내 최신 블로그 기사
   <!-- BLOG-POST-LIST:START -->
   <!-- BLOG-POST-LIST:END -->
   ```

   `blog-post-workflow`가 이 자리 표시자를 최신 블로그 기사 링크로 대체합니다.

## 단계 3: blog-post-workflow 구성

1. **GitHub Actions 워크플로 생성**:
   프로필 README 저장소(예: `username/username`)에서 다음의 디렉토리 구조를 만드세요:
   ```
   .github/workflows/blog-post.yml
   ```

2. **워크플로 파일 작성**:
   `blog-post.yml`에 다음 내용을 추가하여 `blog-post-workflow`를 구성하세요:
   ```yaml
   name: Sync Blog to Profile README

   on:
     schedule:
       - cron: "0 0 * * *" # 하루에 한 번 실행
     workflow_dispatch: # 수동 트리거 허용

   jobs:
     update-readme-with-blog:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: gautamkrishnar/blog-post-workflow@v1
           with:
             feed_list: "https://username.github.io/index.xml" # 블로그 RSS 주소로 교체
             max_post_count: 5 # 최근 5개의 기사 동기화
             readme_path: ./README.md # 대상 README 파일
             commit_message: "Update README with latest blog posts"
   ```
   - **feed_list**: Hugo 블로그 RSS 피드 주소로 교체합니다(보통 `https://your-blog-domain/index.xml`).
   - **max_post_count**: 표시할 최신 기사 개수를 설정합니다.
   - **readme_path**: 올바른 README 파일 경로를 가리키도록 확인합니다.
   - **commit_message**: 커밋 메시지를 사용자 정의합니다.

3. **워크플로 파일 제출**:
   `blog-post.yml`을 프로필 README 저장소에 제출합니다. GitHub Actions는 매일 자정(UTC)에 자동으로 실행되거나 GitHub의 Actions 패널을 통해 수동으로 트리거할 수 있습니다.

## 단계 4: 동기화 결과 확인

1. **GitHub Actions 로그 확인**:
   - 프로필 README 저장소의 Actions 탭으로 이동하여 `Sync Blog to Profile README` 워크플로의 실행 상태를 확인합니다.
   - 오류 없이 워크플로가 성공적으로 완료되었는지 확인합니다.
![](https://img.music-poster.art/2025/06/133d3d31fe568cbba71be00326fe6420.png)
   - 수동으로 워크플로를 트리거하여 README가 업데이트되었는지 확인할 수 있습니다. `Run workflow`를 클릭하여 수동으로 트리거하세요.
   ![](https://img.music-poster.art/2025/06/bd7d8b28b5a2538881cfd90a878dcd8e.png)

2. **README 업데이트 확인**:
   - `username/username` 저장소의 `README.md`를 열어 `<!-- blog-post-workflow -->` 자리 표시자가 최신 블로그 기사 목록으로 대체되었는지 확인합니다.
   - 예시 출력은 다음과 같을 수 있습니다:
     ```markdown
     ## 내 최신 블로그 기사
     - [기사 제목 1](https://username.github.io/post/xxx) - 2025-06-21
     - [기사 제목 2](https://username.github.io/post/yyy) - 2025-06-20
     ```

3. **GitHub 프로필 방문**:
   GitHub 홈페이지(`https://github.com/username`)를 열어 최신 블로그 기사가 프로필 README에 표시되었는지 확인합니다.
   ![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

## 주의사항

- **RSS 피드 가용성**: 블로그 RSS 피드(`index.xml`)에 공용 URL로 접근할 수 있는지 확인하세요. 블로그가 비공개 저장소에 호스팅되고 있다면, 공개 저장소로 변경하거나 다른 방법으로 RSS를 제공해야 합니다.
- **GitHub Actions 권한**: 저장소에서 Actions 쓰기 권한을 활성화했는지 확인하세요 (Settings > Actions > General > Allow all actions and reusable workflows).
- **동기화 빈도**: 기본 구성은 하루에 한 번 동기화하도록 설정되어 있으며, 필요에 따라 `cron` 표현식을 조정할 수 있습니다(예: 매시간: `0 * * * *`).
- **디버깅**: 동기화에 실패한 경우, Actions 로그를 확인하세요. 일반적인 문제는 RSS 주소 오류 또는 README 파일 경로 오류입니다.

---

**참조 자료**:
- [gautamkrishnar/blog-post-workflow](https://github.com/gautamkrishnar/blog-post-workflow)
- [Hugo 공식 문서](https://gohugo.io/documentation/)
- [GitHub Actions 문서](https://docs.github.com/en/actions)