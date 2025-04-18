@echo off
echo ===================================
echo      STARTING MATHFLASH APP
echo ===================================
echo.

:: Set the working directory to the project folder
cd /d "%~dp0"

:: Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Flutter not found in PATH. Please make sure Flutter is installed correctly.
    pause
    exit /b 1
)

:: Check if the project has all dependencies
echo Checking dependencies...
call flutter pub get

if %ERRORLEVEL% neq 0 (
    echo Failed to get dependencies. Please check your internet connection or project configuration.
    pause
    exit /b 1
)

:: Run the app on Windows
echo.
echo Launching MathFlash app...
echo.

:: Try Windows first
echo Attempting to run on Windows...
call flutter run -d windows

:: If Windows device is not available, try web
if %ERRORLEVEL% neq 0 (
    echo.
    echo Windows device not available. Trying web...
    echo.
    call flutter run -d chrome
    
    :: If Chrome is not available, try Edge
    if %ERRORLEVEL% neq 0 (
        echo.
        echo Chrome not available. Trying Microsoft Edge...
        echo.
        call flutter run -d edge
        
        :: If all else fails
        if %ERRORLEVEL% neq 0 (
            echo.
            echo Failed to run on any available device.
            echo Please make sure you have Flutter configured correctly for Windows or web development.
            echo.
            echo You can try running manually with one of these commands:
            echo   flutter run -d windows
            echo   flutter run -d chrome
            echo   flutter run -d edge
            echo.
        )
    )
)

pause
