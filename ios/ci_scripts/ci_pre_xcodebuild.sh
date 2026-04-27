#!/bin/bash
set -e

echo "🚀 [Xcode Cloud] ci_pre_xcodebuild start"

# ── 0. 프로젝트 루트 결정
PROJECT_ROOT="${CI_PRIMARY_REPOSITORY_PATH:-}"
if [ -z "$PROJECT_ROOT" ]; then
    dir="$(pwd)"
    while [[ "$dir" != "/" ]]; do
        [[ -f "$dir/pubspec.yaml" ]] && { PROJECT_ROOT="$dir"; break; }
        dir="$(dirname "$dir")"
    done
fi
[ -z "$PROJECT_ROOT" ] && { echo "❌ pubspec.yaml not found"; exit 1; }
cd "$PROJECT_ROOT"
echo "📁 Project root: $PROJECT_ROOT"

# ── 1. 필수 환경 변수 검증
# Xcode Cloud 워크플로우 설정에서 반드시 선언해야 하는 변수들
REQUIRED_VARS=(
    APP_CHANNEL
    KAKAO_NATIVE_APP_KEY
    API_BASE_URL
    SENTRY_DSN
    SENTRY_ENVIRONMENT
    GOOGLE_SERVICE_INFO_PLIST
)
missing=0
for var in "${REQUIRED_VARS[@]}"; do
    [ -z "${!var}" ] && { echo "❌ Missing env var: $var"; missing=1; }
done
[ $missing -eq 1 ] && exit 1
echo "✅ Environment variables verified (APP_CHANNEL=${APP_CHANNEL})"

# ── 2. dart-define config JSON 생성 (gitignored → CI에서 직접 생성)
mkdir -p config

# SENTRY_RELEASE: 워크플로우에 직접 지정하지 않으면 pubspec.yaml 버전 사용
PUBSPEC_VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')
RELEASE="${SENTRY_RELEASE:-knittda@${PUBSPEC_VERSION}}"

cat > "config/${APP_CHANNEL}.json" << EOF
{
  "KAKAO_NATIVE_APP_KEY": "${KAKAO_NATIVE_APP_KEY}",
  "API_BASE_URL": "${API_BASE_URL}",
  "DIRECTUS_BASE_URL": "${DIRECTUS_BASE_URL:-}",
  "ARTICLE_STATUS": "published",
  "DIRECTUS_STATUS": "published",
  "APP_CHANNEL": "${APP_CHANNEL}",
  "SENTRY_DSN": "${SENTRY_DSN}",
  "SENTRY_ENVIRONMENT": "${SENTRY_ENVIRONMENT}",
  "SENTRY_RELEASE": "${RELEASE}"
}
EOF
echo "✅ config/${APP_CHANNEL}.json created (release=${RELEASE})"

# ── 3. GoogleService-Info.plist 생성 (gitignored → Base64 환경변수에서 복원)
echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > ios/Runner/GoogleService-Info.plist
echo "✅ GoogleService-Info.plist created"

# ── 4. xcconfig local 파일 생성 (gitignored → CI에서 직접 생성)
# beta: Release-beta 빌드 구성이 Debug.xcconfig → Debug-local.xcconfig 를 읽음
# prod: Release 빌드 구성이 Release.xcconfig → Release-local.xcconfig 를 읽음
if [ "$APP_CHANNEL" = "beta" ]; then
    echo "PRODUCT_BUNDLE_IDENTIFIER=com.tteuda.app.beta" > ios/Flutter/Debug-local.xcconfig
    echo "✅ Debug-local.xcconfig → com.tteuda.app.beta"
else
    echo "PRODUCT_BUNDLE_IDENTIFIER=com.example.knittda" > ios/Flutter/Release-local.xcconfig
    echo "✅ Release-local.xcconfig → com.example.knittda"
fi

# ── 6. Flutter 설치 (Xcode Cloud에 Flutter가 없을 경우 대비)
if ! command -v flutter &> /dev/null; then
    echo "⚠️  Flutter not found — installing stable..."
    git clone https://github.com/flutter/flutter.git \
        -b stable --depth 1 "$HOME/flutter"
    export PATH="$HOME/flutter/bin:$PATH"
fi
echo "Flutter: $(flutter --version --machine 2>/dev/null | python3 -c \
    'import sys,json; d=json.load(sys.stdin); print(d["frameworkVersion"])' \
    2>/dev/null || echo "(version check skipped)")"

# ── 7. Flutter 의존성 설치
echo "📦 flutter pub get..."
flutter pub get

echo "🧹 dart run build_runner clean..."
dart run build_runner clean

echo "🧊 dart run build_runner build --delete-conflicting-outputs..."
dart run build_runner build --delete-conflicting-outputs

echo "🔍 Verify generated Dart files..."
if [ ! -f "lib/src/domain/model/announcement.freezed.dart" ] || [ ! -f "lib/src/domain/model/announcement.g.dart" ]; then
    echo "❌ build_runner output missing: .freezed.dart/.g.dart files were not generated"
    exit 1
fi

if ! rg -q "^part of 'announcement\\.dart';" "lib/src/domain/model/announcement.freezed.dart"; then
    echo "❌ Invalid generated file: announcement.freezed.dart is missing part-of declaration"
    exit 1
fi

if ! rg -q "^part of 'announcement\\.dart';" "lib/src/domain/model/announcement.g.dart"; then
    echo "❌ Invalid generated file: announcement.g.dart is missing part-of declaration"
    exit 1
fi

echo "✅ Generated Dart files verified"

echo "🍎 flutter precache --ios..."
flutter precache --ios

# ── 8. CocoaPods 재생성/설치 (xcconfig 누락 방지)
echo "🔧 pod install (clean + repo update)..."
cd ios
rm -rf Pods
pod install --repo-update
cd ..

# ── 9. Flutter 빌드 (Generated.xcconfig에 DART_DEFINES 주입)
# --no-codesign: 코드서명은 Xcode Cloud가 담당
# Xcode Cloud가 이후 xcodebuild archive를 실행할 때 DART_DEFINES가 필요하므로
# 이 단계에서 Generated.xcconfig를 올바르게 생성해 둠
echo "🔨 flutter build ios --no-codesign (DART_DEFINES 생성)..."
if [ "$APP_CHANNEL" = "beta" ]; then
    flutter build ios \
        --release \
        --no-codesign \
        --flavor beta \
        --dart-define-from-file="config/beta.json"
else
    flutter build ios \
        --release \
        --no-codesign \
        --dart-define-from-file="config/prod.json"
fi

echo "✅ ci_pre_xcodebuild completed"
