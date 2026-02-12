<img align="right" src="videos/light_preview.gif#gh-light-mode-only" width="360" />
<img align="right" src="videos/dark_preview.gif#gh-dark-mode-only" width="360" />

<img src="images/gentle_design_showcase_light.png#gh-light-mode-only"
     width="400"
     alt="GentleDesignShowcase" />

<img src="images/gentle_design_showcase_dark.png#gh-dark-mode-only"
     width="400"
     alt="GentleDesignShowcase" />

[![CI](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/gentle-giraffe-apps/GentleDesignShowcase/graph/badge.svg)](https://codecov.io/gh/gentle-giraffe-apps/GentleDesignShowcase)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
![Swift](https://img.shields.io/badge/Swift-6.1+-orange.svg)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-first-blue.svg)](https://developer.apple.com/xcode/swiftui/)
[![Tuist](https://img.shields.io/badge/Generated%20with-Tuist-blueviolet?logo=swift&logoColor=white)](https://tuist.io)
![Commit activity](https://img.shields.io/github/commit-activity/y/gentle-giraffe-apps/GentleDesignShowcase)
![Last commit](https://img.shields.io/github/last-commit/gentle-giraffe-apps/GentleDesignShowcase)

[English](../../README.md) | [Español](README_es.md) | [Português](README_pt.md) | [日本語](README_ja.md) | [简体中文](README_zh-CN.md) | 한국어 | [Русский](README_ru.md)

<p>
  iOS UI 패턴을 탐색하고 디자인 토큰(타이포그래피, 색상, 간격, 서피스)을
  <a href="https://github.com/gentle-giraffe-apps/GentleDesignSystem">GentleDesignSystem</a>으로
  실시간 편집하세요.
</p>

### 기능

- **쇼케이스 갤러리** — 빠른 사전 렌더링 미리보기로 일반적인 iOS UI 패턴 탐색 _(리빌드 불필요)_
- **디자인 에디터** — 색상, 타이포그래피, 간격, 서피스를 포함한 디자인 토큰 실시간 편집 _(변경 사항 즉시 확인)_
- **공유 가능한 스펙** — 타이포그래피 미리보기를 PDF로, 디자인 토큰을 JSON으로 내보내기

### 시작하기

```bash
# mise 설치 (아직 설치하지 않은 경우)
curl https://mise.run | sh

# 프로젝트 디렉토리로 이동
cd GentleDesignShowcase

# Tuist 설치 (mise가 mise.toml의 버전을 사용합니다)
mise install

# Xcode 프로젝트 생성
tuist generate
```

### 워크플로우
1. **Showcase** 탭을 탐색하여 현재 디자인으로 스타일링된 템플릿 확인
2. **Design** 탭으로 전환하여 색상, 타이포그래피 및 기타 토큰 커스터마이즈
3. **Showcase** 탭으로 돌아가기 - 모든 미리보기가 자동으로 새로고침되어 변경 사항 반영
4. 원하는 디자인이 완성될 때까지 반복

### 포함된 템플릿
- **로그인 플로우**: 이메일/비밀번호 필드와 유효성 검사가 포함된 로그인 폼
- **차트 및 통계**: 메트릭과 차트를 활용한 데이터 시각화
- **스토어프론트 그리드**: 이커머스용 상품 그리드 레이아웃
- **온보딩 페이저**: 페이지 형태의 온보딩 경험
- **의료 접수 양식**: 복잡한 다중 섹션 양식
- **프로필 헤더**: 아바타와 액션 버튼이 있는 사용자 프로필

💬 **[토론에 참여하세요. 피드백과 질문을 환영합니다](https://github.com/gentle-giraffe-apps/GentleDesignShowcase/discussions)**

### 요구 사항

- iOS 26.0+
- Xcode 26.0+
- Swift 6.1+

### 라이선스

이 프로젝트는 MIT 라이선스에 따라 사용이 허가됩니다. 자세한 내용은 [LICENSE](../../LICENSE) 파일을 참조하세요.

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fgentle-giraffe-apps%2FGentleDesignShowcase)
