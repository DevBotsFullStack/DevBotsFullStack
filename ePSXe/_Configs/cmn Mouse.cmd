:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек:
echo		Контроллер - Мышь/Digital (смена с помощью F5)

%setconfig% :setPadType "mouse"
%setconfig% :startemu %*
%setconfig% :restore
popd