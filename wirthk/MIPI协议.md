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
NOTE:
命令模式：双向，可读取状态数据
视频模式：单向

视频模式子模式如下：
![[Pasted image 20260529164741.png]]
NOTEL:
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
	视频模式：以短包传同步信号 + 长包传像素流为主，大部分时间保持 HS 高速
	- Non-Burst：整帧只切换 2 次（帧开始一次进 HS、整帧结束一次出 HS）
	- Burst：逐行切换 HS/LP，消隐区强制切回 LP
	
	视频模式下：
	长包:必须在 HS 高速模式下传输，以保证时序精度
	短包-Burst:	分场景，同步信息（VSync/HSync）通常不独立发短包，控制类短包走LP，仅 HS 突发内的嵌入信息走HS
	- 同步类短包（VSync/HSync/Blank）
		常规 Burst 模式：不独立发送短包，同步信息被嵌入 HS 长包头部作为 Sync Event，行消隐             （HBlank）和场消隐（VBlank）期间物理层保持LP-11 空闲态
		例外情况：若需独立发送同步短包（如 0x01=VSync Start、0x21=HSync Start），会在LP 模式           下传输，然后再执行 LP→HS 切换传输像素长包
	- 控制类短包（DCS 命令、寄存器读写）
		全程在 LP 模式传输，不触发 HS 切换
		典型场景：亮度调节、显示开关、读屏 ID 等控制命令，在消隐区 LP-11 空闲态下发
	- 像素流相关短包
		仅在 HS 突发内传输：长包前的同步码SoT、长包后的结束码EoT以及长包头部的嵌入信息
		不视为独立短包，而是 HS 传输序列的一部分
	


	NOTE:
	只要任意一条数据 Lane进入 HS，时钟 Lane 必须同步进入 HS
	所有数据 Lane 全部切回 LP11，时钟 Lane 才允许切回 LP
	Non-Burst：时钟 Lane 整帧保持 HS
	Burst：时钟 Lane 跟随数据 Lane 逐行 HS/LP 切换
	HS 发送器发送的数据 LP 接收器看到的都是 LP00
	SoT = 0x1D
	EoT 时序长度由芯片 / 屏规格定义


	短包 (Short Packet) —— 4字节固定长度
	[DI: 1B] + [Data0/Data1: 2B] + [ECC: 1B]
	- DI (Data Identifier)：包含虚拟通道号（VC，0-3）和数据类型（如0x05表示DCS写命令）
	- ECC (Error Correcting Code)：可对1位错误纠错、2位错误检测
	- 用途：传输命令、寄存器读写、同步信号（VSync/HSync）

	长包 (Long Packet) —— 6~65541字节可变长度
	[Header: 4B] + [Payload: 0~65535B] + [Footer: 2B]
	 - Header = DI + WC (Word Count，2字节) + ECC
	 - Footer = 16-bit Checksum (CRC)


VBlank 场消隐：帧与帧之间间隔
HBlank 行消隐：单行像素结束到下一行开始的间隔
Active Pixel 有效像素区：真正显示画面的像素数据

![[Pasted image 20260601111823.png]]

Non-Burst with Sync Events
![[Pasted image 20260601111919.png]]

Non-Burst with Sync Pulses
![[Pasted image 20260601112005.png]]

Burst Mode 突发模式（低功耗专用）
![[Pasted image 20260601112025.png]]


