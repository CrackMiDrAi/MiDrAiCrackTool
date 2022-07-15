from secrets import choice
import sys
import os
import shutil
from unicodedata import mirrored
import zipfile
import requests
import time

#################################################################################################

dst_dir = f"C:\\Users\\{os.getlogin()}\\AppData\\Local\\Programs\\Python\\Midrai_Tool_Python"
is_python_there = os.path.exists(dst_dir)
cwddir = os.getcwd()

#################################################################################################
def cls():
    os.system("cls")
def unzip_file(zip_src):
    fz = zipfile.ZipFile(zip_src, 'r')
    for file in fz.namelist():
        fz.extract(file, dst_dir)

def bits():
    maxbit=sys.maxsize
    if maxbit>2**32:
        return 64
    else:
        return 32

def Python_Installer():
    cls()
    if is_python_there == False:
        python_exe = f"{dst_dir}\\python.exe"
        bitsNum = bits()
        if bitsNum == 64:
            unzip_file("./python-3.10.5-embed-amd64.zip")
        else:
            unzip_file("./python-3.10.5-embed-win32.zip")
        os.system("setx PATH = %PATH%;dst_dir")
        print("正在安装pip")
        os.system(f"{python_exe} {cwddir}\\files\\get-pip.py")
    else:
        print("python已安装,请勿重复安装")
        time.sleep(2)
        main()


def Drivers_installer():
    cls()
    print("正在安装preload驱动")
    os.system(f"cd /d {cwddir}\\files\\preloader & .\Mediatek-Drivers-Install.bat")
    print("正在安装VCOM驱动")
    os.system(f"cd /d {cwddir}\\files\\VCOM & .\Install_Drivers.bat")
    print("安装完成")
    time.sleep(2)
    main()

def TWRP_flushin():
    cls()
    Midrai_version = "===请选择小爱版本===\nA.4G\nB.WIFI"
    print(Midrai_version)
    Version_ = input("> ")
    if 'a' in Version_ and 'b' in Version_:
        print("输入有误,请重新输入")
        TWRP_flushin()
    elif 'a' in Version_:
        print("请按住小爱音量下插入数据线,等到有反应立即松手")
        os.system(f"cd /d {cwddir}\\files\\mtkclient & .\$4G-TWRP-rec.bat")
        print("执行完成")
        time.sleep(2)
        main()
    elif 'b' in Version_:
        print("请按住小爱音量下插入数据线,等到有反应立即松手")
        os.system(f"cd /d {cwddir}\\files\\mtkclient & .\$WIFI-TWRP-rec.bat")
        print("执行完成")
        time.sleep(2)
        main()


def main():
    cls()
    global choice
    choices_ = """
    A.安装Python
    B.安装驱动
    C.刷入TWRP
    #至此完成基本刷机,如需更多操作请使用@Hotspring和@rponeawa的archytas_tool(例如:刷入Magisk,关闭自动更新...)
    0.全部执行
    Q.退出
    """
    choice = input("请输入要执行的条目(可一次性输入多个,例如ab)")
    if 'a' and '0' in choice or 'b' and '0' in choice or 'c' and '0' in choice:
        print("输入有误")
        main()
    elif 'a' in choice:
        Python_Installer()
    elif 'b' in choice:
        Drivers_installer()
    elif 'c' in choice:
        TWRP_flushin()
    elif '0' in choice:
        Python_Installer()
        Drivers_installer()
        TWRP_flushin()
    elif 'q' in choice:
        sys.exit()
    else:
        print("输入有误")
        main()

if __name__ == '__main__':
    main()