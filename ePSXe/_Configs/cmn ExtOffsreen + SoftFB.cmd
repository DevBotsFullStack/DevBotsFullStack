:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥�:
echo          Extended Off-Screen drawing (D3D, OGL1)
echo          ���⮢� ०�� �३�����

rem ����� ��뢠�� ���栭�� ��ꥪ⮢ � "����" �� �࠭�

%setconfig% :regimport "ExtOffsreen.reg"
%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd