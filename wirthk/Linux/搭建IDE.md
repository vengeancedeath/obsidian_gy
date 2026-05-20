---
aliases:
  - IDE
tags:
  - linux
  - IDE
data: 2026-04-16T16:33:00
---

#模块组合
	代码编辑器：VIM
	工程编译器：make + arm-none-eabi-gcc
	下载烧录器：OpenOCD
	在线调试器：gdb-multiarch + OpenOCD
	效率增强   ：tmux（screen替代） + ctags
	仓库          ：git
	编译依赖库：build-essential

	NOTE：
	VIM基础配置：.vimrc
	Bash_history基础配置：.bashrc

	screen配置：.screenrc_Arm-UBTinQ

	NOTE:
	要想编译GCC 需要 make + arm-none-eabi-gcc 工具
	.c/.h      源码你的业务代码✅ 有
	Makefile    编译规则✅ 有（标准官方版）
	启动文件.s startup_stm32f103xb.s     ARM 芯片开机执行的第一段代码✅ 有
	链接脚本.ld STM32F103XX_FLASH.ld，定义芯片 RAM/Flash 地址✅ 有
	芯片底层库Drivers/ 文件夹（CMSIS 内核库 + HAL 驱动库）✅ 有	

	编译
	有makefile 直接make
	单个文件 XXXX-gcc xxxx.c -o xxxx/xxxx.exe

#VS_CODE

	 作用：vscode连接虚拟机
	 准备工作如下：
	 VScode安装插件 remote-ssh
	 安装SSH服务端 
	 sudo apt update && sudo apt install openssh-server -y 
	 开机自动启动
	 SSH sudo systemctl enable --now ssh 
	 查看运行状态（看到active(running)就是正常）
	 sudo systemctl status ssh
	 查看本机IP，记下来（后面要用）
	 ip a
	ssh -p 44334 Wirthk_Sheng@127.0.0.1 

	编译
	ctrl + ~ 调出linux终端 make
	

