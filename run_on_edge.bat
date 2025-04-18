@echo off
echo ===================================
echo    RUNNING MATHFLASH ON EDGE
echo ===================================
echo.

:: Set the working directory to the project folder
cd /d "%~dp0"

:: Skip dependency check
echo Skipping dependency check...
echo.

:: Run directly on Edge
echo Launching MathFlash app on Microsoft Edge...
echo.
flutter run -d edge --no-pub

echo.
if %ERRORLEVEL% neq 0 (
    echo Failed to launch on Edge.
    echo Trying web-server approach...
    echo.
    flutter run -d web-server --web-port=8080 --no-pub
    echo.
    echo If the app doesn't launch automatically, open Edge and navigate to:
    echo http://localhost:8080
)

pause
