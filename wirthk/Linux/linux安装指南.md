---
aliases:
  - linux安装
tags:
  - linux
data: 2026-04-16T16:33:00
---

#AI搜索安装虚拟机qemu（具体安装流程参考AI）

	特殊情况可以通过7-zip 解压exe文件
	
#通过qemu-img创建虚拟磁盘

	通过CMD到qemu目录新建磁盘
	命令：qemu-img create -f qcow2 D:\MISC\QEMU\VM\ubuntu-server.qcow2 50G
	注释:通过qemu-img 工具创造一个 -f 格式 qcow2 路径 大小 的虚拟磁盘
	
#AI搜索ubuntu下载iso文件

	如ubuntu-24.04.4-live-server-amd64.iso
	
#安装ubuntu-具体安装流程参考AI
	
	通过CMD到qemu目录安装ubuntu（能装完整版就不要最简版）
	
	版本1：基础优化版(确保能安装)
	qemu-system-x86_64.exe ^
	-m 6G ^		//按实际配置调整
	-smp 8 ^		//按实际配置调整
	-cdrom "D:\MISC\ubuntu\ubuntu-24.04.4-live-server-amd64.iso" ^  //ubuntu地址
	-hda "D:\MISC\QEMU\VM\ubuntu-server.qcow2" ^ //虚拟磁盘地址
	-boot d ^
	-net nic,model=virtio-net-pci ^
	-net user,hostfwd=tcp::44334-:22 ^
	--accel whpx ^	 //若whpx开启不了 可先不配置
	--display sdl  //影响速度 可不开启
	
	版本2：极致性能版  电脑封印 导致无法使用virtio
	qemu-system-x86_64.exe ^
	-m 6G ^
	-smp 8 ^
	-cpu host ^     //依赖硬件虚拟化加速   无加速可用 cpu max
	-cdrom "D:\MISC\ubuntu\ubuntu-24.04.4-live-server-amd64.iso" ^
	-drive if=virtio,file="D:\MISC\QEMU\VM\ubuntu-server.qcow2",cache=none,discard=unmap,aio=threads ^
	-boot d ^
	-net nic,model=virtio-net-pci ^
	-net user,hostfwd=tcp::44334-:22 ^
	--accel whpx ^  //若whpx开启不了 可先不配置
	--display sdl   //影响速度 可不开启
	
	NOTE:
	1.下次启动需要移除 -cdrom  
	2.-boot c  
	
	安装时需要配置这些参数
	name:swp
	hostname:wirthk
	password:swp123456
	server:s-ubuntu-server
	

		