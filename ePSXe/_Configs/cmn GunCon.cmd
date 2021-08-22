:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек:
echo		Контроллер - GunCon/Digital (смена с помощью F5)

rem          На всякий случай
%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :setPadType "guncon"
%setconfig% :startemu %*
%setconfig% :restore
popd