import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.knittda"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    /** ───────────────────────────────────────────────
     *  Kakao Native App Key를 local.properties에서 읽어오기
     * ─────────────────────────────────────────────── */
    val kakaoKey: String by lazy {
        val propsFile = rootDir.resolve("local.properties")
        val props = Properties()
        if (propsFile.exists()) {
            props.load(propsFile.inputStream())
        }
        props.getProperty("KAKAO_NATIVE_APP_KEY")?.trim()
            ?: error("KAKAO_NATIVE_APP_KEY not found in local.properties")
    }

    /** ───────────────────────────────────────────────
     *  릴리즈 키 등록 (key.properties 파일 읽기)
     * ─────────────────────────────────────────────── */
    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties()
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(keystorePropertiesFile.inputStream())
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.knittda"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        //키값 주입
        manifestPlaceholders["KAKAO_NATIVE_APP_KEY"] = kakaoKey
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false              // 코드 난독화 활성화
            isShrinkResources = false            // 사용되지 않는 리소스 제거
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"            // 사용자 정의 ProGuard 룰 파일
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
