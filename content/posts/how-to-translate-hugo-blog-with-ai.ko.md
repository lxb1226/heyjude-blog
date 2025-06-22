---
title: "AI를 활용한 Hugo 블로그 자동 번역 방법"
subtitle: "OpenAI를 통한 블로그 다국어 지원"
date: 2025-06-22T10:00:00+08:00
draft: false
authors: ["heyjude"] 
description: "이 문서는 AI 도구를 사용하여 Hugo 블로그를 자동으로 여러 언어로 번역하는 방법을 소개하며, 블로그의 국제화를 실현합니다."

tags: ["Hugo", "블로그", "AI", "OpenAI", "자동화", "국제화", "i18n"]
categories: ["튜토리얼"]

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

## 서론

자신의 블로그를 만들고 나면 다국어 지원을 희망하게 됩니다. 이는 청중을 확장할 수 있을 뿐만 아니라 블로그의 SEO 성능을 개선할 수 있습니다. 하지만 블로그 기사를 수동으로 번역하는 것은 시간과 노력이 많이 드는 작업이며 전문 번역가가 필요합니다. 하지만 AI의 발전으로 이제는 쉽게 블로그를 원하는 언어로 번역할 수 있게 되었습니다. 이를 위해 AI를 활용하여 블로그 기사를 자동으로 번역하는 도구를 만들었습니다. 이 도구를 사용하면 다국어 지원을 쉽게 할 수 있습니다.

[hugo-translator](https://github.com/lxb1226/hugo-translator)에서 이 도구를 받을 수 있습니다.

## 준비 작업

시작하기 전에 다음 내용을 준비해야 합니다:

1. 실행 중인 Hugo 블로그
2. Node.js 및 npm 환경
3. OpenAI API 키 (AI 번역에 사용)
4. 기본적인 명령줄 작업 지식

## 구현 단계

### 1. 도구 받기

```bash
git clone https://github.com/lxb1226/hugo-translator.git
cd hugo-translator
```

### 1. AI 번역 도구 설치

Markdown 파일을 번역하기 위해 `ai-markdown-translator` 도구를 사용할 것입니다. 먼저 전역으로 설치합니다:

```bash
npm install -g ai-markdown-translator
```

### 2. 환경 변수 설정

OpenAI API 키를 설정합니다:

```bash
export OPENAI_API_KEY='your-api-key'
```
OpenAI API 키가 없는 경우 다른 API를 사용할 수 있습니다. 이 [링크](https://aihubmix.com?aff=jqnC)를 통해 제3자의 API 키를 구매할 수 있습니다.
그 후, 다음과 같이 설정할 수 있습니다:
```bash
export OPENAI_URL='your api url'
export API_KEY='your-api-key'
```

이 설정을 `.bashrc` 또는 `.zshrc` 파일에 추가하여 영구적으로 적용할 수도 있습니다.

### 3. 번역 스크립트 만들기

`translate-posts.sh`라는 이름의 스크립트 파일을 생성하여 자동 번역 과정을 진행합니다. 이 스크립트는:

- 블로그 기사를 자동으로 감지
- 다국어 번역 지원
- 이미 번역된 기사 건너뛰기
- 상세한 번역 진행 상황 및 통계 제공

주요 기능은 다음과 같습니다:

1. **다국어 지원**: 기본적으로 영어, 일본어, 한국어 등 다양한 언어 지원
2. **지능적 감지**: 원본 언어와 목표 언어 자동 인식
3. **증분 업데이트**: 새로 추가되거나 변경된 내용만 번역
4. **오류 처리**: 완벽한 오류 처리 및 로그 기록
5. **진행 상황 표시**: 실시간으로 번역 진행 상황 및 상태 표시

### 4. 사용 방법

기본 사용법:

```bash
./translate-posts.sh
```

목표 언어 사용자 지정:

```bash
TARGET_LANGS="en ja ko" ./translate-posts.sh
```
![](https://img.music-poster.art/2025/06/d4a96bd60970c9a0e3f2f54ce7167ba1.png)

### 5. 파일 명명 규칙

번역된 파일은 Hugo의 국제화 명명 규칙에 따라 자동으로 이름이 지정됩니다:

- 영어판: `post-name.en.md`
- 일본판: `post-name.ja.md`
- 한국판: `post-name.ko.md`

## 참고 자료

- [Hugo 다국어 지원 공식 문서](https://gohugo.io/content-management/multilingual/)
- [OpenAI API 문서](https://platform.openai.com/docs/api-reference)
- [ai-markdown-translator 사용 가이드](https://github.com/h7ml/ai-markdown-translator)
- [hugo-translator](https://github.com/lxb1226/hugo-translator)