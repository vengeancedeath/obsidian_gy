#UDB_CDC_虚拟串口（VCP）
用 USB 线连接 STM32 USB 口到电脑----USB 线模拟串口
具体代码参考github  [gy_demo/USB_CDC]

- 发送数据（单片机 → 电脑）
CDC_Transmit_FS((uint8_t*)"Hello USB CDC\r\n", 14);

- 接收数据（电脑 → 单片机）
int8_t CDC_Receive_FS(uint8_t* Buf, uint32_t *Len) { 
// Buf 就是收到的数据 
// Len 是长度 /
/ 在这里处理数据 }

- 初始化（不用管，例程已经做好）
MX_USB_DEVICE_Init();

- 中断
void USB_IRQHandler(void)
{HAL_PCD_IRQHandler(&hpcd_USB_FS);

NOTE:
- 虚拟串口识别不到，重新初始化IO口，在MX_USB_DEVICE_Init之前，拉低电平，增加延迟。
- USB Bulk传输是以包为级别，现在最大字节配置是64字节，现在之所以8字节为一包，是因为发的是8字节，如果四字节发一包 ，那四字节就触发一次中断





