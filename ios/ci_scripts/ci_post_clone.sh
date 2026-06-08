#!/bin/bash
set -e

echo "🚀 [Xcode Cloud] ci_post_clone start"

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
    APP_BUNDLE_ID
    KAKAO_NATIVE_APP_KEY
    API_BASE_URL
    DIRECTUS_BASE_URL
    DIRECTUS_STATUS
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

cat > "config/env.json" << EOF
{
  "KAKAO_NATIVE_APP_KEY": "${KAKAO_NATIVE_APP_KEY}",
  "API_BASE_URL": "${API_BASE_URL}",
  "DIRECTUS_BASE_URL": "${DIRECTUS_BASE_URL}",
  "DIRECTUS_STATUS": "${DIRECTUS_STATUS}",
  "SENTRY_DSN": "${SENTRY_DSN}",
  "SENTRY_ENVIRONMENT": "${SENTRY_ENVIRONMENT}",
  "SENTRY_RELEASE": "${RELEASE}"
}
EOF
echo "✅ config/env.json created (channel=${APP_CHANNEL}, release=${RELEASE}, status='${DIRECTUS_STATUS}')"

# ── 3. GoogleService-Info.plist 생성 (gitignored → Base64 환경변수에서 복원)
echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > ios/Runner/GoogleService-Info.plist
echo "✅ GoogleService-Info.plist created"

# ── 4. Bundle ID 교체
# project.pbxproj 타겟 레벨 설정이 xcconfig를 오버라이드하므로 sed로 직접 교체
# RunnerTests 타겟은 변경하지 않는다
PBXPROJ="$PROJECT_ROOT/ios/Runner.xcodeproj/project.pbxproj"
sed -i '' "/RunnerTests/!s/PRODUCT_BUNDLE_IDENTIFIER = .*;/PRODUCT_BUNDLE_IDENTIFIER = $APP_BUNDLE_ID;/" "$PBXPROJ"
echo "✅ Bundle ID → $APP_BUNDLE_ID"

# ── 5. xcconfig에 kakaoNativeAppKey 주입
# Info.plist의 $(kakaoNativeAppKey)는 dart-define이 아닌 Xcode Build Settings에서 값을 참조
# 누락 시 빈 값으로 빌드되어 카카오 로그인이 동작하지 않음
echo "kakaoNativeAppKey=${KAKAO_NATIVE_APP_KEY}" >> "$PROJECT_ROOT/ios/Flutter/Debug.xcconfig"
echo "kakaoNativeAppKey=${KAKAO_NATIVE_APP_KEY}" >> "$PROJECT_ROOT/ios/Flutter/Release.xcconfig"
echo "✅ xcconfig updated (kakaoNativeAppKey injected)"

# ── 6. Flutter 설치 (Xcode Cloud에 Flutter가 없을 경우 대비)
if ! command -v flutter &> /dev/null; then
    echo "⚠️  Flutter not found — installing stable..."
    git clone https://github.com/flutter/flutter.git \
        -b stable --depth 1 "$HOME/flutter"
    export PATH="$HOME/flutter/bin:$PATH"
fi
echo "Flutter: $(flutter --version 2>/dev/null | head -1)"

# ── 7. Flutter 의존성 설치
echo "📦 flutter pub get..."
flutter pub get

echo "🧹 dart run build_runner clean..."
dart run build_runner clean

echo "🧊 dart run build_runner build --delete-conflicting-outputs..."
dart run build_runner build --delete-conflicting-outputs

echo "🔍 Generated Dart files 검증..."
if [ ! -f "lib/src/domain/model/announcement.freezed.dart" ] || [ ! -f "lib/src/domain/model/announcement.g.dart" ]; then
    echo "❌ build_runner output missing: .freezed.dart/.g.dart files were not generated"
    exit 1
fi

if ! grep -q "^part of 'announcement\.dart';" "lib/src/domain/model/announcement.freezed.dart"; then
    echo "❌ Invalid generated file: announcement.freezed.dart is missing part-of declaration"
    exit 1
fi

if ! grep -q "^part of 'announcement\.dart';" "lib/src/domain/model/announcement.g.dart"; then
    echo "❌ Invalid generated file: announcement.g.dart is missing part-of declaration"
    exit 1
fi

echo "✅ Generated Dart files verified"

echo "🍎 flutter precache --ios..."
flutter precache --ios

# ── 8. Flutter 빌드 설정 생성 (Generated.xcconfig에 DART_DEFINES 주입)
# --no-codesign: 코드서명은 Xcode Cloud가 담당
echo "🔨 flutter build ios --no-codesign (DART_DEFINES 생성)..."
flutter build ios \
    --release \
    --no-codesign \
    --dart-define-from-file="config/env.json" \
    --config-only

# ── 9. CocoaPods 재생성/설치 (xcconfig 누락 방지)
echo "🔧 pod install (clean + repo update)..."
cd ios
rm -rf Pods
pod install --repo-update
cd ..

# ── 10. SPM 의존성 resolve (Xcode Cloud는 자동 resolve가 비활성화됨)
echo "📦 Resolve Swift Package Manager dependencies..."
xcodebuild -resolvePackageDependencies \
    -workspace ios/Runner.xcworkspace \
    -scheme Runner \
    -configuration Release || {
    echo "⚠️  SPM resolve failed; continuing (Package.resolved이 commit되어 있다면 정상 진행 가능)"
}

echo "✅ ci_post_clone completed"
