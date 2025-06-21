---
title: "10분 안에 블로그 웹사이트를 GitHub Pages에 배포하기"
subtitle: "GitHub Pages를 사용하여 당신의 Hugo 블로그를 무료로 호스팅하기"
date: 2025-05-18T17:01:07+08:00
lastmod: 2025-05-18T17:01:07+08:00
draft: false
authors: ["heyjude"]
description: "Hugo 블로그를 GitHub Pages에 배포하는 방법에 대한 자세한 가이드를 제공합니다. 여기에는 저장소 생성, GitHub Actions 설정, 자동 배포 과정 등이 포함되어 있어 비용 없이 전문적인 개인 블로그 웹사이트를 구축하는 데 도움이 됩니다."

tags: ["hugo", "github pages", "자동 배포", "정적 웹사이트", "CI/CD"]
categories: ["블로그 구축", "기술 튜토리얼", "자동 배포"]
series: ["블로그 튜토리얼"]

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

우리가 로컬에서 블로그 웹사이트를 구축한 후, 다음 단계는 블로그 내용을 인터넷에 배포하여 다른 사람들이 볼 수 있도록 하는 것입니다.

저는 현재의 호스팅 사이트를 조사해봤고 다음과 같은 선택지가 있습니다:

- **GitHub Pages**: GitHub이 제공하는 무료 정적 사이트 호스팅 서비스로, 코드 저장소와 통합하기에 적합합니다.
- **Netlify**: 자동 구축 및 배포를 지원하며, 무료 패키에서 기능이 풍부하고 Hugo 지원이 매우 좋습니다.
- **Vercel**: Next.js 팀이 개발했으며, 배포 속도가 빠르고 프론트엔드 프로젝트에 적합합니다.
- **Cloudflare Pages**: Cloudflare가 제공하는 정적 사이트 호스팅 서비스로, CDN과 보안 가속이 포함되어 있습니다.
- **Firebase Hosting**: 구글이 출시한 프론트엔드 호스팅 플랫폼으로, 프론트엔드 애플리케이션과 함께 사용하는 데 적합합니다.
- **Amazon S3 + CloudFront**: 고성능의 호스팅 및 배포 솔루션으로, 전문 배포에 적합합니다.
- **GitLab Pages**: GitLab이 제공하는 정적 사이트 호스팅 서비스로, CI 설정을 통해 자동 구축할 수 있습니다.
- **Render**: 간결한 풀스택 호스팅 플랫폼으로, Hugo 웹사이트의 자동 배포를 지원합니다.
- **Surge.sh**: 매우 간단한 스타일의 정적 사이트 호스팅 도구로, 명령줄 배포가 간단하고 빠릅니다.
- **DigitalOcean App Platform**: 클라우드 서비스 플랫폼으로, 정적 웹사이트 및 백엔드 서비스의 자동 배포를 지원합니다.

이 플랫폼들은 각각의 특징이 있으며, 이후의 기사에서 하나씩 배포 방법을 소개할 것입니다. 이번 기사에서는 블로그 웹사이트를 GitHub Pages에 배포하는 방법을 소개하겠습니다.

## Github Pages란 무엇인가
GitHub Pages는 GitHub에서 제공하는 무료 정적 웹사이트 호스팅 서비스로, 블로그, 프로젝트 홈페이지, 문서 등을 호스팅하는 데 적합합니다. 단 하나의 GitHub 저장소만 있으면 https://yourname.github.io 또는 사용자 정의 도메인에 웹사이트를 게시할 수 있습니다.

## GitHub Pages에 블로그 웹사이트 배포하기
### 전체적인 아이디어
* 당신의 주 저장소(예: my-hugo-site)에는 Hugo 소스 코드(내용, 레이아웃 등)가 포함되어 있습니다.
* 빌드된 정적 파일(공용)이 다른 저장소(사용자이름.github.io)로 푸시됩니다.
* 사용자이름.github.io 저장소는 생성된 정적 웹사이트를 호스팅하는 데 전용입니다.

### 프로젝트 구조
다음과 같은 두 개의 GitHub 저장소가 있다고 가정해 보겠습니다:
* my-hugo-site(소스 저장소): Hugo 소스 코드와 기사를 저장합니다.
* 사용자이름.github.io(배포 저장소): 빌드된 정적 파일을 저장합니다.

프로젝트 구조는 다음과 같습니다:
```
my-hugo-site/
├── content/            # 블로그 내용
├── layouts/            # Hugo 사용자 정의 레이아웃
├── themes/             # Hugo 테마
├── config.toml        # Hugo 설정 파일
└── .github/workflows/deploy.yml  # 자동 배포 설정

사용자이름.github.io/
├── (배포된 정적 웹사이트 파일)   # 정적 파일은 Hugo에 의해 빌드됩니다
```
### 단계 1: 두 개의 저장소 만들기
1. GitHub에서 두 개의 저장소를 만듭니다:
  * my-hugo-site: Hugo 소스 코드를 저장하는 데 사용됩니다.
  * 사용자이름.github.io: 빌드된 정적 파일을 저장하는 데 사용됩니다.

2. 사용자이름.github.io 저장소에서, GitHub Pages의 소스 브랜치를 main(또는 master)으로 설정합니다.

### 단계 2: GitHub Actions 자동 배포 설정
my-hugo-site 저장소에서 .github/workflows/deploy.yml 파일을 생성하고, 정적 파일을 사용자이름.github.io 저장소에 푸시하도록 자동으로 빌드합니다.
```yaml
name: GitHub Pages

on:
  push:
    branches:
      - main  # 블로그 루트 디렉토리의 기본 브랜치, 여기서는 main, 때로는 master일 수 있습니다.
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
          hugo-version: '0.147.0'  # 당신의 Hugo 버전을 입력하세요. hugo version으로 확인할 수 있습니다.
          extended: true          # 확장판이 아니라면 true를 false로 변경하세요.

      - name: Build
        run: git submodule update --init --recursive && hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: ${{ github.ref == 'refs/heads/main' }}  # main 또는 master로 작성하는 것을 잊지 마세요.
        with:
          personal_token: ${{ secrets.MY_PAT}} # secret의 이름이 다르면 MY_PAT를 변경하세요.
          external_repository: lxb1226/lxb1226.github.io # 원격 저장소를 입력하세요. 반드시 이 형식일 필요는 없습니다.
          publish_dir: ./public
          #cname: www.example.com        # 당신의 사용자 정의 도메인을 입력하세요. 사용자 정의 도메인이 없다면 이 줄을 주석 처리하세요.
```
내 [depoly.yaml](https://github.com/lxb1226/heyjude-blog/blob/main/.github/workflows/deploy.yaml)을 참고할 수 있습니다.

### GitHub secrets 가져오기
위의 yaml 파일에서 `personal_token`을 가져와야 합니다. 이는 my-hugo-site 저장소에서 얻을 수 있습니다.

저장소 -> 설정 -> 비밀 및 변수 -> 작업에서 얻을 수 있습니다.
![personal_token](https://img.music-poster.art/2025/05/5331092ac30840b1bc967395cce01709.png)


### 단계 3: GitHub Pages 구성
1. 사용자이름.github.io 저장소에서, 설정 → 페이지에 들어갑니다.
2. 소스를 main 브랜치로 설정하고 GitHub Pages가 올바르게 구성되었는지 확인합니다.
3. 저장한 후, 정적 웹사이트는 https://yourusername.github.io/에서 호스팅됩니다.
![](https://img.music-poster.art/2025/05/9052201a8331d0e293e23b1741d0fc80.png)

## 블로그 자동 게시 흐름
1. my-hugo-site 저장소에서 글을 작성하고 사이트를 수정합니다.
2. main 브랜치에 업데이트를 푸시할 때마다, GitHub Actions가 자동으로 정적 파일을 사용자이름.github.io 저장소에 푸시합니다.
3. GitHub Pages는 자동으로 업데이트되고 https://yourusername.github.io/에서 표시됩니다. (일반적으로 이 과정에는 시간이 걸립니다.)


## 참고
1. https://docs.github.com/en/actions
2. https://gohugo.io/documentation/
3. https://lxb1226.github.io/
4. https://github.com/lxb1226/heyjude-blog