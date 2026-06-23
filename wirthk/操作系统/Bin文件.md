#bin文件

-基本介绍
![[Pasted image 20260617143354.png]]

-中断向量表4字节对齐 64字节 
其中RAM起始地址 =>      栈顶地址 = RAM起始地址 + 栈大小
例如：
08 16 00 20 存储的时候是 20001608  存储方式 =  0x20000000 + 0x400 + 0x1208
![[Pasted image 20260617143512.png|569]]
![[Pasted image 20260617143701.png]]

-0800005D  => 复位中断地址  对应写到FLASH里面的位置 0x08000000 + 0x149
-08003F15 => NMI-Handle 不可屏蔽中断 红色框框起来都是
-之后一模一样的字节都是自定义中断 没有使用 指向同一个位置
![[Pasted image 20260617144631.png]]

-.map文件能显示总大小
![[Pasted image 20260617145132.png]]

-vscode解析bin文件
终端命令：
certutil -encodehex "G:/TEST_STUDY/STM32Cube_FW_F0_V1.11.0_TEST/Projects/STM32F072B-Discovery/Templates_1.0_TEST_bootloader_ota_usb/MDK-ARM/STM32F072B-Discovery/Exe/Project.bin" "output_hex.txt"

#keil生成bin文件
确定用的是哪个版本
![[Pasted image 20260617140300.png]]
替换掉下方路径
![[Pasted image 20260617135957.png]]
添加到以下地点即可
![[Pasted image 20260617140416.png]]

