---
title: "맥에서 모바일 인증 코드를 자동으로 채우는 방법"
date: 2025-05-07T22:36:09+08:00
lastmod: 2025-05-07T22:36:09+08:00
draft: false
keywords: ["맥 인증 코드", "자동 채우기", "MessAuto", "AutoCode", "아이폰 동기화", "SMS 인증 코드", "효율 도구", "자동화 도구"]
description: "Mac 컴퓨터에서 MessAuto 도구를 구성하고 사용하는 방법을 상세히 설명하여, 아이폰 모바일 인증 코드를 자동으로 동기화하고 채우는 실용적인 튜토리얼입니다."
tags: ["Mac", "효율 도구", "MessAuto", "자동화", "아이폰", "인증 코드 동기화"]
categories: ["효율 도구", "기술 튜토리얼", "Mac 애플리케이션"]
author: "heyjude"

# 이 컨텐츠를 위해 무언가를 닫거나 열 수 있습니다.
# P.S. 댓글은 닫을 수만 있습니다.
comment: true
toc: true
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# 다른 contentCopyright를 정의할 수 있습니다. 예: contentCopyright: "다른 저작권입니다."
contentCopyright: false
reward: true
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# 헤더나 푸터를 표시하지 않으려는 비공식 게시물
hideHeaderAndFooter: false

# 개별 게시물에 대해 구식 콘텐츠 경고를 활성화 또는 비활성화할 수 있습니다.
# 이를 주석 처리하면 전역 구성이 사용됩니다.
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""

---

# 이유
우리는 iOS가 SMS 인증 코드의 자동 채우기를 지원한다는 것을 알고 있으며, 맥에서도 사파리는 이를 지원하지만, 비사파리 브라우저에서는 지원하지 않습니다. 그러나 국내 플랫폼에서는 인증 코드가 피할 수 없는 것이므로, 이에 대해 조사해보았고 현재 사용 가능한 몇 가지 솔루션을 찾았습니다.

* [AutoCode](https://apps.apple.com/cn/app/id6472872202)： App Store에서 무료로 사용할 수 있는 소프트웨어로, iOS와 안드로이드 간의 전송을 지원합니다.
* [MessAuto](https://github.com/LeeeSe/MessAuto)： MessAuto는 macOS 플랫폼에서 SMS 및 이메일 인증 코드를 자동으로 추출하는 소프트웨어로, Rust로 개발되었으며 모든 앱에 적합합니다.

MessAuto는 오픈 소스이기 때문에 이 소프트웨어를 선택했습니다.

# MessAuto 사용하기
MessAuto는 오픈 소스 소프트웨어이며, 저자가 배포나 서명을 하지 않았기 때문에 직접 컴파일해야 합니다.

## 1. 컴파일

```bash
# 소스 코드 다운로드
git clone https://github.com/LeeeSe/MessAuto.git
cd MessAuto

# cargo-bundle 설치
cargo install cargo-bundle --git https://github.com/zed-industries/cargo-bundle.git --branch add-plist-extension
# 애플리케이션 패키징
cargo bundle --release
```
설치가 완료되면 현재 디렉토리의 `target/release/bundle/osx/MessAuto.app`에 빌드 패키지가 생성됩니다.
![](https://img.music-poster.art/2025/05/c090074301dfda862dea2b0797bcdeec.png)

## 2. 사용
ARM64 버전을 열 때 파일 손상 경고가 표시됩니다. Apple 개발자 서명이 필요하기 때문이며, 저자는 Apple 개발자 인증서가 없습니다. 그러나 다음 명령을 사용하여 문제를 해결할 수 있습니다:
* MessAuto.app를 /Applications 폴더로 이동
* 터미널에서 xattr -cr /Applications/MessAuto.app 실행

이렇게 하면 해당 앱을 사용할 수 있습니다.

## 3. 사용법
프로그램이 정상적으로 작동하려면 사용자가 iOS에서 "SMS 포워딩" 기능을 활성화해야 합니다. 설정 > 메시지 > iMessage 정보에서 확인할 수 있습니다.
![](https://img.music-poster.art/2025/05/20e37bdec4c71f08fe4605b2534b2113.jpeg)

MessAuto는 GUI가 없는 메뉴바 소프트웨어로, 처음 실행할 때 MessAuto가 사용자에게 전체 디스크 접근 권한을 부여하라는 팝업을 띄우고, 권한을 부여한 후 시스템에서 소프트웨어를 다시 열 것을 요구합니다. 메뉴바에서 해당 소프트웨어를 확인할 수 있습니다. 기능은 다음과 같습니다:
* 자동 붙여넣기: MessAuto는 감지된 인증 코드를 클립보드에 저장하며, 사용자가 인증 코드를 입력할 때 수동으로 붙여넣고 싶지 않다면 이 옵션을 활성화할 수 있습니다. 옵션을 활성화하면 MessAuto가 보조 기능 권한 부여를 요청합니다.
* 자동 Enter: 인증 코드를 자동으로 붙여넣은 후 자동으로 Enter 키를 누릅니다.
* 클립보드 사용하지 않음: MessAuto는 현재 클립보드의 내용을 영향을 주지 않으며, 붙여넣기 후에는 이전 클립보드 내용을 자동으로 복원합니다. 이 기능이 활성화될 경우 자동 붙여넣기 기능이 자동으로 활성화됩니다.
* 일시 숨기기: 아이콘을 일시적으로 숨기고, 애플리케이션 재시작 시 아이콘이 다시 나타납니다(백그라운드에서 먼저 종료해야 함), 자주 맥을 재시작하지 않는 사용자에게 적합합니다.
* 영구 숨기기: 아이콘을 영구적으로 숨기고, 애플리케이션 재시작 후에도 아이콘이 표시되지 않습니다. 자주 맥을 재시작하는 사용자에게 적합하며, 아이콘을 다시 표시하려면 ~/.config/messauto/messauto.json 파일을 편집하여 hide_forever를 false로 설정하고 애플리케이션을 재시작해야 합니다.
* 설정: 클릭하면 JSON 형식의 설정 파일이 열리며, 여기에서 키워드를 사용자 정의할 수 있습니다.
* 로그: 로그를 빠르게 열 수 있습니다.
* 이메일 수신 대기: 활성화하면 이메일을 동시에 수신 대기하며, 이메일 앱이 백그라운드에서 항상 실행되어야 합니다.
* 플로팅 창: 인증 코드를 수신한 후 편리한 플로팅 창이 뜹니다.

여기서는 **자동 붙여넣기**, **로그인 시 시작**을 활성화하는 것이 좋습니다. 블로거는 현재 이메일 수신 대기 필요가 없으므로 이메일 수신 대기를 활성화하지 않았습니다. 필요할 경우 활성화할 수 있습니다.

# 참고 자료
1. https://github.com/LeeeSe/MessAuto

