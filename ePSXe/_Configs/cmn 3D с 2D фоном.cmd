:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥� ��� ��� 3D � 2D 䮭��:
echo		�⪫�祭�� 2xSal 䨫���
echo		���⮢� ०�� �३�����

%setconfig% :regimport "FB_D3D,OGL_0,4.reg"
%setconfig% :regimport "3D_2DBG.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd