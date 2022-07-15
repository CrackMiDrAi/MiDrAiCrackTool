echo off
set MTK_DRV_INST_VERSION=1.02
cls

title Mediatek 驱动一键安装 v.%MTK_DRV_INST_VERSION%

echo ======== Mediatek 驱动一键安装 v.%MTK_DRV_INST_VERSION% ========
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
echo 当前使用的操作系统： %OS%
echo 当前处理器的架构：%PROCESSOR_ARCHITECTURE%
echo .
echo ===============================================================

cls
echo ======== Mediatek 驱动一键安装 v.%MTK_DRV_INST_VERSION% ========
echo .

if not exist "%CD%\Drivers\.fileExist" (
	echo !!!!!!!!!!!!!!!! 未找到驱动文件 !!!!!!!!!!!!!!!!
	echo 如果您没有先解压压缩包再运行脚本，请先将压缩包解压，然后在解压的目录运行本脚本
	echo 如果您确认您解压了压缩包，请联系我反馈此问题
	echo 请按任意键退出脚本
	pause > NUL
	exit
)

set PLATFORM=x86
if "%PROCESSOR_ARCHITECTURE%"=="x86" (set PLATFORM=%CD%\Drivers\x86) ^
else (set PLATFORM=%CD%\Drivers\x64)

echo 当前使用的操作系统： %OS%
echo 当前处理器的架构：%PROCESSOR_ARCHITECTURE%
echo 驱动程序目录：%PLATFORM%
echo .
echo 脚本原作者：www.AndroidMTK.com  魔改：MisaLiu（https://misaliu.top）
echo 未经允许禁止删除版权信息
echo .
echo ===============================================================
echo .

echo 请确认上述信息是否正确！
echo 确认无误后按下任意键开始安装驱动...
pause > NUL

echo .
echo .
echo 正在安装未签名的 Mediatek 驱动...
echo !!!! 如果出现弹窗，请一律允许来自 dpinst.exe 的所有操作 !!!!
"%PLATFORM%\dpinst.exe" /PATH "%PLATFORM%\Unsigned infs" /F /LM /SW /A
echo .

echo 正在安装已签名的 Mediatek 驱动...
echo !!!! 如果出现弹窗，请一律允许来自 dpinst.exe 的所有操作 !!!!
"%PLATFORM%\dpinst.exe" /PATH "%PLATFORM%\Infs" /F /LM /SW /A
echo .

if %PROCESSOR_ARCHITECTURE%=="x86" goto No86VCOMDriver

echo 正在安装 USBVCOM 驱动...
echo !!!! 如果出现弹窗，请一律允许来自 dpinst.exe 的所有操作 !!!!
"%PLATFORM%\dpinst.exe" /PATH "%CD%\Drivers\usbvcom.inf_amd64" /F /LM /SW /A
echo .

echo 正在安装 USBVCOM BROM 驱动...
echo !!!! 如果出现弹窗，请一律允许来自 dpinst.exe 的所有操作 !!!!
"%PLATFORM%\dpinst.exe" /PATH "%CD%\Drivers\usbvcom_brom.inf_amd64" /F /LM /SW /A
echo .
goto end

:No86VCOMDriver
echo !!!!!!!!!!! 您当前的处理器架构（%PROCESSOR_ARCHITECTURE%）不支持 64 位的 USBVCOM 驱动 !!!!!!!!!!!
goto end

:OsNotSupported
echo !!!!!!!!!!! 您当前的操作系统不支持本脚本 !!!!!!!!!!!
echo 请按任意键退出安装脚本...
pause > NUL

:end
echo .
echo ===============================================================
echo 全部驱动安装完毕！
echo 请按任意建退出安装脚本...
pause > NUL

set MTK_DRV_INST_VERSION=1.02
set OS=
set PLATFORM=