#RAM变量
栈 (Stack) 和 堆 (Heap) 只是 RAM 里的一小块区域
剩余大部分 RAM：给全局变量、静态变量

栈：
函数内部的 普通局部变量（不加 static）
函数的参数
函数调用的返回地址

堆：
`malloc / calloc / free` 手动申请 / 释放的动态内存

RAM
全局变量（函数外面定义）
静态局部变量（函数内 + `static`）

#sizeof与strlen区别
sizeof(line_start)` = 41 (包含了字符串结束符 `\0`)
strlen(line_start)` = 40 (不包含结束符)

#宏定义 
\#define USBD_SELF_POWERED 1 // 普通有符号数字 
\#define USBD_SELF_POWERED 1U // 标准无符号数字（工程推荐）

