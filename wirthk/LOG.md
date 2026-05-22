
void USB_Printf(const char *format, ...) { va_list args; // 可变参数列表 uint32_t length; va_start(args, format); // 核心：格式化拼接字符串（支持%d %x %s 等） length = vsnprintf((char *)UserTxBufferFS, APP_TX_DATA_SIZE, (char *)format, args); va_end(args); CDC_Transmit_FS(UserTxBufferFS, length); // 发送拼接好的数据 }

？？？？？？？？？？？