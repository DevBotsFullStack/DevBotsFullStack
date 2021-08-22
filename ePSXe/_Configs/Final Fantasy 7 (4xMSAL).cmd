:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек для %~n0

%setconfig% :setVideoPlugin "gpuPeteOpenGL2.dll"
%setconfig% :setShader "\4xScale shaders\4xMSAL"
%setconfig% :regimport "Final Fantasy 7.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd