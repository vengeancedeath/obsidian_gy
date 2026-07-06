
#移植文件
- 需要移植的文件
Include
portable（portable文件-内核 与 MemMang-内存）
7个.c文件
FreeRTOSConfig.h-配置文件
![[Pasted image 20260629162632.png]]

- 修改FreeRTOSConfig.h
![[Pasted image 20260629160210.png]]

- 修改stm32flxx_it.c
注释掉 PendSV_Handler    SVC_Handler 
导入头文件
![[Pasted image 20260629160535.png]]
修改SysTick_Handler,注意xPortSysTickHandler是否声明
![[Pasted image 20260629160635.png]]

![[Pasted image 20260629161421.png]]
stm32f0xx_hal_timebase_tim.c 为 STMCubeMX生成的SYS切换时钟源文件  可参考


NOTE:一些芯片只有ARM Compiler5 移植支持，如果程序用ARM6，需要修改移植代码，例程是已AI修改后代码

#数据类型及命名规范
![[Pasted image 20260629172614.png]]
![[Pasted image 20260629172659.png]]
![[Pasted image 20260629172903.png]]



#基本知识  
TCB任务控制块 - 存储任务栈指针 及任务相关数据

vApplicationMallocFailedHook - 内存分配失败回调
vApplicationStackOverflowHook - 栈溢出回调
vTaskDelay -- 动态延时

#临界区-不是百分百保险-保证任务不切合，范围内
taskENTER_CRITICAL();  // 进入临界区 作用：保护临界区的代码不会被打断  关闭所有控制的中断（STM32 不是所有中断，所控制的中断，通过BASEPRI）——调用的是FreeRTOS的开关中断
taskEXIT_CRITICAL(); //退出临界区  开启中断

taskENTER_CRITICAL_FROM_ISR(); // 进去临界区（中断里）
taskEXIT_CRITICAL_FROM_ISR(); //  退出临界区 （中断里）

Note:
-所有依赖中断的函数（USB、UART、I2C 等）都不能在临界区内调用----临界区内只能做纯内存操作（赋值、计算），绝不能调用任何依赖中断的外设操作
-几次进入 就需要几次退出
 

