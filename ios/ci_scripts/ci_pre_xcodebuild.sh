#!/bin/bash
set -e
echo "[Xcode Cloud] Pre-build: Setting up Flutter & CocoaPods"

# 프로젝트 루트 찾기 (pubspec.yaml이 있는 곳)
find_project_root() {
    local current_dir=$(pwd)
    
    while [[ "$current_dir" != "/" ]]; do
        if [[ -f "$current_dir/pubspec.yaml" ]]; then
            echo "✅ Found project root: $current_dir"
            cd "$current_dir"
            return 0
        fi
        current_dir=$(dirname "$current_dir")
    done
    
    echo "❌ Could not find project root (pubspec.yaml)"
    return 1
}

# 프로젝트 루트로 이동
find_project_root

# 환경 변수에서 lib/env.dart 자동 생성
echo "📁 Generating lib/env.dart from CI environment variables..."

# 환경 변수 확인 (Xcode Cloud에서 설정해야 함)
if [ -z "$API_BASE_URL" ] || [ -z "$kakaoNativeAppKey" ] || [ -z "$SENTRY_DSN" ]; then
  echo "❌ Error: Required environment variables are not set!"
  echo "Please set the following environment variables in Xcode Cloud:"
  echo "  - API_BASE_URL"
  echo "  - kakaoNativeAppKey"
  echo "  - SENTRY_DSN"
  exit 1
fi

# lib/env.dart 파일 생성
cat <<EOF > lib/env.dart
// 환경 변수 및 설정 상수 (CI에서 자동 생성됨)
class Env {
  // Kakao SDK 설정
  static const String kakaoNativeAppKey = '$kakaoNativeAppKey';
  
  // Sentry 설정
  static const String SentryFlutterDns = '$SENTRY_DSN';
  
  // API 설정
  static const String apiBaseUrl = '$API_BASE_URL';
  
  // 기타 환경 설정
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool isDebug = !isProduction;
}
EOF

echo "✅ Generated lib/env.dart with environment variables:"
echo "   - API_BASE_URL: $API_BASE_URL"
echo "   - kakaoNativeAppKey: ${kakaoNativeAppKey:0:10}..."
echo "   - SENTRY_DSN: ${SENTRY_DSN:0:30}..."

# Flutter 설치 (Cloud 환경 초기 상태 대응용)
if ! command -v flutter &> /dev/null; then
  echo "⚠️ Flutter not found. Installing..."
  git clone https://github.com/flutter/flutter.git -b stable
  export PATH="$PATH:$(pwd)/flutter/bin"
fi 

# Flutter 의존성 설치
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Flutter iOS 프리캐시 (CocoaPods 설치 전 필요)
echo "🍎 Pre-caching Flutter iOS artifacts..."
flutter precache --ios

# iOS 디렉토리로 이동
if [ -d "ios" ]; then
  cd ios
elif [ -d "../ios" ]; then
  cd ../ios
else
  echo "❌ iOS directory not found"
  exit 1
fi

# ⚠️ Xcode Cloud에서는 workspace를 삭제/재생성하지 않음
# Cloud는 이미 build graph를 계산한 상태이므로 구조를 건드리면 안 됨
# pod install만 실행 (workspace가 없으면 자동 생성, 있으면 업데이트)
echo "🔧 Running pod install..."
pod install

echo "✅ Pre-xcodebuild completed successfully" 