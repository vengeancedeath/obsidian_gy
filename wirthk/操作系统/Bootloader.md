已实现简易跳转及STMCube-usart烧录   参考 github bootloader  

#框架 
stm32-mw-openbl-hal2 — 面向对象的分层架构 --支持芯片少
STM32G0C1E-EV OpenBootloader — 平铺式应用架构 --方便移植--后续再切换架构


#基本知识：
-Bootloader程序放在Flash地址最开始 0x08000000 ,跳转到应用程序 需要跳转到A程序的复位中断地址 即（flash地址+4）

-A程序需要特定的Flash地址
![[Pasted image 20260617155130.png]]

-Flash存储默认小端序0x12345678   78  56  34  12

-Flash内存直接读取的时候用volatile 避免优化


#思路

企业级bootloader
![[Pasted image 20260622162728.png]]

Note:
-擦除写入自定义Size FLASH（注意拼接）
-跳转程序
bootloader  2.消除对A程序的影响
![[Pasted image 20260623101351.png]]
![[Pasted image 20260622151727.png]]

A程序开始前配置
![[Pasted image 20260622151743.png]]


 ![[Pasted image 20260622162744.png]]




目前思路：
![[Pasted image 20260623131444.png]]
![[Pasted image 20260623131456.png]]
USB CDC虚拟串口，固件签名校验、
![[Pasted image 20260617111320.png]]

ST 原厂协议核心规范（AN2606）
最优开发路径：基于 ST 官方 OpenBootloader 移植

豆包https://www.doubao.com/chat/38430934511545602?channel=xiazais

