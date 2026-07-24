---
aliases:
  - Makefile
tags:
  - Makefile
data: 2026-04-16T16:33:00
---



文件参考标准[Makefile](file:///D:/obsidian/Obsidian-1.12.7/$PLUGINSDIR/app-64/library/files/Makefile)  github存储Makefile Makefile_1.1
- 标准 Makefile：轻量、单文件、适合小项目 / 个人开发，所有配置写死在一个文件
- 项目 Makefile：工程化、模块化、解决Windows 命令行长度超限（大项目必崩），适合量产项目


编译
make
多线程编译
make -j
清除
make clean 


#makefile格式
标准格式如下：


{
\######################################
\# target  目标文件名字
\######################################
TARGET = test1

#######################################
\# paths  编译产物放哪里
#######################################
\# Build path
BUILD_DIR = build
}

{
######################################
\# building variables # 打开调试信息  # 优化等级（适合调试）
######################################
\# debug build?
DEBUG = 1
\# optimization
OPT = -Og
}


{
######################################
\# source  所有要编译的 C 文件
######################################
\# C sources
\# C sources （稳定版：自动递归扫描所有.c文件）
C_SOURCES += $(shell find Core/Src -name '*.c')
C_SOURCES += $(shell find Drivers/STM32F1xx_HAL_Driver/Src -name '*.c')

\# make 4.0版本支持，现在版本低不支持 **
\# C_SOURCES += $(wildcard Core/Src/**/*.c)
\# C_SOURCES += $(wildcard Drivers/STM32F1xx_HAL_Driver/Src/**/*.c)


\# 低级版本
\#  C_SOURCES =  \
\# Core/Src/main.c \
\# Core/Src/stm32f1xx_it.c \
\# Core/Src/stm32f1xx_hal_msp.c \
\# Driver/Src/stm32f1xx_hal_gpio_ex.c \
\# Core/Src/system_stm32f1xx.c \
\# Core/Src/sysmem.c \
\# Core/Src/syscalls.c   

\# ASM sources   启动文件（非常重要）
ASM_SOURCES =  \
startup_stm32f103xb.s
}

\# ASMM sources
ASMM_SOURCES = 


{
#######################################
\# binaries   编译器定义（重点）  使用 arm-none-eabi-gcc 编译器
#######################################
PREFIX = arm-none-eabi-
\# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
\# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
}

{
#######################################
\# CFLAGS  
#######################################
\# cpu  芯片设置
CPU = -mcpu=cortex-m3

\# fpu
\# NONE for Cortex-M0/M0+/M3
\# float-abi

\# mcu  芯片设置
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)
}


\# macros for gcc
\# AS defines
AS_DEFS = 

{
\# C defines  宏定义（告诉编译器你用的芯片）
C_DEFS =  \
-DUSE_HAL_DRIVER \
-DSTM32F103xB
}


\# AS includes
AS_INCLUDES = 

{
\# C includes     头文件路径
C_INCLUDES =  \
-ICore/Inc \
-IDriver/Inc/Legacy 
}

{
\# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS += $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif

\# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"
}

{
#######################################
\# LDFLAGS  
#######################################
\# link script  链接脚本（决定程序放哪里）  告诉编译器： Flash 多大 RAM 多大 代码从哪里开始
LDSCRIPT = STM32F103XX_FLASH.ld

\# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections
}


{
\# default action: build all    最终要生成什么
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin
}


{
#######################################
\# build the application
#######################################
\# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
\# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASMM_SOURCES:.S=.o)))
vpath %.S $(sort $(dir $(ASMM_SOURCES)))

##编译规则（不用懂细节）
$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@
$(BUILD_DIR)/%.o: %.S Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@	
}

{
#######################################
\# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
}

{
#######################################
\# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)
}

\# *** EOF ***


#makefile修改

1.MCU：CPU 架构指令集（最关键！）
MCU = cortex-m3

2.FLOAT / FPU：浮点单元配置 --纯 M0/M3 无 FPU
无FPU芯片（F103/G0/M0/M3）：软浮点
FLOAT = -mfloat-abi=soft 
有FPU芯片（F407/H7/G4）：硬浮点（标准配置） 
FLOAT = -mfloat-abi=hard -mfpu=fpv4-sp-d16

3.ASM_SOURCES：汇编启动文件
ASM_SOURCES += startup_stm32f407xx.s

4.C_INCLUDES：头文件包含路径
5.C_SOURCES：C文件包含路径

6.C_DEFS
C_DEFS += -DSTM32F407xx 

7.AS_DEFS：汇编宏定义
AS_DEFS += -DSTM32F407xx

8.LDFLAGS：链接标志（继承 MCU/FPU 配置） 包含MCU  FLOAT
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

9.链接脚本
LDSCRIPT = STM32F103XX_FLASH.ld




