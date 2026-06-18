#基本知识：
-Bootloader程序放在Flash地址最开始 0x08000000 ,跳转到应用程序 需要跳转到A程序的复位中断地址 即（flash地址+4）

-A程序需要特定的Flash地址
![[Pasted image 20260617155130.png]]

-Flash存储默认小端序0x12345678   78  56  34  12

-Flash内存直接读取的时候用volatile 避免优化


#思路
USB CDC虚拟串口，自定义Bootloader，A/B 双分区管理、固件签名校验、版本回滚、地址拦截、分区映射， 用 CubeProg 的「UART 模式」 ， Bootloader 串口协议和 ST 原厂兼容

![[Pasted image 20260617111320.png]]

ST 原厂协议核心规范（AN2606）
最优开发路径：基于 ST 官方 OpenBootloader 移植

豆包https://www.doubao.com/chat/38430934511545602?channel=xiazais

