#ascoket例程
![[Pasted image 20260819145809.png]]
![[Pasted image 20260819145814.png]]![[Pasted image 20260819145820.png]]
1.获取IP地址（若为域名，需要先在cm_async_dns_eloop循环 注册事件调用 cm_async_dns_request解析DNS）
2.创建asocket对象 cm_asocket_open
3.连接目标地址 cm_asocket_connect
4.发送数据 cm_asocket_send 




NOTE:
-asocket连接需要在 cm_asocket_eloop循环里
-cm_asocket_sendto 和 cm_asocket_send 区别
![[Pasted image 20260819150435.png]]
UDP 的 `connect` 不是真正的连接，只是把目标地址和 socket 绑定，之后 `send` 就不用再指定地址了。



