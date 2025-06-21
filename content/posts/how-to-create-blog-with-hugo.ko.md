---
title: "10분 만에 나만의 블로그 사이트 만들기"
date: 2025-05-05T20:28:24+08:00
lastmod: 2025-05-05T20:28:24+08:00
draft: false
keywords: ["hugo", "블로그 만들기", "개인 웹사이트", "정적 사이트 생성기", "블로그 테마", "웹사이트 개발"]
description: "Hugo 정적 사이트 생성기를 이용해 개인 블로그 웹사이트를 빠르게 만드는 자세한 튜토리얼로, Hugo 설치, 테마 선택, 기본 설정 및 콘텐츠 관리 등의 단계로 구성되어 있어 10분 만에 전문적인 개인 블로그를 가질 수 있습니다."
tags: ["hugo", "블로그 만들기", "정적 사이트", "개인 웹사이트", "기술 튜토리얼"]
categories: ["블로그 만들기", "기술 튜토리얼"]
series: ["블로그 튜토리얼"]
author: "heyjude"

# 이 콘텐츠에 대해서는 false로 닫거나 true로 열 수 있습니다.
# P.S. 댓글은 닫을 수만 있습니다.
comment: true
toc: true
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# 또 다른 콘텐츠 저작권을 정의할 수 있습니다. 예: contentCopyright: "이것은 또 다른 저작권입니다."
contentCopyright: false
reward: true
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# 헤더나 푸터가 보이지 않게 하려는 목록에서 제외된 게시물
hideHeaderAndFooter: false

# 개별 게시물에 대해 오래된 콘텐츠 경고를 활성화하거나 비활성화할 수 있습니다.
# 이 주석을 주석 처리하면 전역 구성을 사용할 수 있습니다.
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""

---
## hugo란 무엇인가

Hugo는 가장 인기 있는 오픈 소스 정적 사이트 생성기 중 하나입니다. 사용자들은 Hugo를 사용하여 빠르게 자신만의 웹사이트를 만들 수 있습니다.

## 구축 단계

### hugo 설치
맥에서 hugo를 설치하려면 다음 명령어를 사용할 수 있습니다:
```bash
brew install hugo
```
![install](https://img.music-poster.art/2025/05/c9d27037a7d215ff8eaa14383cba62b6.png)

설치가 완료되면 `hugo version`을 사용하여 설치 여부를 확인할 수 있습니다:
![hugo_version](https://img.music-poster.art/2025/05/9368e5db6f1f18f70eba3017c7144a9b.png)

### hugo로 블로그 웹사이트 만들기
Hugo를 설치한 후, hugo를 사용하여 자신의 블로그 웹사이트를 만들 수 있습니다.
`hugo new site my-blog`를 사용하여 my-blog이라는 이름의 웹사이트를 생성합니다.
![new-blog-site](https://img.music-poster.art/2025/05/c31b6d2f942a44af304823b9b2d40e76.png)
이 명령어를 실행하면 현재 디렉토리에 my-blog이라는 디렉토리가 생성됩니다.
그 후 해당 디렉토리로 이동하여 git을 사용하여 초기화합니다.
```bash
cd my-blog
git init
```

### 테마 선택
웹사이트를 생성한 후, 테마를 선택해야 합니다. 여기에는 선택할 수 있는 많은 테마가 있습니다: [hugo themes](https://themes.gohugo.io/)
여기서 저는 hugo-theme-even 테마를 선택했습니다. 이때 이 테마를 submodule로 themes/even에 추가해야 합니다.
```bash
git submodule add https://github.com/olOwOlo/hugo-theme-even.git themes/even
```
![pick-theme](https://img.music-poster.art/2025/05/10d92ec7695324dd4db2cb0772f764f8.png)
그 후 `themes/even/exampleSite/config.toml`을 현재 디렉토리로 복사하고 `hugo.toml`을 덮어씌웁니다.
```bash
cp themes/even/exampleSite/config.toml hugo.toml
```

### 블로그 작성
테마 설정이 완료되면 자신의 블로그를 만들 수 있습니다.
`hugo new content content/post/my-first-post.md`를 사용하여 블로그를 작성할 수 있습니다.
이 명령어를 실행하면 `content/post/` 아래에 새로운 md 파일이 생성됨을 볼 수 있습니다.
![my-first-blog](https://img.music-poster.art/2025/05/b6760e2f47eed1c8a962e475f69adc92.png)


### hugo 실행
모든 설정이 완료된 후, `hugo server`를 사용하여 hugo 서버를 시작할 수 있습니다.
![](https://img.music-poster.art/2025/05/69da7f70c3795f266a83207d186d0ad4.png)
링크를 클릭하면 블로그 웹사이트 주소에 접속할 수 있습니다.
![](https://img.music-poster.art/2025/05/10ebbce59ca6637b1b44c8d884c471bd.png)
이때 이전에 생성한 블로그가 표시되지 않는 이유는 처음 생성한 블로그가 `draft` 상태이고, `hugo server` 모드에서는 draft의 블로그가 표시되지 않기 때문입니다.
표시하려면 `hugo server -D`를 사용해야 합니다.
![](https://img.music-poster.art/2025/05/72c092d59ad8143fa61188eac94ace32.png)

이로써 블로그 웹사이트 구축이 완료되었습니다.

### 로컬 블로그를 GitHub에 저장하기
* GitHub에 로그인 한 후 새로운 저장소를 생성합니다 (예: heyjude-blog)
* 로컬 저장소를 원격으로 추가합니다:
```
git remote add origin https://github.com/yourusername/myblog.git
git push
```
이렇게 하면 블로그를 GitHub에 저장할 수 있습니다.

# 참고 링크
1. https://gohugo.io/getting-started/quick-start/
2. https://github.com/olOwOlo/hugo-theme-even
3. https://medium.com/@magstherdev/hugo-in-10-minutes-2dc4ac70ee11
