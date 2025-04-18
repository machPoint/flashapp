@echo off
echo ===================================
echo    STARTING MATHFLASH APP (ADMIN)
echo ===================================
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script needs to be run as Administrator.
    echo Right-click the batch file and select "Run as administrator".
    pause
    exit /b 1
)

:: Set the working directory to the project folder
cd /d "%~dp0"

echo Setting permissions for the project directory...
icacls . /grant "%USERNAME%":(OI)(CI)F /T

:: Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Flutter not found in PATH. Please make sure Flutter is installed correctly.
    pause
    exit /b 1
)

:: Skip flutter pub get which causes permission issues
echo.
echo Skipping dependency check to avoid permission issues.
echo.

:: Try to run the app directly
echo Launching MathFlash app...
echo.

:: Try Windows first
echo Attempting to run on Windows...
call flutter run -d windows --no-pub

:: If Windows device is not available, try web
if %ERRORLEVEL% neq 0 (
    echo.
    echo Windows device not available. Trying web...
    echo.
    
    :: Try Chrome
    echo Attempting to run on Chrome...
    call flutter run -d chrome --no-pub
    
    :: If Chrome is not available, try Edge
    if %ERRORLEVEL% neq 0 (
        echo.
        echo Chrome not available. Trying Microsoft Edge...
        echo.
        call flutter run -d edge --no-pub
        
        :: If all else fails
        if %ERRORLEVEL% neq 0 (
            echo.
            echo Failed to run on any available device.
            echo.
            echo Alternative: Try running the app in a different directory with full permissions.
            echo.
        )
    )
)

pause
