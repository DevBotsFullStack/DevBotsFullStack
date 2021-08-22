:: by Rikimaru
@echo off
title ��⠭���� 襩���
pushd %~dp0

call :findEpsxeDir
set setconfig=call "%epsxeDir%\_Configs\settings\setconfig.cmd"

echo  __________.__ __   .__
echo  \______   \__^|  ^| _^|__^| _____ _____ _______ __ __ 
echo   ^|       _/  ^|  ^|/ /  ^|/     \\__  \\_  __ \  ^|  \
echo   ^|    ^|   \  ^|    ^<^|  ^|  Y Y  \/ __ \^|  ^| \/  ^|  /
echo   ^|____^|_  /__^|__^|_ \__^|__^|_^|  (____  /__^|  ^|____/
echo          \/        \/        \/     \/

if "%~1"=="" call :noparams

%setconfig% :setShader %1

echo  ������ ��⠭�����
echo  ��������, �� � ��� �⮨� OpenGL2 ������ (Config ^> Video)
echo  ��� 㢥��祭��/㬥��襭�� ��䥪� 襩��� ����� ���祭�� Shader Level
echo  � Config ^> Video (OpenGL2) ^> Configure
echo.
echo  ������ ���� ������� ��� ��室�...
pause>nul
popd
exit

:noparams
%setconfig% :disableShader

echo  ������ �⪫�祭
echo  ��� ��⠭���� 襩���, ������ ����� � ��� �� ������ �⮣� 䠩��
echo.
echo  ������ ���� ������� ��� ��室�...
pause>nul
exit

rem findEpsxeDir
:findEpsxeDir
call :findNextDir "%~dp0"
exit /b

:findNextDir
for /f "tokens=1,* delims=\" %%i in ("%~1") do (
call :addDirString "%%i"
call :isExeExist "%%j"
)
exit /b

:isExeExist
if exist "%ePSXeDir%\ePSXe.exe" (
  exit /b
) else (
  call :findNextDir "%~1"
)
exit /b

:addDirString
if "%epsxeDir%"=="" (
  set epsxeDir=%~1
) else (
  set epsxeDir=%epsxeDir%\%~1
)
exit /b
rem /findEpsxeDir