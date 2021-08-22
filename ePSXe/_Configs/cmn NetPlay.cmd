:: by Rikimaru
@echo off
title ePSXe NetPlay
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo

call :getIP
%setconfig% :backup

echo    �ਬ������ �⥢�� ����஥�

%setconfig% :regimport "_netplay.reg"
rem ��⥢�� ������
rem %setconfig% :setNetPlugin "ps4net.dll"

pushd %epsxeDir%
echo    ����� ePSXe 1.6.0
start /wait "" ePSXe160.exe %*
popd

%setconfig% :restore
popd
exit

:getIP
call :findIP
echo   ��� �������� IP ����: %IP%
echo.
clip 1>nul 2>&1
if not errorlevel 2 (
echo %IP%|clip
echo    IP-���� ᪮��஢�� � ���� ������
)
exit /b

:findIP
rem ��� WinVista � ���
set str=IPv4
rem ��� WinXP
ver|find "5.1" && set str=IP
for /F "tokens=2 delims=:" %%A in ('ipconfig ^| find "%str%"') do for %%B in (%%A) do (set IP=%%B) & (exit /b)