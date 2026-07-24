  
NTP（Network Time Protocol）是网络时间协议，用于将设备时钟同步到标准时间：UDP协议 

#NTP初始化参数
NTP服务器 - ntp1.aliyun.com阿里云NTP服务器
标准端口号 -  123
超时时间 -  6S（参考）
DNS优先级 - IPV4 or IPV6
设置RTC
NTP回调函数
NTP回调标识

#NTP流程图-1 
![[ntp.png]]


#NTP流程图-2
![[ntp-1.0.png]]![[ntp-1.1.png]]
NOTE:
第二张图为UDP连接
