@echo off
echo ===== Little Momo App Helper =====
echo 1. Clean and rebuild
echo 2. Build APK (debug)
echo 3. Build APK (release)
echo 4. Run app on device
echo 5. Install APK on device

set choice=0
set /p choice="Choose an option (1-5): "

if %choice%==1 (
    echo Cleaning project...
    flutter clean
    echo Getting dependencies...
    flutter pub get
    echo Done!
) else if %choice%==2 (
    echo Building debug APK...
    flutter build apk --debug
    echo APK built at: build\app\outputs\flutter-apk\app-debug.apk
    echo Done!
) else if %choice%==3 (
    echo Building release APK...
    flutter build apk --release
    echo APK built at: build\app\outputs\flutter-apk\app-release.apk
    echo Done!
) else if %choice%==4 (
    echo Running app on device...
    flutter run
    echo Done!
) else if %choice%==5 (
    echo Select APK type to install:
    echo 1. Debug
    echo 2. Release
    
    set apkChoice=0
    set /p apkChoice="Choose an option (1-2): "
    
    if %apkChoice%==1 (
        echo Installing debug APK...
        adb install -r build\app\outputs\flutter-apk\app-debug.apk
    ) else if %apkChoice%==2 (
        echo Installing release APK...
        adb install -r build\app\outputs\flutter-apk\app-release.apk
    ) else (
        echo Invalid choice!
    )
) else (
    echo Invalid choice!
)

pause 