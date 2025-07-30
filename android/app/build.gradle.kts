// android/app/build.gradle.kts
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.tteuda.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    /* ───────────────────────────────────────────────
       Kakao Native App Key를 local.properties에서 읽어오기
       ─────────────────────────────────────────────── */
    val kakaoKey: String by lazy {
        val propsFile = rootDir.resolve("local.properties")
        val props = Properties()
        if (propsFile.exists()) props.load(propsFile.inputStream())

        props.getProperty("KAKAO_NATIVE_APP_KEY")?.trim()
            ?: error("KAKAO_NATIVE_APP_KEY not found in local.properties")
    }

    /* ───────────────────────────────────────────────
       릴리즈 키 등록 (key.properties 파일 읽기)
       ─────────────────────────────────────────────── */
    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties().apply {
        if (keystorePropertiesFile.exists()) {
            load(keystorePropertiesFile.inputStream())
        }
    }

    signingConfigs {
        // release 서명은 keystore 파일이 있을 때만 만든다
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias      = keystoreProperties["keyAlias"]?.toString()
                keyPassword   = keystoreProperties["keyPassword"]?.toString()
                storeFile     = file(keystoreProperties["storeFile"]?.toString())
                storePassword = keystoreProperties["storePassword"]?.toString()
            }
        }
    }

    defaultConfig {
        applicationId = "com.tteuda.app"
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = 3
        versionName = "0.0.2"

        // manifest 키 주입
        manifestPlaceholders["KAKAO_NATIVE_APP_KEY"] = kakaoKey
    }

    buildTypes {
        getByName("release") {
            // keystore 없으면 signingConfig 를 붙이지 않는다
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
