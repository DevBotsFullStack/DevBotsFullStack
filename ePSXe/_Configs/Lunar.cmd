:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥� ��� %~n0

%setconfig% :regimport "Lunar.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd