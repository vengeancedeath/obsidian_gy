---
aliases:
  - linux脚本
tags:
  - linux
data: 2026-04-16T16:33:00
---

@echo off
chcp 65001 > nul
:: 【新增】自动打开一个新的CMD窗口，专门用于SSH连接
:: start cmd /k "echo 已打开SSH专用窗口，直接输入连接命令：ssh 你的Ubuntu用户名@localhost -p 44334 & echo."

:: 新开CMD并自动填入SSH命令，不执行
echo Set ws = CreateObject("WScript.Shell") > %temp%\cmd.vbs
echo ws.Run "cmd" >> %temp%\cmd.vbs
echo WScript.Sleep 300 >> %temp%\cmd.vbs
echo ws.SendKeys "ssh wirthk@localhost -p 44334" >> %temp%\cmd.vbs
cscript //nologo %temp%\cmd.vbs
del %temp%\cmd.vbs

:: 自动跨盘切换到QEMU程序目录（/d是跨盘必须加的参数！）
cd /d "D:\MISC\QEMU\EXE"
:: 运行QEMU启动命令
qemu-system-x86_64.exe ^
-m 6G ^
-smp 8 ^
-cpu max ^
-hda "D:\MISC\QEMU\VM\ubuntu-server.qcow2" ^
-boot c ^
-net nic,model=virtio-net-pci ^
-net user,hostfwd=tcp::44334-:22
pause

TXT文件另存为所有文件格式，name.bat ,编码格式ANSI