:: by Rikimaru
@echo off
title ePSXe Launcher
pushd %~dp0
set setconfig=call settings\setconfig.cmd

%setconfig% :showlogo
%setconfig% :backup

echo    �ਬ������ ����஥� ��� %~n0
echo		�⪫�祭�� 䨫���樨 ⥪����
echo		(���ᮭ��� ���� �룫���)

%setconfig% :regimport "Xenogears.reg"
%setconfig% :startemu %*
%setconfig% :restore
popd