# Matebook_13/14_2020_Hackintosh_OpenCore
 A hackintosh OpenCore EFI for Huawei Matebook 13/14 2020 Intel Edition(Comet Lake)
 Matebook 13/14 2020款 黑苹果
## 配置信息
|  | 详细                                                                                                         |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
|型号 | 华为 Matebook 13/14 **2020款**|
| CPU |    Intel Core i5 10210U/i7 10510U (Comet Lake) |
| GPU | Intel UHD620 </br> Nvidia mx250 (使用`SSDT-DDGPU`屏蔽) |
|RAM  |     8GB / 16GB LPDDR3|
| 网卡  | Intel 9462AC/9560AC CNVio <br>(无线部分使用`SSDT-Disable-CNVI`屏蔽)|
| 触摸板/触摸屏|  ELAN962C / SYNA7813 (MB14) / ELAN224A (MB13) （使用修改的`VoodooI2C`驱动） |
| 声卡 |  ALC256 |
|SSD | SAMSUNG PM981（无法正常安装，建议更换）<br> WDC PC SN730 (正常使用) |
| LCD | 2160*1440|
|SMBIOS | MacBook 15,4|
## 目前状态
### 欢迎加入 华为Matebook系列黑苹果QQ交流群： 527454189  
#### 由于我并没有机器，制作此配置仅仅出于兴趣，所以不会长期维护，而且随时跑路，希望有大佬能够接手<br> <br>

 ##### 2020-Feb.-25   声卡更新，感谢 [黑果小兵Daliansky](https://github.com/daliansky)
 1. **声卡（ALC256）** 使用AppleALC驱动，`Layout-ID`=`56`
      * 在[黑果小兵Daliansky](https://github.com/daliansky) 的指导下，添加声卡`device-id`仿冒，以及`FakePCIID`等kexts
      * 如果耳机孔麦克风输入不可用，可以尝试运行小兵制作的[ALCPlugFix](https://github.com/Zero-zer0/Matebook_14_2020_Hackintosh_OpenCore/tree/master/AlcPlugFix) ,下载整个文件夹后，双击运行 “`install双击自动安装.command`”,     强制输入走机身自带麦克风。</br></br>
 
 
 
 ##### 2020-Feb.-22  鬼知道还有没有下一次更新的更新
 1. ~~**声卡（ALC256）** 使用`VoodooHDA`驱动~~
    * 使用VoodooHDA提取到的有效路径中，缺少`耳机口MIC输入`的路径  
    * ~~使用`AppleALC`节点路径几乎完全一致的`Layout-ID=21`只能做到内置麦克风输入，猜测是`ConfigData`的问题~~
    * ~~声卡定制仍在学习，欢迎有能力的大佬继续挖掘，已经上传Codec和VoodooHDA的dump文件</br><br>~~
 2. **触摸板与触摸屏**  暂时使用十分dirty的`SSDT-XOSI`实现驱动。  </br>
    * 触摸板(`_SB.PCI0.I2C0.TPD0`)可以在`SSDT-XOSI`的作用下默认走GPIO中断    
    * 触摸屏(`_SB.PCI0.I2C1.TPL1`)的`APIC Pin`为`0x6e`，转换出来的`GPIO Pin` 是`0x6e` 或 `0x42`,能否走GPIO中断还有待测试，目前走轮询。  (Matebook 14可以正常使用。Matebook 13不一定，原因未知)
    * 据群友反映，触摸板有一定概率会在睡眠唤醒后失效，由于未提供日志，原因未知。  </br>
    * 已经为触摸屏走GPIO中断写了三个SSDT，具体ACPI需要重命名什么打开看就知道了，count skip懒得数（
    * 同样可以根据这样的SSDT，为触摸板开启macOS下的GPIO中断，以抛弃`SSDT-XOSI`</br></br>
 3. **核显**
    * 目前的`platform-id`为`0xa53e0000`，可以正常驱动，HiDPI正常
    * 自带HDMI似乎无法正常工作
    * 外接扩展坞的HDMI没有问题
    * 受限于DVMT，只能做到外接2K屏幕，外接4K需要解锁BIOS隐藏项目
    * 有一定的概率会出现关机花屏的情况
    * 有更加合适的`platform-id`欢迎提出
  
 
 
 ##### 2020-Feb.-17 首次更新（OpenCore 0.5.5正常开机使用）
 1. 触摸屏/触摸板使用 [bat.bat](https://github.com/williambj1) 编译的修改版VoodooI2C进行驱动,在此表示感谢  
 2. ~~声卡ALC256，目前**无法驱动**~~
 3. 由于没搞清楚独显的具体PCI地址，使用了一个较为通用的`SSDT-DDGPU`屏蔽独显，可能会屏蔽掉潜在的PCIe通道（可能是给网卡用的，我猜）  
 4. CNVi网卡**无法驱动**，使用`SSDT-Disable-CNVW`屏蔽，感谢 [laozhiang](https://github.com/laozhiang)    
 5. Intel蓝牙使用 [IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware)  驱动，感谢 [zxystd](https://github.com/zxystd)  
 6. 摄像头**无法驱动** （仿冒`FaceTime HD Camera`似乎无效）   
 7. USB端口未定制，有需求请使用 `Hackintool` 自行定制   
 8. 已内置Realtek USB网卡驱动，`Wireless Ultility`请下载 [Wireless-USB-Adapter](https://github.com/chris1111/Wireless-USB-Adapter-Clover/releases)  
 9. 其他的想到了再加</br></br>
____________
 ## Credits
 1. [Acidanthera](https://github.com/acidanthera) for OpenCore (and related documents) , Lilu, AppleALC and other awesome projects.

2. [OC-little](https://github.com/daliansky/OC-little) for their handy ACPI Hotpatches for OpenCore.

3. [VoodooI2C](https://github.com/alexandred/VoodooI2C) for their magnificent work on I2C trackpads.  

4. [zxystd](https://github.com/zxystd)  for awesome works on Intel wireless cards.  

5. [laozhiang](https://github.com/laozhiang) for handy ACPI Hotpatch on Huawei Matebooks.

6. [chris111](https://github.com/chris1111) for maintaing supports on Realtek USB wireless card.  

8. [Daliansky](https://github.com/daliansky) for instructions on AppleALC and ALCPlugFix.

7. All the friends in QQ Group who support my work😊.