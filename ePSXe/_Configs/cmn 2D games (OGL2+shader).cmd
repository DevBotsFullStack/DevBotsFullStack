:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥� ��� 2D ���:
echo		����������� - OGL2
echo		������ - 4xMSAL

%setconfig% :setVideoPlugin "gpuPeteOpenGL2.dll"
%setconfig% :setShader "\4xScale shaders\4xMSAL"

%setconfig% :restore
popd