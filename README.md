# Knittda

뜨개질 프로젝트를 관리하고 공유할 수 있는 Flutter 모바일 애플리케이션입니다.

## 📱 주요 기능

### 🧶 프로젝트 관리
- **작품 등록**: 뜨개질 작품을 등록하고 관리
- **진행 상황 추적**: 시작일, 목표일, 완료일 설정 및 관리
- **상세 정보**: 실 정보, 바늘 정보, 디자인 정보 등 상세 기록

### 📝 기록 관리
- **진행 기록**: 작품의 진행 상황을 사진과 함께 기록
- **태그 시스템**: 기록에 태그를 추가하여 분류

### 👥 소셜 기능
- **피드**: 다른 사용자들의 작품과 기록을 피드로 확인
- **검색**: 작품명, 태그 등으로 검색
- **카카오 로그인**: 카카오 계정으로 간편 로그인

### 🎨 사용자 경험
- **직관적인 UI**: 사용하기 쉬운 인터페이스
- **Pretendard 폰트**: 깔끔하고 가독성 좋은 한글 폰트
- **반응형 디자인**: 다양한 화면 크기에 최적화

## 🛠 기술 스택

- **Flutter**: 크로스 플랫폼 모바일 개발
- **Dart**: 프로그래밍 언어
- **Provider**: 상태 관리
- **Dio**: HTTP 클라이언트
- **Kakao Flutter SDK**: 카카오 로그인
- **Image Picker**: 이미지 선택 및 촬영
- **Sentry**: 에러 추적 및 모니터링

## 📦 주요 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  kakao_flutter_sdk_user: 1.9.6
  provider: ^6.1.5
  dio: ^5.8.0+1
  image_picker: ^1.1.2
  sentry_flutter: ^8.14.2
  flutter_secure_storage: ^8.0.0
  shared_preferences: ^2.5.3
  intl: ^0.18.0
  path_provider: ^2.0.15
```

## 🚀 시작하기

### 필수 요구사항
- Flutter SDK 3.7.0 이상
- Dart SDK
- Android Studio / VS Code
- iOS 개발을 위한 Xcode (macOS)

### 설치 및 실행

1. **저장소 클론**
   ```bash
   git clone [repository-url]
   cd knittda-frontend-fv
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **환경 설정**
   - `env.dart` 파일을 생성하고 필요한 API 키들을 설정
   - 카카오 네이티브 앱 키 설정
   - Sentry DSN 설정

4. **앱 실행**
   ```bash
   flutter run
   ```

## 📁 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── src/
│   ├── app.dart             # 앱 설정
│   ├── core/                # 핵심 유틸리티
│   │   ├── constants/       # 상수 정의
│   │   ├── storage/         # 로컬 저장소
│   │   └── utils/           # 유틸리티 함수
│   ├── data/                # 데이터 레이어
│   │   ├── data_sources/    # 데이터 소스
│   │   ├── models/          # 데이터 모델
│   │   └── repositories/    # 리포지토리
│   ├── domain/              # 도메인 레이어
│   │   └── use_case/        # 유스케이스
│   ├── di/                  # 의존성 주입
│   └── presentation/        # 프레젠테이션 레이어
│       ├── screens/         # 화면
│       ├── view_models/     # 뷰모델
│       └── widgets/         # 위젯
```

## 📱 지원 플랫폼

- **Android**: API 21 이상
- **iOS**: iOS 12.0 이상

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 문의

프로젝트에 대한 문의사항이 있으시면 이슈를 생성해 주세요.
