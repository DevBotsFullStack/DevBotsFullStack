:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек для %~n0 (для D3D и OGL1)

%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :regimport "Final Fantasy 9.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd