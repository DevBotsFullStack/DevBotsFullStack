:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥�:
echo		����஫��� - GunCon/Digital (ᬥ�� � ������� F5)

rem          �� ��直� ��砩
%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :setPadType "guncon"
%setconfig% :startemu %*
%setconfig% :restore
popd