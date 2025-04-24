Write-Host "=== LittleMomo Mobile App Runner ===" -ForegroundColor Cyan
Write-Host "This script will help you run the app directly on your mobile device" -ForegroundColor Cyan
Write-Host

# Step 1: Fix the build.gradle file by creating a new one without BOM characters
Write-Host "1. Fixing Android build configuration..." -ForegroundColor Yellow
$buildGradleContent = @'
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

android {
    namespace "com.example.littlemomo"
    compileSdk flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    defaultConfig {
        applicationId "com.example.littlemomo"
        minSdk flutter.minSdkVersion
        targetSdk flutter.targetSdkVersion
        versionCode 1
        versionName "1.0.0"
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
    }
    
    lintOptions {
        disable 'InvalidPackage'
        checkReleaseBuilds false
        abortOnError false
    }
}

flutter {
    source '../..'
}
'@

# Create a new build.gradle file without BOM character
$buildGradleContent | Out-File -FilePath "android/app/build.gradle" -Encoding ascii

# Step 2: Fix local.properties for path issues
Write-Host "2. Fixing path configurations..." -ForegroundColor Yellow
$localPropertiesContent = @"
sdk.dir=C:/Users/HP/AppData/Local/Android/Sdk
flutter.sdk=E:/smester 6/madlab/flutter
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=1
"@
$localPropertiesContent | Out-File -FilePath "android/local.properties" -Encoding ascii

# Step 3: Fix gradle.properties
Write-Host "3. Optimizing Gradle properties..." -ForegroundColor Yellow
$gradlePropertiesContent = @"
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
android.nonTransitiveRClass=false
org.gradle.parallel=true
"@
$gradlePropertiesContent | Out-File -FilePath "android/gradle.properties" -Encoding ascii

# Step 4: Clean and get dependencies
Write-Host "4. Cleaning project and updating dependencies..." -ForegroundColor Yellow
flutter clean
flutter pub get

# Step 5: Check if device is connected
Write-Host "5. Checking for connected devices..." -ForegroundColor Yellow
$devices = flutter devices
if ($devices -match "No devices detected") {
    Write-Host "❌ No mobile devices detected. Please connect your device and enable USB debugging." -ForegroundColor Red
    Write-Host "   1. Connect your phone via USB"
    Write-Host "   2. Enable Developer Options on your phone"
    Write-Host "   3. Enable USB Debugging in Developer Options"
    Write-Host "   4. Accept any authorization prompts on your phone"
    Write-Host
    Write-Host "Press Enter to check again once you've connected your device..." -ForegroundColor Yellow
    Read-Host
    $devices = flutter devices
}

# List available devices
Write-Host "Available devices:" -ForegroundColor Cyan
$devices

# Step 6: Run the app
Write-Host "6. Running app on your device..." -ForegroundColor Green
flutter run

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 