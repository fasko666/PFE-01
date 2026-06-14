@echo off
chcp 65001 >nul
title PANDA - Freelance Platform

:: Paths
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"
set "BACKEND=%ROOT%\backend-laravel"
set "FRONT=%ROOT%\frontend-react"
set "MYSQL=C:\xampp\mysql\bin\mysql.exe"

:: Add XAMPP to PATH
if exist "C:\xampp\php\php.exe"         set "PATH=C:\xampp\php;%PATH%"
if exist "C:\xampp\mysql\bin\mysql.exe" set "PATH=C:\xampp\mysql\bin;%PATH%"

cls
echo.
echo  ====================================================
echo    PANDA - Freelance Marketplace Platform
echo  ====================================================
echo.

:: Detect first-time setup
set "NEED_SETUP=0"
if not exist "%BACKEND%\vendor\autoload.php" set "NEED_SETUP=1"
if not exist "%FRONT%\node_modules\.bin"     set "NEED_SETUP=1"

if "%NEED_SETUP%"=="0" goto :LAUNCH

::--------------------------------------------------------------
:: SETUP - first run only
::--------------------------------------------------------------
echo  FIRST-TIME SETUP - please wait, this runs once.
echo  ----------------------------------------------------
echo.

:: [1/5] PHP
echo  [1/5] Checking PHP (XAMPP)...
if not exist "C:\xampp\php\php.exe" (
    echo.
    echo  [ERROR] XAMPP PHP not found at C:\xampp\php
    echo          Install XAMPP from https://www.apachefriends.org
    echo          then run PANDA.bat again.
    echo.
    pause & exit /b 1
)
echo  [OK] PHP found at C:\xampp\php
echo.

:: [2/5] Composer
echo  [2/5] Checking Composer...
where composer >nul 2>&1
if errorlevel 1 (
    echo  Installing Composer via winget...
    winget install Composer.Composer --accept-package-agreements --accept-source-agreements --silent
    if exist "C:\ProgramData\ComposerSetup\bin\composer.bat" (
        set "PATH=C:\ProgramData\ComposerSetup\bin;%PATH%"
    )
)
where composer >nul 2>&1
if errorlevel 1 (
    echo.
    echo  [ERROR] Composer not found.
    echo          Install it from https://getcomposer.org then run again.
    echo.
    pause & exit /b 1
)
echo  [OK] Composer ready
echo.

:: [3/5] Node.js
echo  [3/5] Checking Node.js...
where node >nul 2>&1
if errorlevel 1 (
    echo  Installing Node.js via winget...
    winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements --silent
    if exist "C:\Program Files\nodejs\node.exe" (
        set "PATH=C:\Program Files\nodejs;%PATH%"
    )
)
where node >nul 2>&1
if errorlevel 1 (
    echo.
    echo  [ERROR] Node.js not found.
    echo          Install it from https://nodejs.org then run again.
    echo.
    pause & exit /b 1
)
echo  [OK] Node.js ready
echo.

:: [4/5] MySQL + Database
echo  [4/5] Setting up MySQL database...
if not exist "%MYSQL%" (
    echo.
    echo  [ERROR] XAMPP MySQL not found at C:\xampp\mysql\bin
    echo          Make sure XAMPP is installed correctly.
    echo.
    pause & exit /b 1
)

:: Try to start MySQL service automatically
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($n in @('mysql','MySQL','MySQL80')){$s=Get-Service $n -EA SilentlyContinue;if($s){if($s.Status -ne 'Running'){try{Start-Service $n -EA SilentlyContinue;Start-Sleep 4}catch{}};break}}" >nul 2>&1

:WAIT_SETUP
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo.
    echo  [!] MySQL is not running.
    echo      Open XAMPP Control Panel and click START next to MySQL.
    echo      Then press any key to retry...
    echo.
    pause >nul
    goto :WAIT_SETUP
)
echo  [OK] MySQL running

"%MYSQL%" -u root -e "CREATE DATABASE IF NOT EXISTS panda CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" >nul 2>&1
echo  [OK] Database panda ready

:: Import panda.sql only once (flag file prevents re-import)
if not exist "%ROOT%\.db_imported" (
    if exist "%ROOT%\panda.sql" (
        echo  Importing panda.sql...
        "%MYSQL%" -u root panda < "%ROOT%\panda.sql"
        echo imported > "%ROOT%\.db_imported"
        echo  [OK] panda.sql imported
    )
)
echo.

:: [5/5] Backend + Frontend
echo  [5/5] Installing packages...

:: Backend .env
if not exist "%BACKEND%\.env" (
    if exist "%BACKEND%\.env.example" (
        copy "%BACKEND%\.env.example" "%BACKEND%\.env" >nul
    )
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c -replace 'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c -replace 'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1

:: Composer install
echo.
echo  Running composer install (1-2 minutes)...
pushd "%BACKEND%"
composer install --no-interaction --prefer-dist --optimize-autoloader
if errorlevel 1 (
    echo.
    echo  [ERROR] composer install failed.
    echo          Check your internet connection and try again.
    echo.
    popd & pause & exit /b 1
)
echo  [OK] PHP packages installed

php artisan key:generate --force >nul 2>&1
echo  [OK] APP_KEY generated

for %%d in (
    "storage\app\public"
    "storage\framework\cache\data"
    "storage\framework\sessions"
    "storage\framework\views"
    "storage\logs"
) do (
    if not exist "%BACKEND%\%%~d" mkdir "%BACKEND%\%%~d" >nul 2>&1
)
php artisan storage:link --force >nul 2>&1
php artisan migrate --force
echo  [OK] Migrations done
popd

:: Frontend .env
if not exist "%FRONT%\.env" (
    (
        echo VITE_API_URL=http://localhost:8000/api
        echo VITE_REVERB_APP_KEY=panda-key
        echo VITE_REVERB_HOST=127.0.0.1
        echo VITE_REVERB_PORT=8080
        echo VITE_REVERB_SCHEME=http
    ) > "%FRONT%\.env"
)
echo  [OK] Frontend .env ready

:: npm install
echo.
echo  Running npm install (1-3 minutes)...
pushd "%FRONT%"
npm install
if errorlevel 1 (
    echo.
    echo  [ERROR] npm install failed.
    echo          Check your internet connection and try again.
    echo.
    popd & pause & exit /b 1
)
echo  [OK] Node packages installed
popd

echo.
echo  ====================================================
echo   Setup complete! Launching PANDA...
echo  ====================================================
echo.
timeout /t 3 /nobreak >nul

::--------------------------------------------------------------
:: LAUNCH - runs every time
::--------------------------------------------------------------
:LAUNCH

if exist "C:\xampp\php\php.exe"         set "PATH=C:\xampp\php;%PATH%"
if exist "C:\xampp\mysql\bin\mysql.exe" set "PATH=C:\xampp\mysql\bin;%PATH%"

echo  SYSTEM CHECK
echo  ----------------------------------------------------

where php >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] PHP not found - install XAMPP from apachefriends.org
    pause & exit /b 1
)
echo  [+] PHP OK

where node >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Node.js not found - delete node_modules and run again
    pause & exit /b 1
)
echo  [+] Node.js OK

where composer >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Composer not found - delete vendor and run again
    pause & exit /b 1
)
echo  [+] Composer OK
echo.

echo  DATABASE
echo  ----------------------------------------------------

powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($n in @('mysql','MySQL','MySQL80')){$s=Get-Service $n -EA SilentlyContinue;if($s){if($s.Status -ne 'Running'){try{Start-Service $n -EA SilentlyContinue;Start-Sleep 3}catch{}};break}}" >nul 2>&1

:WAIT_LAUNCH
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo.
    echo  [!] MySQL is not running.
    echo      Open XAMPP Control Panel and click START next to MySQL.
    echo      Press any key to retry...
    echo.
    pause >nul
    goto :WAIT_LAUNCH
)
echo  [+] MySQL OK

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c -replace 'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c -replace 'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1

pushd "%BACKEND%"
php artisan storage:link --force >nul 2>&1
php artisan migrate --force >nul 2>&1
php artisan config:clear >nul 2>&1
php artisan cache:clear  >nul 2>&1
php artisan route:clear  >nul 2>&1
php artisan view:clear   >nul 2>&1
popd
echo  [+] Laravel OK
echo.

echo  LAUNCHING SERVERS
echo  ----------------------------------------------------

echo  Starting backend  - http://localhost:8000
start "PANDA Backend" /D "%BACKEND%" cmd /k "color 17 && echo. && echo   PANDA Backend ^| http://localhost:8000 && echo. && php artisan serve --host=127.0.0.1 --port=8000"
timeout /t 8 /nobreak >nul
echo  [+] Backend running

echo  Starting frontend - http://localhost:5173
start "PANDA Frontend" /D "%FRONT%" cmd /k "color 19 && echo. && echo   PANDA Frontend ^| http://localhost:5173 && echo. && npm run dev"
timeout /t 6 /nobreak >nul
echo  [+] Frontend running

echo.
echo  ====================================================
echo   PANDA is live!
echo.
echo   Frontend   : http://localhost:5173
echo   Backend    : http://localhost:8000
echo   phpMyAdmin : http://localhost/phpmyadmin
echo  ====================================================
echo.

start http://localhost:5173
echo  Press any key to close this window...
pause >nul
