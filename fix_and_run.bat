@echo off
echo ===================================
echo    FIXING AND RUNNING MATHFLASH
echo ===================================
echo.

:: Set the working directory to the project folder
cd /d "%~dp0"

:: Run flutter doctor to diagnose issues
echo Running Flutter doctor to diagnose issues...
flutter doctor -v > flutter_doctor_report.txt
echo Flutter doctor report saved to flutter_doctor_report.txt
echo.

:: Fix Visual Studio toolchain issues
echo Attempting to fix Visual Studio toolchain issues...
flutter config --enable-windows-desktop
flutter config --no-enable-android
flutter config --no-enable-ios
echo.

:: Run with web-server option (more reliable than specific browsers)
echo Launching MathFlash app on web server...
echo.
flutter run -d web-server --web-hostname=localhost --web-port=8080 --no-sound-null-safety

echo.
echo If the app doesn't launch automatically, open your browser and navigate to:
echo http://localhost:8080
echo.

pause
