:: by Rikimaru
@echo off
title ePSXe NetPlay
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo

call :getIP
%setconfig% :backup

echo    Применение сетевых настроек

%setconfig% :regimport "_netplay.reg"
rem Сетевой плагин
rem %setconfig% :setNetPlugin "ps4net.dll"

pushd %epsxeDir%
echo    Запуск ePSXe 1.6.0
start /wait "" ePSXe160.exe %*
popd

%setconfig% :restore
popd
exit

:getIP
call :findIP
echo   Ваш возможный IP адрес: %IP%
echo.
clip 1>nul 2>&1
if not errorlevel 2 (
echo %IP%|clip
echo    IP-адрес скопирован в буфер обмена
)
exit /b

:findIP
rem Для WinVista и выше
set str=IPv4
rem Для WinXP
ver|find "5.1" && set str=IP
for /F "tokens=2 delims=:" %%A in ('ipconfig ^| find "%str%"') do for %%B in (%%A) do (set IP=%%B) & (exit /b)