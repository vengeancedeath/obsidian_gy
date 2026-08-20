import socket
from datetime import datetime

# ---------------- 配置区 ----------------

LISTEN_PORT = 50008   # 和安全组开放端口保持一致

# --------------------------------------

pc_client = None  # 保存电脑上位机的地址 (ip,port)

# 创建 UDP socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(("0.0.0.0", LISTEN_PORT))

print (f"UDP 中转服务启动，监听端口：{LISTEN_PORT}")
print ("提示：请先用电脑调试工具发送任意数据，注册上位机地址")

while True:
data, remote_addr = sock.recvfrom (1024)  # 最大接收 1024 字节
now = datetime.now ().strftime ("% Y-% m-% d % H:% M:% S")
print (f"[{now}] [{remote_addr}] recv: {data.hex ()} | {data.decode ('utf-8','ignore')}")

# 第一次收到数据包，认为是电脑上位机

if pc_client is None:
pc_client = remote_addr
print (f"✅已记录电脑上位机地址：{pc_client}")
continue

# 如果是电脑发来的包，这里可以预留后续做电脑下发指令给模组，当前暂不处理

if remote_addr == pc_client:
print (f"[{now}] 收到电脑端数据，暂未实现下发到模组")
continue

# 剩下就是模组上传的数据，转发给电脑

sock.sendto (data, pc_client)
print (f"[{now}] ➡️转发模组数据包到电脑 {pc_client}")