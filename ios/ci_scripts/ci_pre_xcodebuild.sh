#!/bin/bash
set -e
echo "[Xcode Cloud] Pre-build: Setting up Flutter & CocoaPods"

# 현재 디렉토리 확인
echo "Current directory: $(pwd)"
echo "Directory contents:"
ls -la

# 프로젝트 루트 찾기 (pubspec.yaml이 있는 곳)
find_project_root() {
    local current_dir=$(pwd)
    echo "🔍 Looking for project root from: $current_dir"
    
    # 현재 디렉토리부터 상위로 올라가면서 pubspec.yaml 찾기
    while [[ "$current_dir" != "/" ]]; do
        if [[ -f "$current_dir/pubspec.yaml" ]]; then
            echo "✅ Found project root at: $current_dir"
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

# Flutter 환경 확인
echo "🔍 Checking Flutter environment..."
flutter doctor --verbose

# 프로젝트 루트에서 실행되므로 pubspec.yaml 접근 가능
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Flutter iOS 프리캐시 (CocoaPods 설치 전 필요)
echo "🍎 Pre-caching Flutter iOS artifacts..."
flutter precache --ios

# iOS 디렉토리 찾기 및 이동
echo "🍎 Looking for iOS directory..."
if [ -d "ios" ]; then
  echo "✅ iOS directory found at: $(pwd)/ios"
  cd ios
elif [ -d "../ios" ]; then
  echo "✅ iOS directory found at: $(pwd)/../ios"
  cd ../ios
elif [ -d "../../ios" ]; then
  echo "✅ iOS directory found at: $(pwd)/../../ios"
  cd ../../ios
else
  echo "❌ iOS directory not found"
  echo "Available directories:"
  ls -la
  echo "Parent directories:"
  ls -la ../
  echo "Grandparent directories:"
  ls -la ../../
  exit 1
fi

echo "Current directory after cd: $(pwd)"
echo "iOS directory contents:"
ls -la

# 기존 워크스페이스 제거 (깨끗한 상태에서 시작)
if [ -d "Runner.xcworkspace" ]; then
  echo "🧹 Removing existing workspace..."
  rm -rf Runner.xcworkspace
fi

# CocoaPods 설치 (워크스페이스 생성)
echo "🔧 Installing CocoaPods and generating workspace..."
pod install

# 워크스페이스 생성 확인
if [ -d "Runner.xcworkspace" ]; then
  echo "✅ Workspace created successfully: Runner.xcworkspace"
  ls -la Runner.xcworkspace/
  echo "Workspace path: $(pwd)/Runner.xcworkspace"
else
  echo "❌ Failed to create workspace"
  exit 1
fi

# 코드 서명 완전 비활성화 (iOS 18.5 SDK 호환성)
echo "🔐 Disabling code signing for iOS 18.5 compatibility..."
cd Runner.xcodeproj
if [ -f "project.pbxproj" ]; then
  echo "📝 Modifying project settings to disable code signing..."
  # CODE_SIGN_IDENTITY를 "-"로 변경
  sed -i '' 's/"CODE_SIGN_IDENTITY\[sdk=iphoneos\*\]" = "iPhone Developer";/"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "-";/g' project.pbxproj
  # CODE_SIGN_STYLE을 Manual로 변경
  sed -i '' 's/CODE_SIGN_STYLE = Automatic;/CODE_SIGN_STYLE = Manual;/g' project.pbxproj
  # CODE_SIGNING_REQUIRED를 NO로 설정
  sed -i '' 's/CODE_SIGNING_REQUIRED = YES;/CODE_SIGNING_REQUIRED = NO;/g' project.pbxproj
  # CODE_SIGNING_ALLOWED를 NO로 설정
  sed -i '' 's/CODE_SIGNING_ALLOWED = YES;/CODE_SIGNING_ALLOWED = NO;/g' project.pbxproj
  # AD_HOC_CODE_SIGNING_ALLOWED를 NO로 설정
  sed -i '' 's/AD_HOC_CODE_SIGNING_ALLOWED = YES;/AD_HOC_CODE_SIGNING_ALLOWED = NO;/g' project.pbxproj
  echo "✅ Code signing completely disabled for iOS 18.5"
else
  echo "⚠️ project.pbxproj not found"
fi
cd ..

# 프로젝트 루트로 돌아가기
cd ..

echo "✅ Pre-xcodebuild completed successfully" 