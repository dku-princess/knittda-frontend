#-dontwarn com.google.errorprone.annotations.CanIgnoreReturnValue
#-dontwarn com.google.errorprone.annotations.CheckReturnValue
#-dontwarn com.google.errorprone.annotations.Immutable
#-dontwarn com.google.errorprone.annotations.RestrictedApi
#-dontwarn javax.annotation.Nullable
#-dontwarn javax.annotation.concurrent.GuardedBy

# Flutter 기본 설정
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# MainActivity
-keep class com.example.knittda.MainActivity { *; }

# Kakao SDK
-keep class com.kakao.** { *; }
-dontwarn com.kakao.**

# flutter_secure_storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }
-dontwarn com.it_nomads.fluttersecurestorage.**
-keep class androidx.security.crypto.** { *; }
-dontwarn androidx.security.crypto.**

# Sentry
-keep class io.sentry.** { *; }
-dontwarn io.sentry.**

# 소스 파일명 및 라인 번호 정보 유지
-keepattributes SourceFile,LineNumberTable

# 네이티브 메서드 유지
-keepclasseswithmembernames class * {
    native <methods>;
}

