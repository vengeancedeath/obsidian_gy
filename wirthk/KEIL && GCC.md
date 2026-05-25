#KEIL与GCC

需要修改如下：

1.替换启动文件(DEMO)
- gcc startup_stm32f072xb.s
- keil startup_stm32f072xb.s
2.链接脚本
- gcc 存在链接脚本 .ld
- keil 无
3.编译器关键字适配--GCC 扩展语法 Keil 不识别
|GCC 语法|Keil 语法|用途（USB CDC 必用）|
|---|---|---|
|`__attribute__((aligned(4)))`|`__align(4)`|USB 缓冲区对齐|
|`__attribute__((packed))`|`__packed`|结构体压缩|
|`__attribute__((weak))`|`__weak`|弱定义函数|
|`inline`|`__inline`|内联函数|


官方 USB 库的 `USBD_CDC_HandleTypeDef`、端点缓冲区必须**4 字节对齐**，这是移植必改项！ ？？？？？？？？？

4.库配置
- GCC 用 -specs=nano.specs 精简库
- 魔法棒 → Target → 勾选 Use MicroLIB
（否则 printf、malloc、串口打印直接报错）

5.下载配置（Flash 算法）
- keil：魔法棒 → Utilities → Settings → Flash Download（添加：STM32F0xx 128kB Flash）


照搬如下：

1.宏定义 / 头文件路径
- keil路径：魔法棒 → C/C++ → Preprocessor Symbols
- keil路径：魔法棒 → C/C++ → Include Paths

2.c,.h文件


常见错误：
- error: A1167E：Invalid word
    → 启动文件没换，用了 GCC 版汇编
- error: L6915E：Symbol not defined
    → 没开 MicroLIB
- error: Unknown attribute __attribute__
    → GCC 关键字没改成 Keil 格式
- USB 无法枚举/死机
    → USB 缓冲区没做 4 字节对齐

