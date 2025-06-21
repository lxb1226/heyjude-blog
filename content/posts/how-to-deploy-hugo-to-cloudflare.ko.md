---
title: Hugo를 사용하여 블로그를 구축하고 Cloudflare Pages에 배포하기
date: 2025-06-16T20:29:00+08:00
tags: [Hugo, Cloudflare, 블로그, 정적 웹사이트, 배포]
categories: [기술 튜토리얼]
description: 이 글에서는 Hugo 정적 웹사이트 생성기를 사용하여 블로그를 만드는 방법과 Cloudflare Pages를 통해 배포하는 방법을 환경 설정, 테마 설치, 콘텐츠 생성 및 도메인 바인딩 등을 포함한 전체 단계로 자세히 설명합니다.
slug: deploy-hugo-to-cloudflare
---

# Hugo를 사용하여 블로그를 구축하고 Cloudflare Pages에 배포하기

이 글에서는 [Hugo](https://gohugo.io/)를 사용하여 개인 블로그를 구축하고 이를 [Cloudflare Pages](https://pages.cloudflare.com/)에 배포하는 전체 과정을 단계별로 안내하겠습니다. Hugo는 빠르고 유연한 정적 웹사이트 생성기이며, Cloudflare Pages는 무료 정적 웹사이트 호스팅 서비스를 제공하여 글로벌 CDN 가속과 결합해 블로그를 빠르게 온라인으로 만들고 좋은 이용 경험을 제공합니다. 기술 초보자든 어느 정도 경험이 있는 개발자든 이 튜토리얼은 여러분이 자신만의 블로그를 빠르게 구축하는 데 도움을 줄 것입니다.

## 왜 Hugo와 Cloudflare Pages를 선택해야 할까요?

- **Hugo**: Go 언어로 작성되어 생성 속도가 매우 빠르며, 풍부한 테마와 Markdown 포맷을 지원하여 블로그와 문서 웹사이트에 적합합니다.
- **Cloudflare Pages**: GitHub와의 원활한 통합, 자동 배포, 무료 SSL 인증서, 그리고 글로벌 CDN 가속을 제공하여, 국내에서의 접근 속도가 GitHub Pages보다 우수합니다.
- **비용**: 두 가지를 결합하면 완전히 무료로 사용할 수 있어 개인 블로그나 소규모 프로젝트에 적합합니다.

## 사전 준비

시작하기 전에 다음 도구와 계정을 준비해야 합니다:

1. **Hugo**: 최신 버전의 Hugo를 설치합니다(더 많은 기능을 지원하는 확장 버전을 사용하는 것이 좋습니다).
2. **Git**: 버전 관리 및 코드를 GitHub에 푸시하기 위해 사용됩니다.
3. **GitHub 계정**: 블로그 소스 코드를 저장하는 데 사용됩니다.
4. **Cloudflare 계정**: 블로그를 배포하고 호스팅하는 데 사용됩니다.
5. **텍스트 편집기**: VSCode와 같이 Markdown 파일과 구성 파일을 편집하는 데 사용됩니다.

## 단계 1: Hugo 설치

### Windows
1. Chocolatey 패키지 관리자를 설치합니다(아직 설치하지 않은 경우):
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
2. Chocolatey를 사용하여 Hugo 확장 버전을 설치합니다:
   ```powershell
   choco install hugo-extended
   ```
3. 설치를 확인합니다:
   ```powershell
   hugo version
   ```

### macOS
1. Homebrew를 사용하여 설치합니다:
   ```bash
   brew install hugo
   ```
2. 설치를 확인합니다:
   ```bash
   hugo version
   ```

더 많은 설치 방법은 [Hugo 공식 문서](https://gohugo.io/getting-started/installing/)를 참조하세요.

## 단계 2: Hugo 사이트 생성

1. 터미널에서 새 사이트를 생성합니다:
   ```bash
   hugo new site my-blog
   cd my-blog
   ```
   이는 `my-blog` 폴더 내에 Hugo 사이트의 디렉터리 구조를 생성합니다:
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

2. Git 저장소를 초기화합니다:
   ```bash
   git init
   ```

3. 생성된 파일을 무시하기 위해 `.gitignore` 파일을 추가합니다:
   ```bash
   echo "public/" >> .gitignore
   echo "resources/" >> .gitignore
   ```

## 단계 3: 테마 설치 및 구성

1. [hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack)와 같은 Hugo 테마를 선택합니다:
   ```bash
   git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
   ```

2. 테마의 예시 구성 파일을 프로젝트의 루트 디렉터리에 복사합니다:
   ```bash
   cp themes/hugo-theme-stack/exampleSite/config.yaml .
   ```

3. `config.yaml` (또는 `hugo.toml`)을 편집하여 기본 정보를 설정합니다:
   ```yaml
   baseURL: "https://your-domain.com/"  # 당신의 도메인으로 교체
   languageCode: "zh-cn"
   title: "내 블로그"
   theme: "hugo-theme-stack"
   DefaultContentLanguage: "zh-cn"
   hasCJKLanguage: true
   paginate: 5
   ```

더 많은 테마 구성은 테마의 공식 문서를 참조하세요.

## 단계 4: 첫 번째 블로그 글 작성

1. 새 글을 작성합니다:
   ```bash
   hugo new posts/my-first-post.md
   ```
   이는 `content/posts/` 디렉터리에 `my-first-post.md` 파일을 생성합니다.

2. 게시물 내용을 편집하고 Front Matter(게시물 메타데이터)를 수정합니다:
   ```markdown
   ---
   title: "내 첫 번째 블로그 글"
   date: 2025-06-16T20:29:00+08:00
   draft: false
   ---
   Hugo 블로그에 오신 것을 환영합니다! 이것은 내 첫 번째 글입니다.
   ```

3. Hugo 로컬 서버를 시작하여 미리 봅니다:
   ```bash
   hugo server -D
   ```
   브라우저를 열고 `http://localhost:1313/`에 접속하면 블로그의 로컬 미리 보기를 확인할 수 있습니다.

## 단계 5: GitHub에 코드 푸시

1. GitHub에서 새 저장소(예: `my-blog`)를 생성합니다. 공개 또는 비공개를 선택할 수 있습니다.
2. 로컬 코드를 GitHub에 푸시합니다:
   ```bash
   git add .
   git commit -m "초기 커밋"
   git remote add origin https://github.com/your-username/my-blog.git
   git branch -M main
   git push -u origin main
   ```

## 단계 6: Cloudflare Pages에 배포

1. [Cloudflare 대시보드](https://dash.cloudflare.com/)에 로그인하여 "Workers 및 Pages" > "Pages" > "프로젝트 만들기"로 이동합니다.
![](https://img.music-poster.art/2025/06/460d03da3f5f0c737c60951d16dd12b4.png)
2. GitHub 계정을 연결하고 방금 생성한 `my-blog` 저장소를 선택합니다.
![](https://img.music-poster.art/2025/06/5577398c00ea3e040f927f4272d7d5c9.png)
3. 빌드 설정을 구성합니다:
   - **프로젝트 이름**: 원하는 이름(예: `my-blog`)을 입력하면 `my-blog.pages.dev`의 서브도메인이 할당됩니다.
   - **생산 브랜치**: 기본값 `main`입니다.
   - **빌드 명령**: `hugo --gc --minify` (출력 파일 최적화).
   - **출력 디렉터리**: `public`.
   - **환경 변수**: Hugo 버전을 지정하기 위해 `HUGO_VERSION` (예: `0.125.4`)를 추가하는 것을 권장하며, 최신 버전을 사용하는 것이 좋습니다. [Hugo 릴리스](https://github.com/gohugoio/hugo/releases)를 확인하세요.
   ![](https://img.music-poster.art/2025/06/4ce72f3294fdc3f92e2a504e70a11b5a.png)
4. "저장 및 배포"를 클릭하면 Cloudflare Pages가 코드 가져오기, 빌드 및 배포를 자동으로 수행합니다. 배포가 완료되면 `my-blog.pages.dev`를 통해 블로그에 접속할 수 있습니다.
![](https://img.music-poster.art/2025/06/50fc6325948a3ddc3aa9a424b56a6f65.png)

## 단계 7: 사용자 정의 도메인 연결

1. 도메인이 Cloudflare에 호스팅되어 있는지 확인합니다(Cloudflare에서 구매하거나 다른 등록업체에서 이전할 수 있습니다).
2. Cloudflare Pages 프로젝트에서 "사용자 정의 도메인" > "사용자 정의 도메인 설정"을 클릭합니다.
3. 당신의 도메인(예: `your-domain.com`)을 입력하면 Cloudflare가 자동으로 CNAME 레코드를 추가합니다.
4. DNS 전파가 완료될 때까지 기다립니다(일반적으로 몇 분에서 몇 시간 소요), 이후에는 사용자 정의 도메인을 통해 블로그에 접속할 수 있습니다.

## 단계 8: 자동화 배포

블로그 콘텐츠(예: 새 글 추가 또는 구성 수정)를 업데이트할 때마다 다음 명령을 실행하여 코드를 푸시하기만 하면 됩니다:
```bash
git add .
git commit -m "블로그 콘텐츠 업데이트"
git push origin main
```
Cloudflare Pages는 GitHub 저장소의 업데이트를 자동으로 감지하고 다시 빌드 및 배포하며, 보통 1-2분 내에 완료됩니다.

## 문제 해결 및 해결 방법

1. **Hugo 버전 불일치**: Cloudflare Pages는 기본적으로 이전 버전의 Hugo를 사용할 수 있으며, 이로 인해 빌드 실패가 발생할 수 있습니다. 해결 방법은 최신 버전을 환경 변수에 지정하는 것입니다 (예: `HUGO_VERSION=0.125.4`).
2. **게시물이 표시되지 않음**: 게시물의 `draft: false`가 올바르게 설정되었는지 확인하십시오. Hugo는 기본적으로 `draft: true` 게시물을 렌더링하지 않습니다.
3. **국내 접근 속도 느림**: 도메인이 Cloudflare의 CDN 가속을 통과하고 SSL을 활성화했는지 확인하세요.

## 요약

Hugo와 Cloudflare Pages를 통해 빠르게 고성능의 무료 개인 블로그를 구축할 수 있습니다. Hugo는 유연한 콘텐츠 관리와 풍부한 테마 지원을 제공하고, Cloudflare Pages의 자동 배포 및 글로벌 CDN 가속으로 블로그의 게시와 접근이 더 효율적으로 이루어집니다.

## 참고
- [Hugo 공식 문서](https://gohugo.io/documentation/)
- [Cloudflare Pages 공식 문서](https://developers.cloudflare.com/pages/)