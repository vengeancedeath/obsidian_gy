---
aliases:
  - 数据传输
tags:
  - linux
  - WinSCP
  - SCP
data: 2026-04-21
---
#WinSCP

	基本设置
	
	文件协议：SFTP
	主机名：localhost
	端口号：44334
	用户名：Wirthk_Sheng
	密码：swp123456

#SCP 

	基本内容：
	windows与linux都建立一个scp_share文件夹，包含scp_share_file与scp_share_directory，传输的时候是互相完全替换文件，所以传输完后需要cp出去，这是临时存放传输文件的空间

	scp_share_file推送命令
		scp -P 44334 -r C:\Users\weiping.sheng\Documents\scp_share\scp_share_file  Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/

	具体脚本如下
		@echo off
		echo ==============================================
		echo        正在执行 SCP 文件传输脚本
		echo ==============================================
		echo.
		
		:: 执行你的SCP传输命令（直接复制你的命令即可）
		scp -P 44334 -r C:\Users\weiping.sheng\Documents\scp_share\scp_share_file Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/
		
		echo.
		echo 传输完成！按任意键关闭窗口...
		pause >nul

	scp_share_directory推送命令
		scp -P 44334 -r C:\Users\weiping.sheng\Documents\scp_share\scp_share_directory  Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/

	具体脚本如下:
		@echo off
		echo ==============================================
		echo        正在执行 SCP 文件夹传输脚本
		echo ==============================================
		echo.
		
		:: 执行你的SCP传输命令（直接复制你的命令即可）
		scp -P 44334 -r C:\Users\weiping.sheng\Documents\scp_share\scp_share_directory  Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/
		
		echo.
		echo 传输完成！按任意键关闭窗口...
		pause >nul

	scp_share_file拉取命令
		scp -P 44334 -r Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/scp_share_file C:\Users\weiping.sheng\Documents\scp_share\

	具体脚本如下:
		@echo off
		echo ==============================================
		echo        正在执行 SCP 文件拉取脚本
		echo ==============================================
		echo.
		
		:: 执行你的SCP传输命令（直接复制你的命令即可）
		scp -P 44334 -r Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/scp_share_file C:\Users\weiping.sheng\Documents\scp_share\
		
		echo.
		echo 传输完成！按任意键关闭窗口...
		pause >nul

	scp_share_directory拉取命令
		scp -P 44334 -r Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/scp_share_directory C:\Users\weiping.sheng\Documents\scp_share\

	具体脚本如下：
		@echo off
		echo ==============================================
		echo        正在执行 SCP 文件夹拉取脚本
		echo ==============================================
		echo.
		
		:: 执行你的SCP传输命令（直接复制你的命令即可）
		scp -P 44334 -r Wirthk_Sheng@localhost:/home/Wirthk_Sheng/scp_share/scp_share_directory C:\Users\weiping.sheng\Documents\scp_share\
		
		echo.
		echo 传输完成！按任意键关闭窗口...
		pause >nul
	

	


