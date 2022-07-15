echo off
set MTK_DRV_INST_VERSION=1.02
cls

title Mediatek ����һ����װ v.%MTK_DRV_INST_VERSION%

echo ======== Mediatek ����һ����װ v.%MTK_DRV_INST_VERSION% ========
echo .
for /f %%i in ('ver^|find "5.0."') do set OS = Windows NT && set osrecognized = 1
for /f %%i in ('ver^|find "5.1."') do set OS = Windows XP && set osrecognized = 1
for /f %%i in ('ver^|find "5.2."') do set OS = Windows 2003 && set osrecognized = 1
for /f %%i in ('ver^|find "6.0."') do set OS = Windows Vista && set osrecognized = 1
for /f %%i in ('ver^|find "6.1."') do set OS = Windows 7 && set osrecognized = 1
for /f %%i in ('ver^|find "6.2."') do set OS = Windows 8 && set osrecognized = 1
for /f %%i in ('ver^|find "6.3."') do set OS = Windows 8.1 && set osrecognized = 1
for /f %%i in ('ver^|find "10."')  do set OS=Windows 10&& set osrecognized = 1
echo .

:: if not defined osrecognized goto OsNotSupported

echo .
echo ��ǰʹ�õĲ���ϵͳ�� %OS%
echo ��ǰ�������ļܹ���%PROCESSOR_ARCHITECTURE%
echo .
echo ===============================================================

cls
echo ======== Mediatek ����һ����װ v.%MTK_DRV_INST_VERSION% ========
echo .

if not exist "%CD%\Drivers\.fileExist" (
	echo !!!!!!!!!!!!!!!! δ�ҵ������ļ� !!!!!!!!!!!!!!!!
	echo �����û���Ƚ�ѹѹ���������нű������Ƚ�ѹ������ѹ��Ȼ���ڽ�ѹ��Ŀ¼���б��ű�
	echo �����ȷ������ѹ��ѹ����������ϵ�ҷ���������
	echo �밴������˳��ű�
	pause > NUL
	exit
)

set PLATFORM=x86
if "%PROCESSOR_ARCHITECTURE%"=="x86" (set PLATFORM=%CD%\Drivers\x86) ^
else (set PLATFORM=%CD%\Drivers\x64)

echo ��ǰʹ�õĲ���ϵͳ�� %OS%
echo ��ǰ�������ļܹ���%PROCESSOR_ARCHITECTURE%
echo ��������Ŀ¼��%PLATFORM%
echo .
echo �ű�ԭ���ߣ�www.AndroidMTK.com  ħ�ģ�MisaLiu��https://misaliu.top��
echo δ�������ֹɾ����Ȩ��Ϣ
echo .
echo ===============================================================
echo .

echo ��ȷ��������Ϣ�Ƿ���ȷ��
echo ȷ����������������ʼ��װ����...
pause > NUL

echo .
echo .
echo ���ڰ�װδǩ���� Mediatek ����...
echo !!!! ������ֵ�������һ���������� dpinst.exe �����в��� !!!!
"%PLATFORM%\dpinst.exe" /PATH "%PLATFORM%\Unsigned infs" /F /LM /SW /A
echo .

echo ���ڰ�װ��ǩ���� Mediatek ����...
echo !!!! ������ֵ�������һ���������� dpinst.exe �����в��� !!!!
"%PLATFORM%\dpinst.exe" /PATH "%PLATFORM%\Infs" /F /LM /SW /A
echo .

if %PROCESSOR_ARCHITECTURE%=="x86" goto No86VCOMDriver

echo ���ڰ�װ USBVCOM ����...
echo !!!! ������ֵ�������һ���������� dpinst.exe �����в��� !!!!
"%PLATFORM%\dpinst.exe" /PATH "%CD%\Drivers\usbvcom.inf_amd64" /F /LM /SW /A
echo .

echo ���ڰ�װ USBVCOM BROM ����...
echo !!!! ������ֵ�������һ���������� dpinst.exe �����в��� !!!!
"%PLATFORM%\dpinst.exe" /PATH "%CD%\Drivers\usbvcom_brom.inf_amd64" /F /LM /SW /A
echo .
goto end

:No86VCOMDriver
echo !!!!!!!!!!! ����ǰ�Ĵ������ܹ���%PROCESSOR_ARCHITECTURE%����֧�� 64 λ�� USBVCOM ���� !!!!!!!!!!!
goto end

:OsNotSupported
echo !!!!!!!!!!! ����ǰ�Ĳ���ϵͳ��֧�ֱ��ű� !!!!!!!!!!!
echo �밴������˳���װ�ű�...
pause > NUL

:end
echo .
echo ===============================================================
echo ȫ��������װ��ϣ�
echo �밴���⽨�˳���װ�ű�...
pause > NUL

set MTK_DRV_INST_VERSION=1.02
set OS=
set PLATFORM=