---
aliases:
  - BUG
tags:
  - BUG
data: 2026-05-13
---

观宇：

	UNEED产品
	- 注意ROM空间 变量大小注意
	- 缓存区不能频繁刷新 
	- SPI CRC 校验在 stm32f0xx_hal_conf.h文件有配置
	
通用：

	- STM32F072 USB接口引脚统一
	- 芯片demo通用模板的时钟 固定时钟 不一定就是芯片的固定时钟 例如LSI 影响systick  
	- EC11编码器：注意波形是否正常还有软件采样时间
	- HAL_MspInit函数里添加 例如
	    __HAL_RCC_SYSCFG_CLK_ENABLE(); // 使能 SYSCFG 系统配置时钟：管理 外部中断 (EXTI)、引脚重映射、I/O 补偿         
	    __HAL_RCC_PWR_CLK_ENABLE(); // 使能 PWR 电源时钟  ：管理低功耗、电压调节、备份区域访问
	- NMI_Handler中断是不可屏蔽中断 ，硬件/系统致命错误：外部时钟 HSE 崩溃（时钟故障），Flash 读写出错，电源电压异常，硬件核心故障，系统时钟安全系统（CSS）报警时触发，建议while(1);停机排查问题
	- Error_Handler 函数里添加  __disable_irq();关闭中断，排查问题
	- USE_FULL_ASSERT 开启完整断言检查（作用：HAL 库会检查函数入参合法性，方便调试参数错误）
	- assert_failed 函数里添加 while(1) ,排查问题 - 开启了 USE_FULL_ASSERT 时才会生效：当 HAL 库检测到函数参数传错（比如引脚号错误、时钟参数非法），就会强制跳转到这个函数，程序一旦参数传错，立刻卡死在这里    发布版关闭 USE_FULL_ASSERT
	- keil 编译switch case 是没有作用域的 要用{}
	- NULL 头文件 #include <stddef.h>