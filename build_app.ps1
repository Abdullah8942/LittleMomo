Write-Host "===== Little Momo App Helper =====" -ForegroundColor Cyan
Write-Host "1. Clean and rebuild"
Write-Host "2. Build APK (debug)"
Write-Host "3. Build APK (release)"
Write-Host "4. Run app on device"
Write-Host "5. Install APK on device"
Write-Host ""

$choice = Read-Host "Choose an option (1-5)"

switch ($choice) {
    "1" {
        Write-Host "Cleaning project..." -ForegroundColor Yellow
        flutter clean
        
        Write-Host "Getting dependencies..." -ForegroundColor Yellow
        flutter pub get
        
        Write-Host "Done!" -ForegroundColor Green
    }
    "2" {
        Write-Host "Building debug APK..." -ForegroundColor Yellow
        flutter build apk --debug
        
        Write-Host "APK built at: build\app\outputs\flutter-apk\app-debug.apk" -ForegroundColor Green
        Write-Host "Done!" -ForegroundColor Green
    }
    "3" {
        Write-Host "Building release APK..." -ForegroundColor Yellow
        flutter build apk --release
        
        Write-Host "APK built at: build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Green
        Write-Host "Done!" -ForegroundColor Green
    }
    "4" {
        Write-Host "Running app on device..." -ForegroundColor Yellow
        flutter run
        
        Write-Host "Done!" -ForegroundColor Green
    }
    "5" {
        Write-Host "Select APK type to install:" -ForegroundColor Cyan
        Write-Host "1. Debug"
        Write-Host "2. Release"
        
        $apkChoice = Read-Host "Choose an option (1-2)"
        
        switch ($apkChoice) {
            "1" {
                Write-Host "Installing debug APK..." -ForegroundColor Yellow
                adb install -r "build\app\outputs\flutter-apk\app-debug.apk"
            }
            "2" {
                Write-Host "Installing release APK..." -ForegroundColor Yellow
                adb install -r "build\app\outputs\flutter-apk\app-release.apk"
            }
            default {
                Write-Host "Invalid choice!" -ForegroundColor Red
            }
        }
    }
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }
}

Write-Host "Press any key to exit..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null 