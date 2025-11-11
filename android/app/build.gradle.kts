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

    val kakaoKey: String by lazy {
        val propsFile = rootDir.resolve("local.properties")
        val props = Properties()
        if (propsFile.exists()) props.load(propsFile.inputStream())

        props.getProperty("KAKAO_NATIVE_APP_KEY")?.trim()
            ?: error("KAKAO_NATIVE_APP_KEY not found in local.properties")
    }

    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties().apply {
        if (keystorePropertiesFile.exists()) {
            load(keystorePropertiesFile.inputStream())
        }
    }

    signingConfigs {
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
        versionCode = 7
        versionName = "1.0.0"

        manifestPlaceholders["KAKAO_NATIVE_APP_KEY"] = kakaoKey
    }

    buildTypes {
        getByName("release") {
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
