@echo off
chcp 65001 >nul
title PANDA — Freelance Marketplace

:: ── ANSI colors ─────────────────────────────────────────────────────────────
for /f "tokens=*" %%E in ('powershell -NoProfile -Command "[char]27"') do set "ESC=%%E"
set "R=%ESC%[0m"
set "B=%ESC%[1m"
set "GRN=%ESC%[92m"
set "YLW=%ESC%[93m"
set "RED=%ESC%[91m"
set "CYN=%ESC%[96m"
set "BLU=%ESC%[94m"
set "GRY=%ESC%[90m"
set "WHT=%ESC%[97m"

:: ── Paths ────────────────────────────────────────────────────────────────────
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"
set "BACKEND=%ROOT%\backend-laravel"
set "FRONT=%ROOT%\frontend-react"

cls
echo.
echo.
echo    %B%%CYN%══════════════════════════════════════════════════════%R%
echo.
echo    %B%%WHT%    ██████╗  █████╗ ███╗   ██╗██████╗  █████╗%R%
echo    %B%%WHT%    ██╔══██╗██╔══██╗████╗  ██║██╔══██╗██╔══██╗%R%
echo    %B%%CYN%    ██████╔╝███████║██╔██╗ ██║██║  ██║███████║%R%
echo    %B%%CYN%    ██╔═══╝ ██╔══██║██║╚██╗██║██║  ██║██╔══██║%R%
echo    %B%%BLU%    ██║     ██║  ██║██║ ╚████║██████╔╝██║  ██║%R%
echo    %B%%BLU%    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝%R%
echo.
echo    %GRY%          Freelance Marketplace Platform%R%
echo.
echo    %B%%CYN%══════════════════════════════════════════════════════%R%
echo.

:: ── DETECT XAMPP / WampServer ────────────────────────────────────────────────
set "PHP_BIN="
set "MYSQL_BIN="

for %%D in (C D E F) do (
    if exist "%%D:\xampp\php\php.exe" (
        set "PHP_BIN=%%D:\xampp\php"
        set "MYSQL_BIN=%%D:\xampp\mysql\bin"
        goto :SERVER_FOUND
    )
)

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

echo   %RED%[ERROR]%R%  No server found.
echo            Install XAMPP  : https://www.apachefriends.org
echo            Install Wamp   : https://www.wampserver.com
echo.
pause & exit /b 1

:SERVER_FOUND
set "MYSQL=%MYSQL_BIN%\mysql.exe"
set "PATH=%PHP_BIN%;%MYSQL_BIN%;%PATH%"

for /f "tokens=*" %%v in ('php -r "echo phpversion();" 2^>nul') do set "PHPV=%%v"
echo   %GRY%  PHP    %R%%WHT%%PHP_BIN%%R%  %GRY%(v%PHPV%)%R%
echo   %GRY%  MySQL  %R%%WHT%%MYSQL_BIN%%R%
echo.

:: ── SETUP CHECK ──────────────────────────────────────────────────────────────
set "NEED_SETUP=0"
if not exist "%BACKEND%\vendor\autoload.php" set "NEED_SETUP=1"
if not exist "%FRONT%\node_modules\.bin"     set "NEED_SETUP=1"

if "%NEED_SETUP%"=="0" (
    pushd "%BACKEND%"
    php artisan --version >nul 2>&1
    if errorlevel 1 (
        echo   %YLW%[!]%R%  Incomplete install detected — re-running setup...
        echo.
        rmdir /s /q vendor >nul 2>&1
        set "NEED_SETUP=1"
    )
    popd
)

if "%NEED_SETUP%"=="0" goto :LAUNCH

:: ── FIRST-TIME SETUP ─────────────────────────────────────────────────────────
echo   %B%First-time setup%R%  %GRY%(runs once)%R%
echo   %GRY%  ──────────────────────────────────────────────────%R%
echo.

:: [1/4] Composer
echo   %GRY%[1/4]%R%  %B%Composer%R%
where composer >nul 2>&1
if errorlevel 1 (
    echo          %YLW%Not found — installing via winget...%R%
    winget install Composer.Composer --accept-package-agreements --accept-source-agreements --silent >nul 2>&1
    if exist "C:\ProgramData\ComposerSetup\bin\composer.bat" set "PATH=C:\ProgramData\ComposerSetup\bin;%PATH%"
)
where composer >nul 2>&1
if errorlevel 1 (
    echo          %RED%✗ Not found. Install from https://getcomposer.org%R%
    echo.
    pause & exit /b 1
)
for /f "tokens=3" %%v in ('composer --version 2^>nul') do set "COMPV=%%v"
echo          %GRN%✓%R%  Composer %GRY%%COMPV%%R%
echo.

:: [2/4] Node.js
echo   %GRY%[2/4]%R%  %B%Node.js%R%
where node >nul 2>&1
if errorlevel 1 (
    echo          %YLW%Not found — installing via winget...%R%
    winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements --silent >nul 2>&1
    if exist "C:\Program Files\nodejs\node.exe" set "PATH=C:\Program Files\nodejs;%PATH%"
)
where node >nul 2>&1
if errorlevel 1 (
    echo          %RED%✗ Not found. Install from https://nodejs.org%R%
    echo.
    pause & exit /b 1
)
for /f "tokens=*" %%v in ('node -v 2^>nul') do set "NODEV=%%v"
echo          %GRN%✓%R%  Node.js %GRY%%NODEV%%R%
echo.

:: [3/4] Database
echo   %GRY%[3/4]%R%  %B%Database%R%
call :START_MYSQL

:WAIT_SETUP
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo          %YLW%[!]%R%  MySQL not running — start it then press any key...
    pause >nul
    call :START_MYSQL
    goto :WAIT_SETUP
)
echo          %GRN%✓%R%  MySQL running

"%MYSQL%" -u root -e "CREATE DATABASE IF NOT EXISTS panda CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" >nul 2>&1
echo          %GRN%✓%R%  Database %WHT%panda%R% ready

if not exist "%ROOT%\.db_imported" (
    if exist "%ROOT%\panda.sql" (
        echo          %GRY%→  Importing panda.sql...%R%
        "%MYSQL%" -u root panda < "%ROOT%\panda.sql"
        echo imported > "%ROOT%\.db_imported"
        echo          %GRN%✓%R%  panda.sql imported
    )
)
echo.

:: [4/4] Packages
echo   %GRY%[4/4]%R%  %B%Installing packages%R%

if not exist "%BACKEND%\.env" (
    if exist "%BACKEND%\.env.example" copy "%BACKEND%\.env.example" "%BACKEND%\.env" >nul
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c -replace 'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c -replace 'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1

echo          %GRY%→  composer install (1–2 min)...%R%
pushd "%BACKEND%"
composer install --no-interaction --prefer-dist --optimize-autoloader
if errorlevel 1 (
    echo          %YLW%→  Updating packages for PHP %PHPV%...%R%
    composer update --no-interaction --prefer-dist --optimize-autoloader
    if errorlevel 1 (
        echo.
        echo          %RED%✗ Failed. Run manually:%R%
        echo             cd backend-laravel ^&^& composer update
        echo.
        popd & pause & exit /b 1
    )
)
echo          %GRN%✓%R%  PHP packages installed

php artisan key:generate --force >nul 2>&1
echo          %GRN%✓%R%  APP_KEY generated

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
echo          %GRN%✓%R%  Migrations done
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

echo          %GRY%→  npm install (1–3 min)...%R%
pushd "%FRONT%"
npm install
if errorlevel 1 (
    echo.
    echo          %RED%✗ Failed. Run manually:%R%
    echo             cd frontend-react ^&^& npm install
    echo.
    popd & pause & exit /b 1
)
echo          %GRN%✓%R%  Node packages installed
popd

echo.
echo   %GRY%  ──────────────────────────────────────────────────%R%
echo   %GRN%  ✓  Setup complete!%R%
echo   %GRY%  ──────────────────────────────────────────────────%R%
echo.
timeout /t 2 /nobreak >nul

:: ── LAUNCH ───────────────────────────────────────────────────────────────────
:LAUNCH

set "PATH=%PHP_BIN%;%MYSQL_BIN%;%PATH%"

echo   %B%System%R%
echo   %GRY%  ──────────────────────────────────────────────────%R%

where php >nul 2>&1
if errorlevel 1 ( echo   %RED%✗%R%  PHP not found & pause & exit /b 1 )
for /f "tokens=*" %%v in ('php -r "echo phpversion();" 2^>nul') do set "PHPV=%%v"
echo   %GRN%✓%R%  PHP       %GRY%v%PHPV%%R%

where node >nul 2>&1
if errorlevel 1 ( echo   %RED%✗%R%  Node.js not found & pause & exit /b 1 )
for /f "tokens=*" %%v in ('node -v 2^>nul') do set "NODEV=%%v"
echo   %GRN%✓%R%  Node.js   %GRY%%NODEV%%R%

where composer >nul 2>&1
if errorlevel 1 ( echo   %RED%✗%R%  Composer not found & pause & exit /b 1 )
for /f "tokens=3" %%v in ('composer --version 2^>nul') do set "COMPV=%%v"
echo   %GRN%✓%R%  Composer  %GRY%v%COMPV%%R%
echo.

echo   %B%Database%R%
echo   %GRY%  ──────────────────────────────────────────────────%R%
call :START_MYSQL

:WAIT_LAUNCH
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo   %YLW%[!]%R%  MySQL not running — start it then press any key...
    pause >nul
    call :START_MYSQL
    goto :WAIT_LAUNCH
)
echo   %GRN%✓%R%  MySQL connected

powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c -replace 'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c -replace 'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1

pushd "%BACKEND%"
php artisan storage:link --force >nul 2>&1
php artisan migrate --force        >nul 2>&1
php artisan config:clear           >nul 2>&1
php artisan cache:clear            >nul 2>&1
php artisan route:clear            >nul 2>&1
php artisan view:clear             >nul 2>&1
popd
echo   %GRN%✓%R%  Laravel ready
echo.

echo   %B%Servers%R%
echo   %GRY%  ──────────────────────────────────────────────────%R%

start "PANDA Backend" /D "%BACKEND%" cmd /k "color 17 && echo. && echo   PANDA Backend  ^|  http://localhost:8000 && echo. && php artisan serve --host=127.0.0.1 --port=8000"
timeout /t 8 /nobreak >nul
echo   %GRN%✓%R%  Backend   %CYN%http://localhost:8000%R%

start "PANDA Frontend" /D "%FRONT%" cmd /k "color 19 && echo. && echo   PANDA Frontend ^|  http://localhost:5173 && echo. && npm run dev"
timeout /t 6 /nobreak >nul
echo   %GRN%✓%R%  Frontend  %CYN%http://localhost:5173%R%

echo.
echo   %B%%CYN%  ╔══════════════════════════════════════════════╗%R%
echo   %B%%CYN%  ║                                              ║%R%
echo   %B%%CYN%  ║   PANDA is live!                             ║%R%
echo   %B%%CYN%  ║                                              ║%R%
echo   %B%%CYN%  ║   Frontend    http://localhost:5173          ║%R%
echo   %B%%CYN%  ║   Backend     http://localhost:8000          ║%R%
echo   %B%%CYN%  ║   phpMyAdmin  http://localhost/phpmyadmin    ║%R%
echo   %B%%CYN%  ║                                              ║%R%
echo   %B%%CYN%  ╚══════════════════════════════════════════════╝%R%
echo.

start http://localhost:5173
echo   %GRY%  Press any key to close this window...%R%
pause >nul
goto :EOF

:: ── HELPER: auto-start MySQL service ─────────────────────────────────────────
:START_MYSQL
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($n in @('wampmysqld64','wampmysqld','mysql','MySQL','MySQL80','mariadb','MariaDB')){$s=Get-Service $n -EA SilentlyContinue;if($s -and $s.Status -ne 'Running'){try{Start-Service $n -EA SilentlyContinue}catch{}}}" >nul 2>&1
for %%S in (wampmysqld64 wampmysqld mysql MySQL MySQL80 mariadb) do net start %%S >nul 2>&1
timeout /t 4 /nobreak >nul
goto :EOF
