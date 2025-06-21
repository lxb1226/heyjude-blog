---
title: Vercel에서 Umami로 웹사이트 트래픽 통계 쉽게 구현하기
date: 2025-06-15
tags: [Umami, Vercel, Neon, 웹사이트 트래픽 통계, 오픈소스, Hugo, 웹사이트 분석, 데이터 통계, 방문자 통계, Google Analytics 대체품, PostgreSQL, 제로 비용 배포]
categories: [기술 튜토리얼]
keywords: [Umami 배포 튜토리얼, Vercel 무료 배포, Neon 데이터베이스, 웹사이트 트래픽 분석, Google Analytics 대안, 오픈소스 통계 도구, Hugo 블로그 통계, 제로 비용 웹사이트 제작, 웹사이트 방문량 통계, 데이터 프라이버시 보호]
description: 본 문서는 Umami 배포에 대한 자세한 가이드를 제공하며, Vercel의 무료 서비스와 Neon PostgreSQL 데이터베이스를 활용하여 개인 정보 보호에 중점을 둔 웹사이트 방문량 통계 시스템을 신속하게 구축하는 방법을 알려줍니다. 이 제로 비용 솔루션은 개인 블로그와 중소형 사이트에 특히 적합하며, Google Analytics보다 가볍고 개인 정보 보호에 중점을 둔 통계 서비스를 제공합니다. Vercel의 Serverless 아키텍처를 통해 웹사이트 트래픽 모니터링을 쉽게 구현할 수 있으며, Hugo와 같은 정적 웹사이트와 완전히 호환됩니다.
---

Umami는 간단하고 빠르며 개인 정보 보호에 중점을 둔 오픈소스 웹사이트 통계 도구로, Google Analytics의 이상적인 대안입니다. 본 문서는 Vercel에서 Umami를 배포하는 방법과 Vercel Storage를 통해 Neon PostgreSQL 데이터베이스를 만드는 방법을 안내하여 제로 비용의 경량 웹사이트 트래픽 통계 시스템을 구축하는 방법을 설명합니다. 본 튜토리얼은 Hugo 정적 웹사이트 사용자를 위해 특별히 최적화되어, 생성된 Markdown 파일이 Hugo의 정적 웹페이지 생성에 적합하도록 보장합니다.

## 서론

개인 블로그나 중소형 웹사이트의 경우 Google Analytics는 과도하게 복잡할 수 있으며, 일부 지역에서는 접근이 불편할 수 있습니다. Umami는 간결한 인터페이스와 핵심 지표를 제공하여 가벼운 트래픽 분석 요구에 매우 적합합니다. Vercel의 Serverless 배포와 Vercel Storage와 통합된 Neon 데이터베이스를 통해 우리는 서버 유지 관리 비용없이 높은 효율의 통계 시스템을 신속하게 구축할 수 있습니다.

다음은 자세한 배포 단계입니다.

## 준비 작업

시작하기 전에 다음 내용을 준비했는지 확인하십시오:

1. **GitHub 계정**: Umami 저장소를 Fork하는 데 사용됩니다.
2. **Vercel 계정**: Umami를 배포하고 Neon 데이터베이스를 만드는 데 사용됩니다.
3. **Neon 계정**: 등록되어 있어야 하며 Vercel Storage와 연결하기 위해 사용됩니다.
4. Umami의 추적 코드를 삽입할 실행 중인 Hugo 웹사이트(또는 기타 정적 웹사이트).

## 단계 1: Umami 저장소 Fork하기

1. Umami 공식 GitHub 저장소에 방문합니다: [https://github.com/umami-software/umami](https://github.com/umami-software/umami).
2. 우측 상단의 **Fork** 버튼을 클릭하여 저장소를 당신의 GitHub 계정으로 Fork합니다.
3. (선택) Umami를 사용자 지정해야 하는 경우, 저장소를 로컬로 클론하여 수정할 수 있지만, 본 튜토리얼은 기본 구성 사용을 권장합니다.

## 단계 2: Vercel에서 Umami 배포하기

1. [Vercel 공식 사이트](https://vercel.com/)에 로그인한 후, **Add New** > **Project**를 클릭합니다.
2. **Import Git Repository** 페이지에서 방금 Fork한 Umami 저장소를 선택합니다.
3. 프로젝트 구성:
   - **Framework Preset**: **Next.js**를 선택합니다 (Umami는 Next.js로 구축됨).
   - **Environment Variables**: 잠시 생략하고, 후에 Neon 데이터베이스의 `DATABASE_URL`을 구성합니다.
4. **Deploy** 버튼을 클릭하면 Vercel이 자동으로 프로젝트를 빌드합니다 (이 시점에서 데이터베이스 연결이 없어 실패할 수 있으며, 나중에 수정합니다).

## 단계 3: Vercel Storage에서 Neon 데이터베이스 만들기

1. Vercel 대시보드에서 Umami 프로젝트로 이동합니다.
2. 상단 내비게이션의 **Storage** 탭을 클릭한 후, **Create Database**를 선택합니다.
![](https://img.music-poster.art/2025/06/cba773362305001171fb5d0defb4f960.png)
3. 데이터베이스 유형에서 **Neon**을 선택하고, Vercel이 액세스할 수 있도록 Neon 계정에 로그인하여 권한을 부여합니다.
4. 데이터베이스 구성:
   - **프로젝트 이름**: 임의로 설정 (예: `umami-project`).
   - **데이터베이스 이름**: `umami`를 사용하는 것이 좋습니다.
   - **클라우드 서비스 제공업체**: 지연을 줄이기 위해 해당 지역(예: AWS 아시아 지역)을 선택합니다.
5. 생성 완료 후, Vercel이 자동으로 **DATABASE_URL**을 생성하고 프로젝트의 환경 변수에 추가합니다. 형식은 다음과 같습니다:
   ```
   postgresql://[username]:[password]@[host]/[database]
   ```
6. 프로젝트 설정으로 돌아가, **Environment Variables**에 `DATABASE_URL`이 포함되어 있는지 확인합니다.
7. 프로젝트를 다시 배포합니다: **Deployments** 탭을 클릭하고 최신 배포를 선택한 다음 **Redeploy**를 클릭합니다.

## 단계 4: Umami 구성하기

1. 배포가 완료되면 **Visit**를 클릭하여 Umami 인스턴스를 확인하고, 할당된 기본 도메인(예: `your-project.vercel.app`)을 기록합니다.
2. Umami 웹사이트에 접속하고, 첫 로그인 시 기본 계정은 다음과 같습니다:
   - 사용자 이름: `admin`
   - 비밀번호: `umami`
3. 로그인 후 즉시 비밀번호를 변경하여 보안을 확보합니다.
4. Umami 대시보드에서 **Add Website**를 클릭하고 웹사이트 정보를 입력합니다(예: 도메인, 이름).
![](https://img.music-poster.art/2025/06/2b0b37c13001ea761ffcd370f170defc.png)
5. Umami는 다음과 같은 JavaScript 추적 코드를 생성합니다:
   ```html
   <script async src="https://your-project.vercel.app/umami.js" data-website-id="YOUR_WEBSITE_ID"></script>
   ```
   이 코드를 복사합니다.

## 단계 5: Hugo 웹사이트에 추적 코드 삽입하기

Umami가 당신의 Hugo 웹사이트 트래픽을 통계적으로 수집하려면 추적 코드를 웹사이트에 삽입해야 합니다. 이 과정은 사용 중인 Hugo 테마가 지원해야 하며, 지원하지 않을 경우 테마를 직접 수정해야 합니다.

여기서는 [hugo-narrow](https://github.com/luizdepra/hugo-narrow) 테마를 사용하는데, Umami 구성을 지원하므로 `hugo.yaml` 파일에서 다음과 같이 설정합니다:
```yaml
  analytics:
    enabled: true
    umami: 
      enabled: true
      id: "YOUR_WEBSITE_ID"
      src: "https://your-project.vercel.app/umami.js"
      domains: ""
```
여기서 `YOUR_WEBSITE_ID`는 Umami에서 생성한 웹사이트 ID로 변경합니다. `src` 또한 Vercel에서 배포한 Umami 프로젝트 도메인으로 변경해야 합니다.

그 후 당신의 웹사이트에 접속하면 Umami가 트래픽 데이터를 수집하기 시작합니다.

## 단계 6: 검증 및 최적화

1. Umami 대시보드로 돌아가 몇 분 기다린 후 트래픽 데이터 기록이 있는지 확인합니다.
2. 추적 코드가 정상적으로 작동하는지 검증합니다:
   - 브라우저의 개발자 도구(F12)를 열고 **Network** 탭으로 전환한 후 페이지를 새로 고칩니다. `your-project.vercel.app/api/collect`에 대한 요청이 있는지 확인합니다.
3. (선택) Umami 대시보드를 사용자 정의합니다:
   - 여러 웹사이트를 추가하여 추적합니다.
   - 데이터 공유 링크를 구성하여 팀과 통계 데이터를 공유할 수 있도록 합니다.
   - Umami의 테마 또는 언어 설정을 조정하여 한글 인터페이스를 지원합니다.

## 주의 사항

- **Neon 무료 한도**: Vercel Storage를 통해 생성된 Neon 데이터베이스는 저장 및 계산 시간에 대한 제한이 있으며, 소형 웹사이트에 적합합니다. 트래픽이 많을 경우 유료 계획으로 업그레이드를 고려하세요.
- **Vercel 무료 한도**: Vercel의 무료 플랜은 매월 100GB 대역폭을 제공하며, 대부분의 개인 웹사이트 요구를 충족할 수 있습니다.
- **개인 정보 준수**: Umami는 개인 정보 보호에 중점을 두지만 귀하의 웹사이트가 GDPR 또는 기타 개인 정보 보호 법규(예: 유럽 연합에서 운영 시)를 준수하는지 확인해야 합니다.
- **보안**: Neon 데이터베이스를 정기적으로 백업하고 Umami의 관리자 계정에서 강력한 비밀번호를 사용해야 합니다.

## 결론

Vercel과 통합된 Neon 데이터베이스를 통해 몇 분 만에 강력하고 제로 비용의 웹사이트 트래픽 통계 시스템을 구축할 수 있습니다. Umami의 간결한 인터페이스와 핵심 기능은 Hugo 블로그 사용자에게 매우 적합하며, 방문량 통계, 출처 분석 또는 페이지 성능 모니터링 등 모든 요구를 충족할 수 있습니다.

질문이 있거나 추가 최적화가 필요하다면 댓글로 소통해 주세요! 이 튜토리얼이 웹사이트 트래픽에 대한 이해를 돕기를 바랍니다.

## 참고 자료

- Umami 공식 문서: [https://umami.is/docs](https://umami.is/docs)
- Vercel Storage 문서: [https://vercel.com/docs/storage](https://vercel.com/docs/storage)
- Neon 데이터베이스 구성 가이드: [https://neon.tech/docs](https://neon.tech/docs)
- Hugo 문서: [https://gohugo.io/documentation/](https://gohugo.io/documentation/)