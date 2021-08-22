:: by Rikimaru
@echo off

if not defined epsxeDir call :findEpsxeDir

setlocal
pushd %~dp0
if "%~1"=="" (
  echo   ^<!^> Не задано имя функции при вызове %~nx0
  pause
) else (
  call %*
)
popd
endlocal
exit /b

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

:backup
echo    Сохранение текущих настроек
call :regexport "hkcu\Software\epsxe\config" "%temp%\epsxebackup.reg" "HKEY_CURRENT_USER\Software\epsxe\config"
call :regexport "hkcu\Software\Vision Thing" "%temp%\visthbackup.reg" "HKEY_CURRENT_USER\Software\Vision Thing"
copy>nul /y "%epsxeDir%\plugins\pec.ini" "%temp%\pecbackup.ini"  || (
	  echo    ^<!^> Ошибка копирования pec.ini
	  echo        Сообщите разработчику
	)
exit /b

:restore
echo    Возвращение настроек
call :regimport "%temp%\epsxebackup.reg"
call :regimport "%temp%\visthbackup.reg"
copy>nul /y "%temp%\pecbackup.ini" "%epsxeDir%\plugins\pec.ini"  || (
	  echo    ^<!^> Ошибка копирования pec.ini
	  echo        Сообщите разработчику
	)
rem del "%temp%\epsxebackup.reg"
rem del "%temp%\visthbackup.reg"
rem del "%temp%\pecbackup.ini"
exit /b

:regimport
reg 1>nul 2>&1 import "%~1"  || regedit /s "%~1" || (
  echo    ^<!^> Ошибка импорта реестра.
  echo        Сообщите разработчику
)
exit /b

:regexport
reg 1>nul 2>&1 export "%~1" "%~2" /y || regedit /e "%~2" "%~3" || (
  echo    ^<!^> Ошибка экспорта реестра.
  echo        Сообщите разработчику
)
exit /b

:setVideoPlugin
reg query "HKCU\Software\epsxe\config" /v "VideoPlugin" | find>nul "gpupec.dll"
if errorlevel 1 (
reg>nul add "HKCU\Software\epsxe\config" /v "VideoPlugin" /t REG_SZ /d "%~1" /f  || (
	  echo    ^<!^> Ошибка установки видеоплагина.
	  echo        Сообщите разработчику
	)
) else (
call :setpecplugin "%~1"
)
exit /b

:setPecPlugin
for /f "tokens=2 delims==" %%i in ('find "Refresh" "%epsxeDir%\plugins\pec.ini"') do set refresh=%%i
chcp 1251 >nul	
  (echo [psx emulation cheater]
   echo Plugin=%epsxeDir%\plugins\%~1
   echo Refresh=%refresh%
   echo HexEditExe=
   echo HexEditCmd=^%%) >"%epsxeDir%\plugins\pec.ini"
if errorlevel 1 (
	echo    ^<!^> Ошибка записи файла pec.ini
	echo        Сообщите разработчику
)
chcp 866 >nul
exit /b

:setSoundPlugin
reg>nul add "HKCU\Software\epsxe\config" /v "SoundPlugin" /t REG_SZ /d "%~1" /f  || (
	echo    ^<!^> Ошибка установки аудиоплагина.
	echo        Сообщите разработчику
	)
exit /b

:setCdromPlugin
reg>nul add "HKCU\Software\epsxe\config" /v "CdromPlugin" /t REG_SZ /d "%~1" /f  || (
	echo    ^<!^> Ошибка установки CD-ROM плагина.
	echo        Сообщите разработчику
	)
exit /b

:setNetPlugin
reg>nul add "HKCU\Software\epsxe\config" /v "NetPlugin" /t REG_SZ /d "%~1" /f  || (
	echo    ^<!^> Ошибка установки плагина сетевой игры.
	echo        Сообщите разработчику
	)
exit /b

:setPadType
for /F "tokens=3" %%i in ('reg query "HKCU\Software\epsxe\config" /v "GamepadType" ^| find "GamepadType"') do set padtype=%%i
if "%~1"=="digital" (
  reg>nul add "HKCU\Software\epsxe\config" /v "GamepadType" /t REG_SZ /d "1%padtype:~1%" /f
  exit /b
)
if "%~1"=="dualshock" (
  reg>nul add "HKCU\Software\epsxe\config" /v "GamepadType" /t REG_SZ /d "4%padtype:~1%" /f
  exit /b
)
if "%~1"=="mouse" (
  reg>nul add "HKCU\Software\epsxe\config" /v "GamepadType" /t REG_SZ /d "2%padtype:~1%" /f
  exit /b
)
if "%~1"=="guncon" (
  reg>nul add "HKCU\Software\epsxe\config" /v "GamepadType" /t REG_SZ /d "3%padtype:~1%" /f
  exit /b
)
echo   ^<!^> Ошибка: неверно задан тип контроллера.
exit /b 1

rem setShader
:setShader
set shaderDir=%epsxeDir%\shaders

set shPath=%~1
if "%shPath:~0,1%"=="\" set shPath=%shaderDir%%shPath%

for %%i in ("%shPath%\*.tga") do (
  call :copyShader "%%i"
)

for %%i in ("%shPath%\*.slf") do (
  call :copyShader "%%i"
)
for %%i in ("%shPath%\*.slv") do (
  call :copyShader "%%i"
) && (call :enableGLSL) && (exit /b)

for %%i in ("%shPath%\*.fp") do (
  call :copyShader "%%i"
)
for %%i in ("%shPath%\*.vp") do (
  call :copyShader "%%i"
) && (call :enableARB)
exit /b

:copyShader
xcopy>nul /y /q %1 "%shaderDir%\" || echo   ^<!^> Ошибка копирования
exit /b

:enableGLSL
reg>nul add "HKCU\Software\Vision Thing\PSEmu Pro\GPU\PeteOpenGL2" /v "FullscreenShader" /t REG_DWORD /d "5" /f
exit /b

:enableARB
reg>nul add "HKCU\Software\Vision Thing\PSEmu Pro\GPU\PeteOpenGL2" /v "FullscreenShader" /t REG_DWORD /d "3" /f
exit /b

:disableShader
reg>nul add "HKCU\Software\Vision Thing\PSEmu Pro\GPU\PeteOpenGL2" /v "FullscreenShader" /t REG_DWORD /d "0" /f
exit /b
rem /setShader

:startemu
pushd %epsxeDir%
echo    Запуск ePSXe
start /wait "" ePSXe.exe %*
popd
exit /b

:showlogo
echo  __________.__ __   .__
echo  \______   \__^|  ^| _^|__^| _____ _____ _______ __ __ 
echo   ^|       _/  ^|  ^|/ /  ^|/     \\__  \\_  __ \  ^|  \
echo   ^|    ^|   \  ^|    ^<^|  ^|  Y Y  \/ __ \^|  ^| \/  ^|  /
echo   ^|____^|_  /__^|__^|_ \__^|__^|_^|  (____  /__^|  ^|____/
echo          \/        \/        \/     \/
echo               ╔═════════════════════════╗
echo               ║ Не закрывайте это окно! ║
echo               ╚═════════════════════════╝
echo  Оно закроется автоматически после выхода из эмулятора.
echo.
exit /b