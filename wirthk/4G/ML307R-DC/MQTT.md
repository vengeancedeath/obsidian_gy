轻量级、发布 / 订阅 (Pub/Sub) 模式的应用层通信协议 - TCP（标准）

#QoS等级
![[Pasted image 20260722163441.png]]
![[Pasted image 20260723093219.png]]
![[Pasted image 20260723093230.png]]
![[Pasted image 20260723093241.png]]
PUBREC   消息已收到
PUBREL    发布释放
PUBCOMP    发布流程完成

#遗嘱消息-Last-Will（LWT）
设备异常掉线（断电、4G 断网、死机，正常主动断开不算）时，Broker 自动向指定 Topic 推送预设消息。

典型用途：云端识别设备异常离线状态。

#Clean-Session-清除会话
CleanSession = 1（true）：断线后订阅关系、未接收消息全部清空；重连需要重新订阅
CleanSession = 0（false）：持久会话，断线期间发给设备的 QoS1 消息会缓存，重连后补发

NB/4G 低功耗设备、经常重连场景慎用持久会话，Broker 缓存过多容易引发问题

#端口号
MQTTS测试服务器端口 - 8883
MQTT测试服务器端口 - 1883

#主题
set    post/reply  需要订阅
post    不需要订阅

#MQTT流程图-1
![[mqtt-1.png]]
![[mqtt-2.png]]
![[mqtt-3.png]]![[mqtt-4.png]]

