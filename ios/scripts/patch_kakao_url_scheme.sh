#!/bin/sh
set -e

# DART_DEFINES = 콤마로 구분된 base64(KEY=VALUE) 목록
KAKAO_KEY=""
IFS=','
for d in $DART_DEFINES; do
  decoded=$(printf '%s' "$d" | base64 --decode 2>/dev/null || true)
  case "$decoded" in
    KAKAO_NATIVE_APP_KEY=*) KAKAO_KEY="${decoded#KAKAO_NATIVE_APP_KEY=}" ;;
  esac
done
unset IFS

if [ -z "$KAKAO_KEY" ]; then
  echo "error: KAKAO_NATIVE_APP_KEY not found in DART_DEFINES" >&2
  exit 1
fi

PLIST="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"

# CFBundleURLTypes 중 'kakao'로 시작하는 scheme을 찾아 실제 키로 교체
i=0
patched=0
while /usr/libexec/PlistBuddy -c "Print :CFBundleURLTypes:$i" "$PLIST" >/dev/null 2>&1; do
  scheme=$(/usr/libexec/PlistBuddy -c "Print :CFBundleURLTypes:$i:CFBundleURLSchemes:0" "$PLIST" 2>/dev/null || echo "")
  case "$scheme" in
    kakao*)
      /usr/libexec/PlistBuddy -c "Set :CFBundleURLTypes:$i:CFBundleURLSchemes:0 kakao${KAKAO_KEY}" "$PLIST"
      echo "Patched kakao URL scheme -> kakao${KAKAO_KEY}"
      patched=1
      break ;;
  esac
  i=$((i+1))
done

if [ "$patched" -ne 1 ]; then
  echo "error: kakao URL scheme not found in Info.plist" >&2
  exit 1
fi
