function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

Write-ColorOutput Green "==============================================="
Write-ColorOutput Green "LittleMomo App - Comprehensive Fix Script"
Write-ColorOutput Green "==============================================="

# Approach 1: Fix path formatting in local.properties
Write-ColorOutput Yellow "STEP 1: Fixing local.properties..."
$localPropsContent = @"
sdk.dir=C:/Users/HP/AppData/Local/Android/Sdk
flutter.sdk=E:/smester 6/madlab/flutter
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=1
"@
$localPropsContent | Out-File -FilePath "android/local.properties" -Encoding utf8

# Approach 2: Fix Java compatibility in build.gradle
Write-ColorOutput Yellow "STEP 2: Fixing build.gradle..."
$buildGradleContent = Get-Content "android/app/build.gradle" -Raw
$buildGradleContent = $buildGradleContent -replace "sourceCompatibility = JavaVersion.VERSION_11", "sourceCompatibility JavaVersion.VERSION_1_8"
$buildGradleContent = $buildGradleContent -replace "sourceCompatibility JavaVersion.VERSION_11", "sourceCompatibility JavaVersion.VERSION_1_8"
$buildGradleContent = $buildGradleContent -replace "targetCompatibility = JavaVersion.VERSION_11", "targetCompatibility JavaVersion.VERSION_1_8"
$buildGradleContent = $buildGradleContent -replace "targetCompatibility JavaVersion.VERSION_11", "targetCompatibility JavaVersion.VERSION_1_8"
$buildGradleContent = $buildGradleContent -replace "jvmTarget = '11'", "jvmTarget = '1.8'"
$buildGradleContent | Out-File -FilePath "android/app/build.gradle" -Encoding utf8

# Approach The 3: Fix gradle.properties
Write-ColorOutput Yellow "STEP 3: Fixing gradle.properties..."
$gradlePropsContent = @"
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
android.defaults.buildfeatures.buildconfig=true
android.nonTransitiveRClass=false
android.enableR8=true
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
"@
$gradlePropsContent | Out-File -FilePath "android/gradle.properties" -Encoding utf8

# Approach 4: Create a temporary directory if needed
if (Test-Path "temp_build") {
    Remove-Item -Recurse -Force "temp_build"
}
New-Item -ItemType Directory -Path "temp_build"

# Approach 5: Clean up build cache and re-download dependencies
Write-ColorOutput Yellow "STEP 4: Cleaning project and getting dependencies..."
flutter clean
flutter pub get

# Approach 6: Run the build multiple ways
Write-ColorOutput Yellow "STEP 5: Building APK (will try multiple ways if one fails)..."

# Try with --debug flag
flutter build apk --debug

if ($LASTEXITCODE -ne 0) {
    Write-ColorOutput Yellow "First build attempt failed, trying alternative approach..."
    flutter build apk --debug --no-shrink
}

if ($LASTEXITCODE -ne 0) {
    Write-ColorOutput Yellow "Second build attempt failed, trying with different Java options..."
    $env:JAVA_OPTS = "-Xmx1536M"
    flutter build apk --debug
}

if ($LASTEXITCODE -eq 0) {
    Write-ColorOutput Green "✅ SUCCESS! APK built successfully!"
    Write-ColorOutput Green "The APK is located at: build\app\outputs\flutter-apk\app-debug.apk"
    
    $installChoice = Read-Host "Do you want to install the APK on a connected device? (y/n)"
    if ($installChoice -eq "y" -or $installChoice -eq "Y") {
        & adb install -r "build\app\outputs\flutter-apk\app-debug.apk"
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput Green "✅ APK installed successfully!"
        } else {
            Write-ColorOutput Red "❌ APK installation failed. Make sure a device is connected."
        }
    }
} else {
    Write-ColorOutput Red "❌ All build attempts failed. Please check the manual fix instructions in manual_fix.md."
}

Write-ColorOutput Green "Process completed. Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 