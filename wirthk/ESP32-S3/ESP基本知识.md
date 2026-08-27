#开发环境 
VSCode + ESP-IDF插件 + ESP-IDF + python + git

#在线安装
eim-gui-windows-x64.exe

 NOTE:新版不需要修改环境变量

#ESP32S3型号
![[Pasted image 20260825102926.png]]
![[Pasted image 20260825103422.png]]

#引脚
![[Pasted image 20260825103629.png]]

#复位
![[Pasted image 20260825103925.png]]

#strapping引脚 
![[Pasted image 20260825104703.png]]

#启动模式
![[Pasted image 20260825104558.png]]

#JTAG模式
![[Pasted image 20260825104850.png]]

#GPIO交换矩阵和IO-MUX
![[Pasted image 20260824112857.png]]

#工程架构
![[Pasted image 20260825142648.png]]
![[Pasted image 20260826172550.png]]

#内存地址-理解即可
![[Pasted image 20260826173405.png]]
![[Pasted image 20260826173834.png]]
![[Pasted image 20260826173842.png]]
![[Pasted image 20260826173918.png]]
![[Pasted image 20260826174146.png]]

#分区表
![[Pasted image 20260826174948.png]]
![[Pasted image 20260826175014.png]]

#启动
![[Pasted image 20260826174943.png]]

#退出监视
CTRL + ]














#配置项目
![[Pasted image 20260825105556.png]]
-Serial Flasher config
![[Pasted image 20260825110142.png]]
-ESP PSRAM
![[Pasted image 20260825110156.png]]
-ESP System Settings
![[Pasted image 20260825110217.png]]
-FreeRTOS时钟节拍
![[Pasted image 20260825110246.png]]

#日志-3种打印函数
![[Pasted image 20260825105815.png]]

#新建模块/组件
方法一：
![[Pasted image 20260825154811.png]]
方法二：乐鑫的官方组件网站
![[Pasted image 20260826175558.png]]
![[Pasted image 20260826175936.png]]
终端运行

-优化组件CMakeLists


#根目录CMakeLists
![[Pasted image 20260825134739.png]]
若开启 MINIMAL_BUILD ON 时，main 必须写 PRIV_REQUIRES xxxx，否则自定义组件不会加载！这个是最小构建。若无MINIMAL_BUILD 则不用理会
PRIV_REQUIRES 和 MINIMAL_BUILD 搭配使用 ，无MINIMAL_BUILD 无PRIV_REQUIRES
![[Pasted image 20260825115910.png]]



#组件CMakeLists
![[Pasted image 20260825145619.png]]
![[Pasted image 20260825164448.png]]
![[Pasted image 20260825145659.png]]

-两种方式
-.c文件和 CMakeLists.txt文件同一目录，默认模板
![[Pasted image 20260826111305.png]]

-.c文件和 CMakeLists.txt文件不在同一目录，推荐模板
![[Pasted image 20260826111355.png]]
![[Pasted image 20260825145614.png]]


#设置编译选项-正常不需要特殊设置
![[Pasted image 20260825150908.png]]
例如
![[Pasted image 20260825150935.png]]
![[Pasted image 20260825150928.png]]
其中
![[Pasted image 20260825151130.png]]

#例程
在IDF的安装目录examples的文件夹下
-可以新建项目复制出来
-直接复制出源文件至文件夹
移植注意头文件和组件

#例程指南
组件名称及相关信息参考官网
[API 参考 - ESP32 - — ESP-IDF 编程指南 latest 文档](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32/api-reference/index.html)
![[Pasted image 20260826113758.png]]
NOTE:重点


#调试
-驱动
![[Pasted image 20260827115422.png]]
安装 interface2 CDC串口
![[Pasted image 20260827115155.png]]
用zadig 安装interface0 JTAG调试口
![[1.png]]
-调试
启动openocd服务器，开始调试
![[Pasted image 20260827115715.png]]


#ERROR
![[Pasted image 20260826144647.png]]
![[Pasted image 20260826144708.png]]


#fullclean
![[Pasted image 20260825160948.png]]

#BUG 
-在网络共享文件夹里-无法编译/ 能编译，头文件报红(能编译不影响固件)
-新版 ESP‑IDF（5.3+ / 6.x）GPIO 组件依赖 为 esp_driver_gpio ，新版后组件名字变化-看例程指南