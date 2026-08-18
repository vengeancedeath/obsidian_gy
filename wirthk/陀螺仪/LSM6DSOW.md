#六轴惯性传感器
LSM6DSOW 是一颗系统级封装（SiP）的iNEMO 惯性测量单元，集成 3D 数字加速度计 + 3D 数字陀螺仪

#欧拉角
横滚角（Roll）、俯仰角（Pitch）、偏航角（Yaw），也常被直接称为 “姿态角”
![[Pasted image 20260811092502.png]]

#移植
-例程+驱动-pid文件
![[Pasted image 20260812110239.png]]
-驱动
![[Pasted image 20260812135827.png]]
-例程 - 按照例程移植
![[Pasted image 20260812135905.png]]

-需要重写的函数 - 最后一个函数platform_init看例程判断是否需要重写
![[Pasted image 20260812135945.png]]

NOTE: 
参考bilibili or CSDN![[Pasted image 20260818093659.png]]