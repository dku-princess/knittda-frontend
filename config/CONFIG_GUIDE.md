# Config 환경변수 가이드

## config/ 파일 구조

| 파일 | 사용 시나리오 | 명령어 예시 |
|---|---|---|
| `beta.run.json` | 로컬 디버그 실행 (beta 서버) | `flutter run --dart-define-from-file=config/beta.run.json` |
| `beta.release.json` | 로컬 릴리즈 빌드 (beta 서버) | `flutter build ios --release --dart-define-from-file=config/beta.release.json` |
| `prod.run.json` | 로컬 디버그 실행 (prod 서버) | `flutter run --dart-define-from-file=config/prod.run.json` |
| `prod.release.json` | 로컬 릴리즈 빌드 (prod 서버) | `flutter build ios --release --dart-define-from-file=config/prod.release.json` |
| `example.run.json` | 신규 개발자 템플릿 (run용) | 복사 후 키 값 채워서 사용 |
| `example.release.json` | 신규 개발자 템플릿 (release용) | 복사 후 키 값 채워서 사용 |

> `beta.run.json`, `beta.release.json`, `prod.run.json`, `prod.release.json` 은 `.gitignore` 처리되어 있어 커밋되지 않습니다.
> `example.*.json` 만 git에 추적됩니다.

---

## run vs release 차이

| 항목 | `*.run.json` | `*.release.json` |
|---|---|---|
| Flutter 모드 | debug (`flutter run`) | release (`flutter build`) |
| Sentry 동작 | 꺼짐 (`kDebugMode`) | 켜짐 |
| `SENTRY_ENVIRONMENT` | 불필요 (미포함) | 포함 (`beta` / `production`) |
| `DIRECTUS_STATUS` (beta) | `published,draft,archived` | `published,draft,archived` |
| `DIRECTUS_STATUS` (prod) | `published` | `published` |

---

## DIRECTUS_STATUS 동작

| 값 | Directus 쿼리 | 결과 |
|---|---|---|
| `"published"` | `filter[status][_in]=published` | 배포된 콘텐츠만 |
| `"published,draft,archived"` | `filter[status][_in]=published,draft,archived` | 전체 상태 |
| `""` (빈값) | 필터 파라미터 미포함 | Directus 토큰 권한에 위임 |

---

## xcconfig 역할

xcconfig는 `config/*.json`과 **별개로** iOS Xcode Build Settings를 담당합니다.

| 파일 | 역할 |
|---|---|
| `ios/Flutter/Debug.xcconfig` | debug 빌드용 Pods + Flutter 설정 포함 |
| `ios/Flutter/Release.xcconfig` | release 빌드용 Pods + Flutter 설정 포함 |
| `ios/Flutter/Debug-local.xcconfig` | 로컬 전용 bundle ID 오버라이드 (`com.tteuda.app.beta`) |
| `ios/Flutter/Release-local.xcconfig` | 로컬 전용 bundle ID 오버라이드 |

### xcconfig vs config/*.json 비교

| | `config/*.json` | `xcconfig` |
|---|---|---|
| 용도 | Flutter dart-define (앱 로직) | Xcode Build Settings (iOS 빌드) |
| 사용처 | `AppConfig.*` (Dart 코드) | `Info.plist`, Bundle ID 등 |
| 예시 | API URL, Sentry DSN, DIRECTUS_STATUS | `kakaoNativeAppKey` (URL Scheme) |

> `KAKAO_NATIVE_APP_KEY`는 두 곳에 모두 필요합니다.
> - `config/*.json` → Dart 코드에서 SDK 초기화용
> - `xcconfig` → Info.plist URL Scheme 등록용 (카카오 로그인 딥링크)

---

## Xcode Cloud 빌드 흐름

Xcode Cloud는 `config/*.json`을 사용하지 않고, `ci_post_clone.sh`가 Xcode Cloud 환경변수로부터 `config/env.json`을 직접 생성합니다.

```
Xcode Cloud 환경변수
  ↓ ci_post_clone.sh
config/env.json   ←  flutter build --dart-define-from-file=config/env.json
xcconfig          ←  kakaoNativeAppKey 직접 주입 (Info.plist용)
```

### Xcode Cloud Workflow별 환경변수 설정

| 변수 | beta Workflow | prod Workflow |
|---|---|---|
| `KAKAO_NATIVE_APP_KEY` (`kakaoNativeAppKey`) | beta 키 | prod 키 |
| `API_BASE_URL` | beta 서버 | prod 서버 |
| `DIRECTUS_BASE_URL` | Directus 서버 | Directus 서버 |
| `DIRECTUS_STATUS` | `published,draft,archived` | `published` |
| `SENTRY_DSN` | Sentry DSN | Sentry DSN |
| `SENTRY_ENVIRONMENT` | `beta` | `production` |
