@echo off
chcp 65001 >nul
title PANDA — Freelance Platform

:: ANSI colors (Windows 10/11)
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
for /f %%a in ('echo prompt $E^| cmd') do set "E=%%a"

set "R=%E%[0m"
set "BOLD=%E%[1m"
set "DIM=%E%[2m"
set "BLUE=%E%[38;2;67;97;255m"
set "LBLUE=%E%[38;2;100;140;255m"
set "GREEN=%E%[38;2;34;197;94m"
set "YELLOW=%E%[38;2;250;204;21m"
set "RED=%E%[38;2;239;68;68m"
set "CYAN=%E%[38;2;34;211;238m"
set "WHITE=%E%[38;2;248;250;252m"
set "GRAY=%E%[38;2;100;116;139m"
set "DKGRAY=%E%[38;2;51;65;85m"
set "BGDARK=%E%[48;2;10;10;20m"
set "BGCARD=%E%[48;2;15;23;50m"

set "OK=%GREEN%  +%R%"
set "ERR=%RED%  x%R%"
set "INFO=%CYAN%  >%R%"
set "WARN=%YELLOW%  !%R%"

:: Paths
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"
set "BACKEND=%ROOT%\backend-laravel"
set "FRONT=%ROOT%\frontend-react"
set "MYSQL=C:\xampp\mysql\bin\mysql.exe"

:: Add XAMPP to PATH immediately
if exist "C:\xampp\php\php.exe"         set "PATH=C:\xampp\php;%PATH%"
if exist "C:\xampp\mysql\bin\mysql.exe" set "PATH=C:\xampp\mysql\bin;%PATH%"

cls
echo %BGDARK%%R%
echo %BGDARK%  %BLUE%%BOLD%                                                              %R%
echo %BGDARK%  %BLUE%%BOLD%   XXXXXXX  XXXXX  XXX  XXXXXX  XXXXX                        %R%
echo %BGDARK%  %LBLUE%%BOLD%   X     X  X   X  X X  X    X  X   X                        %R%
echo %BGDARK%  %LBLUE%%BOLD%   XXXXXXX  XXXXX  X  X  X    X  XXXXX                        %R%
echo %BGDARK%  %CYAN%%BOLD%   X        X   X  X   X  XXXXXX  X   X                        %R%
echo %BGDARK%  %GRAY%   Freelance Marketplace Platform                             %R%
echo %BGDARK%  %DKGRAY%  ----------------------------------------------------------   %R%
echo %BGDARK%                                                                %R%
echo.

:: Detect if first-time setup is needed
set "NEED_SETUP=0"
if not exist "%BACKEND%\vendor\autoload.php" set "NEED_SETUP=1"
if not exist "%FRONT%\node_modules\.bin"     set "NEED_SETUP=1"

if "%NEED_SETUP%"=="1" (
    call :SETUP
    if errorlevel 1 goto :END
    echo.
    echo %GREEN%%BOLD%  Setup complete! Starting PANDA now...%R%
    echo.
    timeout /t 2 /nobreak >nul
)

:: ══════════════════════════════════════════════════════════════════
:: LAUNCH — runs every time
:: ══════════════════════════════════════════════════════════════════

echo %CYAN%%BOLD%  SYSTEM CHECK%R%
echo %DKGRAY%  -------------------------------------------%R%

where php >nul 2>&1
if errorlevel 1 (
    echo %ERR% %RED%PHP not found%R% %GRAY%— install XAMPP from apachefriends.org%R%
    pause & goto :END
)
for /f "tokens=*" %%v in ('php -r "echo PHP_VERSION;" 2^>nul') do set "PHPVER=%%v"
echo %OK% %WHITE%PHP %PHPVER%%R%

where node >nul 2>&1
if errorlevel 1 (
    echo %ERR% %RED%Node.js not found%R% %GRAY%— delete node_modules folder and run again%R%
    pause & goto :END
)
for /f "tokens=*" %%v in ('node --version 2^>nul') do set "NODEVER=%%v"
echo %OK% %WHITE%Node.js %NODEVER%%R%

where composer >nul 2>&1
if errorlevel 1 (
    echo %ERR% %RED%Composer not found%R% %GRAY%— delete vendor folder and run again%R%
    pause & goto :END
)
echo %OK% %WHITE%Composer%R%

echo %OK% %WHITE%PHP packages (vendor)%R%
echo %OK% %WHITE%Node packages (node_modules)%R%

echo.
echo %CYAN%%BOLD%  DATABASE%R%
echo %DKGRAY%  -------------------------------------------%R%

:: Try to start XAMPP MySQL service automatically
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($n in @('mysql','MySQL','MySQL80')){$s=Get-Service $n -EA SilentlyContinue;if($s){if($s.Status -ne 'Running'){try{Start-Service $n -EA SilentlyContinue;Start-Sleep 3}catch{}};break}}" >nul 2>&1

:: Verify MySQL is responding — if not, prompt user to start it in XAMPP
:CHECK_MYSQL_LAUNCH
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo %WARN% %YELLOW%MySQL is not running!%R%
    echo.
    echo %YELLOW%  Open XAMPP Control Panel and click START next to MySQL,%R%
    echo %YELLOW%  then press any key to continue...%R%
    echo.
    pause >nul
    goto :CHECK_MYSQL_LAUNCH
)
echo %OK% %WHITE%MySQL (XAMPP)%R%

:: Patch .env drivers
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c-replace'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c-replace'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1

pushd "%BACKEND%"
php artisan storage:link --force >nul 2>&1
echo %OK% %WHITE%Storage link%R%

php artisan migrate --force >nul 2>&1
if errorlevel 1 (
    echo %WARN% %YELLOW%Migrations skipped (check DB)%R%
) else (
    echo %OK% %WHITE%Migrations up to date%R%
)

php artisan config:clear >nul 2>&1
php artisan cache:clear  >nul 2>&1
php artisan route:clear  >nul 2>&1
php artisan view:clear   >nul 2>&1
echo %OK% %WHITE%Laravel cache cleared%R%
popd

echo.
echo %CYAN%%BOLD%  LAUNCHING SERVERS%R%
echo %DKGRAY%  -------------------------------------------%R%

echo %INFO% %WHITE%Backend%R%  %GRAY%^>%R%  %LBLUE%http://localhost:8000%R%
start "PANDA Backend" /D "%BACKEND%" cmd /k "color 17 && echo. && echo   PANDA Backend - http://localhost:8000 && echo. && php artisan serve --host=127.0.0.1 --port=8000"
timeout /t 8 /nobreak >nul
echo %OK% %WHITE%Backend running%R%

echo %INFO% %WHITE%Frontend%R% %GRAY%^>%R%  %LBLUE%http://localhost:5173%R%
start "PANDA Frontend" /D "%FRONT%" cmd /k "color 19 && echo. && echo   PANDA Frontend - http://localhost:5173 && echo. && npm run dev"
timeout /t 6 /nobreak >nul
echo %OK% %WHITE%Frontend running%R%

echo.
echo %BGCARD%                                                              %R%
echo %BGCARD%  %BOLD%%CYAN%  PANDA is live!%R%%BGCARD%                                           %R%
echo %BGCARD%                                                              %R%
echo %BGCARD%  %GRAY%  Frontend   %R%%BGCARD%  %WHITE%http://localhost:5173%R%%BGCARD%                       %R%
echo %BGCARD%  %GRAY%  Backend    %R%%BGCARD%  %WHITE%http://localhost:8000%R%%BGCARD%                       %R%
echo %BGCARD%  %GRAY%  phpMyAdmin %R%%BGCARD%  %WHITE%http://localhost/phpmyadmin%R%%BGCARD%                 %R%
echo %BGCARD%                                                              %R%
echo %BGCARD%  %DIM%%GRAY%  Close the terminal windows to stop the servers.%R%%BGCARD%          %R%
echo %BGCARD%                                                              %R%
echo.

start http://localhost:5173
echo %GRAY%  Browser opened. Press any key to close this window...%R%
echo.
pause >nul
goto :END


:: ══════════════════════════════════════════════════════════════════
:: SETUP SUBROUTINE — only on first run
:: ══════════════════════════════════════════════════════════════════
:SETUP
echo %CYAN%%BOLD%  FIRST-TIME SETUP%R% %GRAY%(runs once — please wait)%R%
echo %DKGRAY%  -------------------------------------------%R%
echo.

:: ── [1/5] PHP (XAMPP) ───────────────────────────────────────────
echo %CYAN%  [1/5] PHP%R%
if not exist "C:\xampp\php\php.exe" (
    echo %ERR% %RED%XAMPP PHP not found at C:\xampp%R%
    echo %GRAY%       Install XAMPP from https://apachefriends.org then run again.%R%
    pause
    exit /b 1
)
echo %OK% PHP via XAMPP — Ready
echo.

:: ── [2/5] Composer ──────────────────────────────────────────────
echo %CYAN%  [2/5] Composer%R%
where composer >nul 2>&1
if not errorlevel 1 (
    echo %OK% Composer — Already installed
) else (
    echo %INFO% Installing Composer via winget...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "winget install Composer.Composer --accept-package-agreements --accept-source-agreements --silent 2>&1 | Out-Null"
    if exist "C:\ProgramData\ComposerSetup\bin\composer.bat" set "PATH=C:\ProgramData\ComposerSetup\bin;%PATH%"
    where composer >nul 2>&1
    if errorlevel 1 (
        echo %ERR% %RED%Composer install failed%R%
        echo %GRAY%       Install manually from https://getcomposer.org%R%
        pause
        exit /b 1
    )
    echo %OK% Composer — Installed
)
echo.

:: ── [3/5] Node.js ───────────────────────────────────────────────
echo %CYAN%  [3/5] Node.js%R%
where node >nul 2>&1
if not errorlevel 1 (
    echo %OK% Node.js — Already installed
) else (
    echo %INFO% Installing Node.js via winget...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements --silent 2>&1 | Out-Null"
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=[System.Environment]::GetEnvironmentVariable('Path','Machine')+';'+[System.Environment]::GetEnvironmentVariable('Path','User');[System.Environment]::SetEnvironmentVariable('Path',$p,'Process')"
    for %%p in ("C:\Program Files\nodejs" "%LOCALAPPDATA%\Programs\nodejs") do (
        if exist "%%~p\node.exe" set "PATH=%%~p;%PATH%"
    )
    where node >nul 2>&1
    if errorlevel 1 (
        echo %ERR% %RED%Node.js install failed%R%
        echo %GRAY%       Install from https://nodejs.org then run again.%R%
        pause
        exit /b 1
    )
    echo %OK% Node.js — Installed
)
echo.

:: ── [4/5] MySQL / Database ──────────────────────────────────────
echo %CYAN%  [4/5] MySQL (XAMPP) ^& Database%R%
if not exist "C:\xampp\mysql\bin\mysql.exe" (
    echo %ERR% %RED%XAMPP MySQL not found%R%
    echo %GRAY%       Make sure XAMPP is installed. Run again after installing.%R%
    pause
    exit /b 1
)

:: Try to start MySQL service
powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($n in @('mysql','MySQL','MySQL80')){$s=Get-Service $n -EA SilentlyContinue;if($s){if($s.Status -ne 'Running'){try{Start-Service $n -EA SilentlyContinue;Start-Sleep 4}catch{}};break}}" >nul 2>&1

:: Wait for MySQL to respond — prompt if not running
:MYSQL_WAIT_SETUP
"%MYSQL%" -u root -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo %WARN% %YELLOW%MySQL is not running!%R%
    echo %GRAY%       Open XAMPP Control Panel ^> click START next to MySQL.%R%
    echo %GRAY%       Then press any key to retry...%R%
    pause >nul
    goto :MYSQL_WAIT_SETUP
)
echo %OK% MySQL (XAMPP) — Running

:: Create database
"%MYSQL%" -u root -e "CREATE DATABASE IF NOT EXISTS panda CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" >nul 2>&1
echo %OK% Database 'panda' — Created

:: Import panda.sql only if 'users' table doesn't exist yet
for /f "tokens=*" %%r in ('"%MYSQL%" -u root -s -N -e "SELECT 1 FROM information_schema.tables WHERE table_schema=''panda'' AND table_name=''users'' LIMIT 1;" 2^>nul') do set "HAS_USERS=%%r"
if not defined HAS_USERS (
    if exist "%ROOT%\panda.sql" (
        echo %INFO% Importing panda.sql...
        "%MYSQL%" -u root panda < "%ROOT%\panda.sql" >nul 2>&1
        echo %OK% panda.sql — Imported
    )
)
echo.

:: ── [5/5] Backend ^& Frontend ────────────────────────────────────
echo %CYAN%  [5/5] Backend ^& Frontend%R%

:: Backend .env
if not exist "%BACKEND%\.env" (
    if exist "%BACKEND%\.env.example" (
        copy "%BACKEND%\.env.example" "%BACKEND%\.env" >nul
    )
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%BACKEND%\.env');$c=$c-replace'SESSION_DRIVER=database','SESSION_DRIVER=file';$c=$c-replace'CACHE_STORE=database','CACHE_STORE=file';[IO.File]::WriteAllText('%BACKEND%\.env',$c)" >nul 2>&1
echo %OK% Backend .env — Ready

:: Composer install
echo %INFO% Running composer install (1-2 min)...
pushd "%BACKEND%"
composer install --no-interaction --prefer-dist --optimize-autoloader --quiet
if errorlevel 1 (
    echo %ERR% %RED%composer install failed — check internet connection%R%
    popd & pause & exit /b 1
)
echo %OK% PHP packages — Installed

:: APP_KEY
php artisan key:generate --force >nul 2>&1
echo %OK% APP_KEY — Generated

:: Storage directories
for %%d in ("storage\app\public" "storage\framework\cache\data" "storage\framework\sessions" "storage\framework\views" "storage\logs") do (
    if not exist "%BACKEND%\%%~d" mkdir "%BACKEND%\%%~d" >nul 2>&1
)
php artisan storage:link --force >nul 2>&1

:: Migrations
php artisan migrate --force >nul 2>&1
echo %OK% Migrations — Done
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
echo %OK% Frontend .env — Ready

:: npm install
echo %INFO% Running npm install (1-3 min)...
pushd "%FRONT%"
npm install --prefer-offline >nul 2>&1
if errorlevel 1 (
    npm install
    if errorlevel 1 (
        echo %ERR% %RED%npm install failed — check internet connection%R%
        popd & pause & exit /b 1
    )
)
echo %OK% Node packages — Installed
popd

exit /b 0
:: ── END OF SETUP ─────────────────────────────────────────────────

:END
