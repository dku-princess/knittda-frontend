#!/bin/sh

# 스크립트 실행 중 에러 발생 시 즉시 중단
set -e

# 프로젝트 루트 디렉토리로 이동
cd $CI_PRIMARY_REPOSITORY_PATH

# ==============================
# 1) env.json 생성
# Xcode Cloud Workflow에 등록된 환경변수를 읽어서
# config/env.json 파일을 생성한다
# ==============================
CONFIG_DIR="$CI_PRIMARY_REPOSITORY_PATH/config"
mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_DIR/env.json" <<EOF
{
  "KAKAO_NATIVE_APP_KEY" : "$kakaoNativeAppKey",
  "SENTRY_DSN" : "$SENTRY_DSN",
  "SENTRY_ENVIRONMENT" : "$SENTRY_ENVIRONMENT",
  "API_BASE_URL" : "$API_BASE_URL",
  "DIRECTUS_BASE_URL" : "$DIRECTUS_BASE_URL",
  "DIRECTUS_STATUS" : "$DIRECTUS_STATUS"
}
EOF

echo "env.json created"

# ==============================
# 2) GoogleService-Info.plist 생성
# Base64로 인코딩된 환경변수를 디코딩하여
# ios/Runner/GoogleService-Info.plist 파일을 생성한다
# ==============================
echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > "$CI_PRIMARY_REPOSITORY_PATH/ios/Runner/GoogleService-Info.plist"
echo "GoogleService-Info.plist created"

# ==============================
# 3) Info.plist용 xcconfig 변수 주입
# Info.plist의 $(kakaoNativeAppKey)는 DART_DEFINES가 아닌
# Xcode Build Settings에서 값을 찾으므로 xcconfig에 직접 선언해야 한다
# ==============================
echo "kakaoNativeAppKey=$kakaoNativeAppKey" >> "$CI_PRIMARY_REPOSITORY_PATH/ios/Flutter/Debug.xcconfig"
echo "kakaoNativeAppKey=$kakaoNativeAppKey" >> "$CI_PRIMARY_REPOSITORY_PATH/ios/Flutter/Release.xcconfig"
echo "xcconfig updated"

# ==============================
# 4) Flutter SDK 설치
# stable 브랜치의 최신 버전을 설치한다
# ==============================
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# ==============================
# 5) Flutter 의존성 설치
# iOS 빌드에 필요한 아티팩트와 pub 패키지를 설치한다
# ==============================
flutter precache --ios

flutter pub get

dart run build_runner build

# ==============================
# 6) Flutter 빌드 설정 생성
# ==============================
flutter build ios --release --no-codesign \
  --dart-define-from-file=config/env.json \
  --config-only

# ==============================
# 7)  CocoaPods 설치 및 pod install
# ==============================
HOMEBREW_NO_AUTO_UPDATE=1
brew install cocoapods

cd ios && pod install

exit 0
