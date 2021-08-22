:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек для игр 3D с 2D фоном:
echo		Отключение 2xSal фильтра
echo		Софтовый режим фреймбуфера

%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :regimport "3D_2DBG.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd