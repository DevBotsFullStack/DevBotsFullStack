:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек для 2D игр:
echo		Видеоплагин - P.E.Op.S. Soft

%setconfig% :setVideoPlugin "gpuPeopsSoft.dll"
%setconfig% :startemu %*
%setconfig% :restore
popd