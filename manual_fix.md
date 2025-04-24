# Manual Fix Instructions for LittleMomo App

If you're experiencing issues with building or running the app, follow these steps to manually fix them:

## 1. Fix Path Issues in local.properties

Open `android/local.properties` and ensure all paths use forward slashes instead of backslashes:

```properties
sdk.dir=C:/Users/HP/AppData/Local/Android/Sdk
flutter.sdk=E:/smester 6/madlab/flutter
```

## 2. Update build.gradle

Open `android/app/build.gradle` and make these changes:

1. Change Java compatibility version:
```gradle
compileOptions {
    sourceCompatibility JavaVersion.VERSION_1_8
    targetCompatibility JavaVersion.VERSION_1_8
}

kotlinOptions {
    jvmTarget = '1.8'
}
```

2. Add this before the `flutter` block:
```gradle
// Fix for path with spaces
project.archivesBaseName = "littlemomo"
```

## 3. Update gradle.properties

Replace content of `android/gradle.properties` with:
```properties
org.gradle.jvmargs=-Xmx2048M
android.useAndroidX=true
android.enableJetifier=true
android.defaults.buildfeatures.buildconfig=true
android.nonTransitiveRClass=false
org.gradle.parallel=true
```

## 4. Create a temp project in a path without spaces (if still having issues)

```bash
cd C:\temp
flutter create littlemomo_temp
```

Copy your lib, assets, and pubspec.yaml to the temp project, then build from there:
```bash
flutter build apk --debug
```

## 5. Clean and Rebuild

```bash
flutter clean
flutter pub get
flutter build apk --debug
```

## 6. Install APK Manually

```bash
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

## 7. Alternative: Use Flutter Run

If you still can't build an APK, try running the app directly:
```bash
flutter run
```

## 8. Check for SDK Issues

Make sure your Android SDK path doesn't contain spaces. If it does, consider:
- Moving the Android SDK to a path without spaces
- Setting the ANDROID_SDK_ROOT environment variable to a path without spaces

## 9. Contact Support

If none of these solutions work, please contact support with the specific error message you're encountering. 