# Matebook_14_2020_Hackintosh_OpenCore
 A hackintosh OpenCore EFI for Huawei Matebook 13/14 2020 Intel Edition(Comet Lake)
 Matebook 14 2020款 黑苹果
## 配置信息
|  | 详细                                                                                                           |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
|型号 | 华为 Matebook 14 **2020款**|
| CPU |    Intel Core i5 10210U/i7 10510U (Comet Lake) |
| GPU | Intel UHD620 / Nvidia mx250 (使用`SSDT-DDGPU`屏蔽) |
|RAM  |     8GB / 16GB|
| 网卡  | Intel 9462AC/9560AC CNVio <br>(无线部分使用`SSDT-Disable-CNVW`屏蔽)|
| 触摸板/触摸屏|  ELAN962C / SYNA7813 （使用修改的`VoodooI2C`驱动） |
| 声卡 |  ALC256（未驱动）|
|SSD | SAMSUNG PM981（无法正常安装，建议更换）<br> WDC PC SN730 (正常使用) |
| LCD | 2160*1440|
|SMBIOS | MacBook 15,4|
## 目前状态
### 目前核显Framebuffer方面有些问题，在i5的机器上会遇到开机后于`AppleIntelCFLGraphicsFramebuffer`处崩溃而无法进入系统（也就是无法驱动）原因未知（可能是DVMT）  
### 欢迎加入 华为Matebook系列黑苹果QQ交流群： 527454189  
#### 由于我并没有这个机器，制作此配置仅仅出于兴趣，所以不会长期维护，而且随时跑路，希望有大佬能够接手<br> <br>目前的版本并不完善，希望能够在使用后有效的反馈帮助提升这个项目  

 ##### 2020-Feb.-17 首次更新（OpenCore 0.5.5）
 1. 触摸屏/触摸板使用[bat.bat](https://github.com/williambj1)编译的修改版VoodooI2C进行驱动,在此表示感谢  
 2. 声卡ALC256，目前**无法驱动**  
 3. 由于没搞清楚独显的具体PCI地址，使用了一个较为通用的`SSDT-DDGPU`屏蔽独显，可能会屏蔽掉潜在的PCIe通道（可能是给网卡用的，我猜）  
 4. CNVi网卡**无法驱动**，使用`SSDT-Disable-CNVW`屏蔽，感谢 [laozhiang](https://github.com/laozhiang)    
 5. Intel蓝牙使用[IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware) 驱动，感谢 [zxystd](https://github.com/zxystd)  
 6. 部分摄像头**无法驱动**    
 7. USB端口未定制，有需求请使用`Hackintool`自行定制   
 8. 已内置Realtek USB网卡驱动，`Wireless Ultility`请下载 [Wireless-USB-Adapter](https://github.com/chris1111/Wireless-USB-Adapter-Clover/releases)  
 9. 其他的想到了再加
____________
 ## Credits
 1. [Acidanthera](https://github.com/acidanthera) for OpenCore (and related documents) , Lilu, AppleALC and other awesome projects.

2. [OC-little](https://github.com/daliansky/OC-little) for their handy ACPI Hotpatches for OpenCore.

3. [VoodooI2C](https://github.com/alexandred/VoodooI2C) for their magnificent work on I2C trackpads.  

4. [zxystd](https://github.com/zxystd)  for awesome works on Intel wireless cards.  

5. [laozhiang](https://github.com/laozhiang) for handy ACPI Hotpatch on Huawei Matebooks.

6. [chris111](https://github.com/chris1111) for maintaing supports on Realtek USB wireless card.  

7. All the friends in QQ Group who support my work😊.