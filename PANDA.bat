@echo off
chcp 65001 >nul
title PANDA - Freelance Platform

:: Paths
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"
set "BACKEND=%ROOT%\backend-laravel"
set "FRONT=%ROOT%\frontend-react"

cls
echo.
echo  ====================================================
echo    PANDA - Freelance Marketplace Platform
echo  ====================================================
echo.

::--------------------------------------------------------------
:: AUTO-DETECT XAMPP or WampServer
::--------------------------------------------------------------
set "PHP_BIN="
set "MYSQL_BIN="

:: --- XAMPP (check C: D: E: F:) ---
for %%D in (C D E F) do (
    if exist "%%D:\xampp\php\php.exe" (
        set "PHP_BIN=%%D:\xampp\php"
        set "MYSQL_BIN=%%D:\xampp\mysql\bin"
        goto :SERVER_FOUND
    )
)

:: --- WampServer 64-bit (check C: D: E: F:) ---
for %%D in (C D E F) do (
    if exist "%%D:\wamp64\bin\php" (
        for /d %%P in ("%%D:\wamp64\bin\php\php*") do (
            if exist "%%P\php.exe" set "PHP_BIN=%%P"
        )
        for /d %%M in ("%%D:\wamp64\bin\mysql\mysql*") do (
            if exist "%%M\bin\mysql.exe" set "MYSQL_BIN=%%M\bin"
        )
        if defined PHP_BIN goto :SERVER_FOUND
    )
)

:: --- WampServer 32-bit (check C: D: E: F:) ---
for %%D in (C D E F) do (
    if exist "%%D:\wamp\bin\php" (
        for /d %%P in ("%%D:\wamp\bin\php\php*") do (
            if exist "%%P\php.exe" set "PHP_BIN=%%P"
        )
        for /d %%M in ("%%D:\wamp\bin\mysql\mysql*") do (
            if exist "%%M\bin\mysql.exe" set "MYSQL_BIN=%%M\bin"
        )
        if defined PHP_BIN goto :SERVER_FOUND
    )
)

:: --- Not found ---
echo  [ERROR] Neither XAMPP nor WampServer was found.
echo.
echo   Install one of:
echo     XAMPP       : https://www.apachefriends.org
echo     WampServer  : https://www.wampserver.com
echo.
pause & exit /b 1

:SERVER_FOUND
set "MYSQL=%MYSQL_BIN%\mysql.exe"
set "PATH=%PHP_BIN%;%MYSQL_BIN%;%PATH%"
echo  [+] PHP   : %PHP_BIN%
echo  [+] MySQL : %MYSQL_BIN%
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

:: [1/4] Composer
echo  [1/4] Checking Composer...
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

:: [2/4] Node.js
echo  [2/4] Checking Node.js...
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

:: [3/4] MySQL + Database
echo  [3/4] Setting up MySQL database...
call :START_MYSQL

:WAIT_SETUP
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo.
    echo  [!] MySQL is not running. Start it and press any key to retry...
    echo.
    pause >nul
    call :START_MYSQL
    goto :WAIT_SETUP
)
echo  [OK] MySQL running

"%MYSQL%" -u root -e "CREATE DATABASE IF NOT EXISTS panda CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" >nul 2>&1
echo  [OK] Database panda ready

if not exist "%ROOT%\.db_imported" (
    if exist "%ROOT%\panda.sql" (
        echo  Importing panda.sql...
        "%MYSQL%" -u root panda < "%ROOT%\panda.sql"
        echo imported > "%ROOT%\.db_imported"
        echo  [OK] panda.sql imported
    )
)
echo.

:: [4/4] Backend + Frontend packages
echo  [4/4] Installing packages...

if not exist "%BACKEND%\.env" (
    if exist "%BACKEND%\.env.example" (
        copy "%BACKEND%\.env.example" "%BACKEND%\.env" >nul
    )
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c -replace 'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c -replace 'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1

echo  Running composer install (1-2 minutes)...
pushd "%BACKEND%"
composer install --no-interaction --prefer-dist --optimize-autoloader
if errorlevel 1 (
    echo  [ERROR] composer install failed.
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

echo  Running npm install (1-3 minutes)...
pushd "%FRONT%"
npm install
if errorlevel 1 (
    echo  [ERROR] npm install failed.
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

set "PATH=%PHP_BIN%;%MYSQL_BIN%;%PATH%"

echo  SYSTEM CHECK
echo  ----------------------------------------------------

where php >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] PHP not found
    pause & exit /b 1
)
echo  [+] PHP OK

where node >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Node.js not found
    pause & exit /b 1
)
echo  [+] Node.js OK

where composer >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Composer not found
    pause & exit /b 1
)
echo  [+] Composer OK
echo.

echo  DATABASE
echo  ----------------------------------------------------
call :START_MYSQL

:WAIT_LAUNCH
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo.
    echo  [!] MySQL is not running. Start it and press any key to retry...
    echo.
    pause >nul
    call :START_MYSQL
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
goto :EOF

::--------------------------------------------------------------
:: HELPER - auto-start MySQL service (tries all known names)
::--------------------------------------------------------------
:START_MYSQL
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($n in @('wampmysqld64','wampmysqld','mysql','MySQL','MySQL80','mariadb','MariaDB')){$s=Get-Service $n -EA SilentlyContinue;if($s -and $s.Status -ne 'Running'){try{Start-Service $n -EA SilentlyContinue}catch{}}}" >nul 2>&1
for %%S in (wampmysqld64 wampmysqld mysql MySQL MySQL80 mariadb) do net start %%S >nul 2>&1
timeout /t 4 /nobreak >nul
goto :EOF
