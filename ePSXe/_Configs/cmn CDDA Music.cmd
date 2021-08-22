:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    Применение настроек для игр с CDDA:
echo		Аудиоплагин - SPU Core, CD-ROM плагин - W2K CDR Core
echo		^<!^> Открывайте cue/ccd, чтобы появилась CDDA музыка

%setconfig% :setSoundPlugin "SPUCORE"
%setconfig% :setCdromPlugin "W2KCDRCORE"
%setconfig% :startemu %*
%setconfig% :restore
popd