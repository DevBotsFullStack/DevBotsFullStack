:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥�:
echo		����஫��� - ����/Digital (ᬥ�� � ������� F5)

%setconfig% :setPadType "mouse"
%setconfig% :startemu %*
%setconfig% :restore
popd