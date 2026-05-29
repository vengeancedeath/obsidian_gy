多媒体层

    DSI(Display Serial Interface)     处理器 → 显示屏，传输图像/视频
	CSI(Camera Serial Interface)     摄像头 → 处理器，传输图像/视频
	.......
物理层

	D-PHY    最基本的"马路"，DSI/CSI的底层标准，速率1.5-4.5Gbps/通道        
	C-PHY    更高效的"马路"，采用独特的三相编码，速率可达6Gbps/通道，与D-PHY引脚兼容 
	M-PHY    为存储等场景设计，速率更高（11.6Gbps），采用嵌入式时钟       
	A-PHY    专为汽车设计，传输距离可达15米，抗干扰能力强    
	.......
应用最广的 D-PHY 为例

	高速（HS, High-Speed）模式：用于传输大量数据（如视频流）。采用低压差分信号（典型摆幅仅200mV），速快、功耗相对较低
	低功耗（LP, LP Low-Power）模式：用于传输控制指令或处于空闲状态。采用单端信号（摆幅1.2V），功耗极低


#DSI协议

常用传输模式如下：
![[Pasted image 20260529152610.png|697]]

顶层模式如下：
![[Pasted image 20260529165745.png]]
命令模式：双向，可读取状态数据
视频模式：单向

视频模式子模式如下：
![[Pasted image 20260529164741.png]]
普通传输模式（Non-Burst）：依赖同步脉冲 / 事件包
突发传输模式（Burst）：依靠 BLLP（消隐 / 低功耗间隔）边界同步

同步脉冲和同步事件区分如下：
![[Pasted image 20260529164918.png]]

	一对时钟差分线 + 一到四对数据差分线
	Lane0 是高速低速双向传输
	Lane1-4 高速低速向从机传输
	LP-00 -> 前一个0表示Dp的电平为低（低速模式低电平），后一个0表示Dn的电平为低（低速模式低电平）

![[Pasted image 20260529110217.png]]

命令模式：以短包发命令 + 长包传像素数据为主，频繁在 HS/LP 间切换
视频模式：以长包传像素流 + 短包传同步信号为主，大部分时间保持 HS 高速（长短包必须在 HS 高速模式下传输，以保证时序精度）

	短包 (Short Packet) —— 4字节固定长度
	[DI: 1B] + [Data0/Data1: 2B] + [ECC: 1B]
	- DI (Data Identifier)：包含虚拟通道号（VC，0-3）和数据类型（如0x05表示DCS写命令）
	- ECC (Error Correcting Code)：可对1位错误纠错、2位错误检测
	- 用途：传输命令、寄存器读写、同步信号（VSync/HSync）

	长包 (Long Packet) —— 6~65541字节可变长度
	[Header: 4B] + [Payload: 0~65535B] + [Footer: 2B]
	 - Header = DI + WC (Word Count，2字节) + ECC
	 - Footer = 16-bit Checksum (CRC)


