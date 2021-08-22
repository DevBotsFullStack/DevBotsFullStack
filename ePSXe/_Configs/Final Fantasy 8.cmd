:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек для %~n0

%setconfig% :regimport "3D_2DBG.reg"
%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :regimport "Final Fantasy 8.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd