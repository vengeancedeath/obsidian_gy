import socket
from datetime import datetime

# ---------------- 配置区 ----------------
LISTEN_PORT = 50009  # 修改为TCP端口50009
pc_client = None  # 保存电脑上位机的连接对象

# 创建 TCP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind(("0.0.0.0", LISTEN_PORT))
sock.listen(1)
print(f"TCP 中转服务启动，监听端口：{LISTEN_PORT}")
print("提示：请先用电脑调试工具连接，注册上位机连接")

while True:
    client_conn, remote_addr = sock.accept()
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{now}] 新客户端接入 {remote_addr}")

    # 第一次连接，认为是电脑上位机
    if pc_client is None:
        pc_client = client_conn
        print(f"✅已记录电脑上位机连接：{remote_addr}")
    else:
        # 模组端连接
        mod_conn = client_conn
        print(f"✅模组客户端接入 {remote_addr}")

        try:
            while True:
                data = mod_conn.recv(1024)  # 最大接收 1024 字节
                now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                if not data:
                    print(f"[{now}] 模组连接断开")
                    break
                print(f"[{now}] [{remote_addr}] recv: {data.hex()} | {data.decode('utf-8','ignore')}")

                # 模组上传的数据，转发给电脑
                pc_client.sendall(data)
                print(f"[{now}] ➡️转发模组数据包到电脑")

        except Exception as e:
            print(f"模组连接异常: {e}")
        finally:
            mod_conn.close()
