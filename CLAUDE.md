# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

iOS 17+와 macOS 14+ 크로스플랫폼을 지원하는 SwiftUI 디자인 컴포넌트 라이브러리입니다.

## 빌드 명령어

grep 활용하여 불필요한 정보 거르기

```bash
# 빌드
swift build
```

### 크로스플랫폼 호환성

- UIKit/AppKit 전용 API(예: `UIColor.systemGray5`) 대신 SwiftUI 네이티브 컬러 사용

## 작업 지침

- 항상 한국어로 답변.
- 애니메이션 끝난 뒤 동작은 withAnimation의 completion을 쓰도록 한다. DispatchQueue나 Task.sleep은 사용하지 않는다.
- 대기가 필요할 때엔 DispatchQueue를 쓰지 않고 Task.sleep을 쓴다.
- MainActor.run 사용 금지. 이미 View들이 MainActor에 격리되어 있으므로 Task는 MainActor를 자동 상속함.
