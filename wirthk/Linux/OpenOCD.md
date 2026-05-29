---
aliases:
  - OpenOCD
tags:
  - OpenOCD
data: 2026-05-27
---

#OpenOCD下载
NOTE：企业防护会挂载所有USB口导致 qemu usb-host模式失效

方法一：   ----待测试？
- 先安装 usbipd-win 工具，实现 USB 共享
- 绑定 ST-LINK 设备 
	usbipd list # 列出所有USB设备 
	usbipd bind --busid 3-1 # 绑定ST-LINK（替换成你的设备总线ID） 
方法二：   ----待测试？
- 先安装Zadig工具，实现 USB 直通虚拟机
	确保驱动文件只有winusb 
- qemu启动命令里添加直通参数 
   -usb ^ # 启用 USB 子系统 
   -device usb-ehci,id=ehci ^# 添加 USB 2.0 控制器（推荐，兼容性更好）
   -device usb-host,bus=ehci.0,vendorid=0x0483,productid=0x3748 ^# ST-LINK 设备 ID 
- 配置 udev 规则（解决权限问题） 
    兼容 ST-LINK V2 / V2-1 / V3 所有型号
    echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748|374b|374e", MODE="0666", GROUP="plugdev", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-stlink.rules

   重载规则 
   sudo udevadm control --reload-rules 
   sudo udevadm trigger
   加用户组 
   sudo usermod -aG plugdev $USER
   重启测试
   lsusb
- 测试 OpenOCD 连接
	测试连接（以 STM32F103 为例） 
	openocd -f interface/stlink.cfg -f target/stm32f1x.cfg
