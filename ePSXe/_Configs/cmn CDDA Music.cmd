:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥� ��� ��� � CDDA:
echo		�㤨������� - SPU Core, CD-ROM ������ - W2K CDR Core
echo		^<!^> ���뢠�� cue/ccd, �⮡� ������ CDDA ��몠

%setconfig% :setSoundPlugin "SPUCORE"
%setconfig% :setCdromPlugin "W2KCDRCORE"
%setconfig% :startemu %*
%setconfig% :restore
popd