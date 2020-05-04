# Matebook_13/14_2020_Hackintosh_OpenCore
## 配置信息
|  | 详细                                                                                                         |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
|型号 | Huawei Matebook 13/14 **2020**|
| CPU |    Intel Core i5 10210U / i7 10510U (Comet Lake) |
| GPU | Intel UHD620 </br> Nvidia MX250 / MX350 |
|RAM  |     8GB / 16GB LPDDR3|
| 网卡  | Intel 9462AC / 9560AC CNVio <br>|
| 触摸板/触摸屏|  ELAN962C </br> SYNA7813 (MB14) / ELAN224A (MB13)</br>  |
| 声卡 |  ALC256 |
|SSD | SAMSUNG PM981 <br> WDC PC SN730 </br> Toshiba XG6 |
| LCD | 2160*1440|
|SMBIOS | MacBookPro 15,4|
| BIOS | 1.10 </br>(**目前请不要升级1.12,否则可能出现开机黑屏！**)|
--------
### ⚠️制作此配置仅仅出于兴趣
### ⚠️欢迎接手本仓库

## What's working
- [x] Intel UHD 620 核心显卡
- [x] 背光调节
- [x] 背光快捷键
- [x] USB
- [x] 声卡(ALC256, layout-id=21)
- [x] 外放
- [x] 耳机输出
- [x] 机身麦克风
- [x] 触摸板
- [x] Intel 蓝牙
- [x] 睡眠
- [x] NVRAM
- [x] HDMI 输出
   - Matebook 14 2020自带HDMI接口为HDMI 1.4，最高仅支持4K 30Hz输出
- [x] DP输出 
   - 4K 60Hz 需要解锁`DVMT Pre-allocated`至`64M`,使用`ru.efi`或新版`H2OUVE`
</br>


## What's not working / 不工作的硬件
-  Nvidia MX250 （已屏蔽）
-  Intel Wireless 9462/9560 AC CNVio 无线网卡
-  SPI指纹
-  摄像头 (AzureWave)
-  SAMSUNG PM981 NVMe SSD 
   - 可使用全盘恢复法安装，不保证稳定性，建议更换
</br>

## Working with Small Issues / 小问题
- 部分机器上出现`kernel_task`无故起飞 (AppleALC的问题)
   - 在出现这个问题时，**可以尝试通过合盖睡眠再唤醒**

- 触摸屏
   - 欢迎测试并提出issue (~~反正我也不会管~~)

- 耳机孔麦克风输入不工作 (机身麦克风与耳麦输入共用节点)

- Type-C转VGA无法使用，猜测与`LSPCON`有关，建议拥抱数字输出，或尝试使用自带的HDMI口转VGA输出(issue [#3](https://github.com/Zero-zer0/Matebook_13_14_2020_Hackintosh_OpenCore/issues/3))</br> 没有条件进行调试，理解万岁。

</br>


## TODOs after install / 在安装完之后需要做的事
   1. 安装`ComboJack`实现耳机耳麦切换，改进电流声。
      - 在[这里](https://github.com/Heporis/ComboJack)下载由[Heporis](https://github.com/Heporis)制作的ComboJack.
      - 终端运行下面路径的脚本
         
         > ComboJack_Installer/install.sh


   2. 触摸板找不到时，在终端运行
      
      > sudo kextcache -i /
   
   3. 如果你从旧版本的OpenCore转换过来，请`Clean NVRAM`或`Reset NVRAM`+使用EasyUEFI、Bootice等软件重新建立引导  
   
      
   4. **由[chris111](https://github.com/chris1111)维护的Realtek USB 无线网卡驱动**：[Link](https://github.com/chris1111/Wireless-USB-Adapter/files/4301778/Wireless.USB.Adapter-V11.zip)  


   5. `VoodooPS2Controller`有自动关闭触摸板以防误触的功能。如果发现触摸板失效了，可以尝试按一下 `F11`  

         
   7. 开启HiDPI
      - 使用[one-key-hidpi](https://github.com/xzhih/one-key-hidpi)
      - 选择开启HiDPI（**不要**注入EDID）
      - 图标自选
      - 自定义几个3:2的分辨率</br>如`1650*1100`, `1500x1000`, `1350x900`等等  

</br>

## Download / 下载
   下载打包后的Release：

   - [Download](https://github.com/Zero-zer0/Matebook_13_14_2020_Hackintosh_OpenCore/releases)
</br></br>

## ChangeLog
#### 2020-Mar.-4
   - 升级一些kext
   - 启用触摸屏（待测试）



<details>
<summary>Show All</summary>

#### 2020-Apr.-7
   - 升级一些kexts
   - 尝试解决CPU变频失效的问题。

#### 2020-Apr.-3
   - 升级`IntelBluetoothFirmware`: [link](https://github.com/zxystd/IntelBluetoothFirmware/releases/tag/1.0.3)
   - 合并一些ACPI表
   - 加入Matebook 13的电池修补SSDT， 并换用`ACPIBatteryManager`
   - 加入`VerbStub`实现手动耳机切换，以实现更好的音质，需要搭配[ComboJack](https://github.com/Heporis/ComboJack)
   - 使用[bat.bat](https://github.com/williambj1)编译的`VoodooI2C`+`VoodooInput`+`VoodooPS2Controller`
   - 试验性修复Matebook 14的HDMI与HiDPI，但是据称在BIOS `1.12`下会出现**开机黑屏的情况**，**目前请不要升级BIOS**

 #### 2020-Mar.-17
   * 触摸更新
      * Matebook 13 使用`轮询`驱动触摸板，禁用触摸屏
      * Matebook 14 使用`GPIO中断`驱动触摸板，使用`轮询`驱动触摸屏
      * 嫌`GPIO`占用高可以用`SSDT-TPXX-Polling`以使用轮询的方式驱动触摸板，实测占用反而更低，只是顺滑程度略下降。


 #### 2020-Mar.-15 闲得蛋疼测试
 * 增加触摸屏相关的SSDT，可以自行搭配以供折腾</br>
   
      * 由于**触摸屏**会导致`kernel_task`的起飞，而且**触摸板**走`GPIO中断`的占用高于`轮询`。因此加入不同的触摸板+触摸屏的驱动方式以供自行搭配折腾。</br>

      1. 默认存放在`EFI/OC/ACPI`下的`SSDT-TPXX`用于驱动触摸板，走GPIO中断。</br>如果觉得占用`kernel_task`过高使你不爽，可以换用`Tests`文件夹下的`SSDT-TPXX-Polling`使用轮询，文件名称改为`SSDT-TPXX`并替换原文件即可。</br>当然，顺滑度会有所下降，看个人喜好</br></br>

      2. 默认存放在`EFI/OC/ACPI`下的`SSDT-TPX1`用于禁用触摸屏，并且在`VoodooI2C`中也删除了触摸屏I2C控制器的ID.
      如果你想要折腾，
         1. 在`Tests`文件夹下</br>按照机型选择`SSDT-TPX1-GPIO-MBxx`或`SSDT-TPX1-Polling-MBxx`，</br>`GPIO`代表使用`GPIO`中断，`Polling`代表轮询；</br>`MB13`代表Matebook13，`MB14`代表Matebook14</br>选择相应的SSDT后，改名并替换原来的`SSDT-TPX1`。
         2. 替换`Tests`文件夹下的`VoodooI2C.kext`，恢复对触摸屏所在I2C控制器`pci8086,2e9`的支持。
      **欢迎提出使用感受**，目前已知在Matebook13上，同时使用GPIO中断驱动触摸板和触摸屏会导致`kernel_task`起飞🛫️。
      


 #### 2020-Mar.-7
 1. 增加`SSDT-I2CxConf`解决某些时候触摸板失效的问题。
 2. 去除引起冲突的声卡参数
 3. 禁用可能引起CPU无故升高的`ACPI_SMC_PlatformPlugin`


 #### 2020-Mar.-2   全家桶更新
 1. 基于OpenCore 0.5.6，顺带[Acidanthera](https://github.com/acidanthera)全家桶更新  </br>

 2. 基于 `Clover`的测试得出结论：导致`kernel_task`起飞的原因在于触摸屏（感谢群友**Joker**）。</br>无论是走轮询还是走GPIO，都会导致大量的资源消耗，具体是`VoodooI2C`的bug还是其他原因，有待探究。

 3. 加入`CPUFriend`实现更好的电源管理</br>

 4. 加入`config-DVMT64.plist`供**解锁BIOS隐藏设置**后使用，可以达到更好的HiDPI与外接4k效果</br></br>

 


 #### 2020-Feb.-28    触摸板更新
 1. 弃用`SSDT-OC-XOSI`,使用“预置变量法”的方式，启用触摸设备的GPIO中断，感谢 **@宪武**</br> 参见[OC-little](https://github.com/daliansky/OC-little)--《二进制更名与预置变量》、《I2C专用部件》
 * 触摸板`ELAN962C`默认走GPIO中断，`GPIO Pin`由系统固件决定，无需指定
 * 触摸屏`SYNA7813` (MateBook 14) /`ELAN224A` (MateBook 13) 的`GPIO Pin`为`0x42`,强制走`GPIO中断`。VoodooI2C的日志看不出问题，但据报告称，触摸屏只能在开机后“划一下”有反应，然后就没有然后了</br>
* 在MateBook 13上，触摸屏仍然会引起CPU满载的问题，现默认屏蔽。~~**管它呢反正是个鸡肋玩意**~~
</br>
 2. 删除了造成莫名其妙导致机器满载的`CodecCommander.kext`,如果发现其他导致**负载异常**的情况，欢迎提出  </br>
    另外，`FakePCIID`  有一定概率导致CPU满载，但是目前不得不使用以达到驱动声卡的目的，有待进一步观察。</br></br>

 #### 2020-Feb.-25   声卡更新，感谢 [黑果小兵Daliansky](https://github.com/daliansky)
 1. **声卡（ALC256）** 使用AppleALC驱动，`Layout-ID`=~~`56`~~ `21`
      * 在[黑果小兵Daliansky](https://github.com/daliansky) 的指导下，添加声卡`device-id`仿冒，以及`FakePCIID`等kexts
      * 如果**耳机孔麦克风输入不可用**，或者**耳机杂音多**可以尝试运行小兵制作的[ALCPlugFix](https://github.com/Zero-zer0/Matebook_14_2020_Hackintosh_OpenCore/tree/master/AlcPlugFix) ,下载整个文件夹后，双击运行 “`install双击自动安装.command`”,强制输入走机身自带麦克风。
      * ~~**如果内置麦克风输入无声音**，还可以尝试`Layout-ID`=`21`~~</br></br>

 2. 在部分机器上有莫名其妙的`kernel_task`占用起飞的问题，原因之一来自于走轮询模式触摸屏，还不知道怎么从SSDT的角度禁用它，不过你可以从`VoodooI2C`的`info.plist`中删除`pci8086,2e9`的NameMatch
     * ~~在debug文件夹内有我尝试过用`预置变量法`来启用触摸板GPIO中断的SSDT，但是存在一些问题</br></br>~~

 


 #### 2020-Feb.-22  鬼知道还有没有下一次更新的更新
 1. ~~**声卡（ALC256）** 使用`VoodooHDA`驱动~~
    * 使用VoodooHDA提取到的有效路径中，缺少`耳机口MIC输入`的路径  
    * ~~使用`AppleALC`节点路径几乎完全一致的`Layout-ID=21`只能做到内置麦克风输入，猜测是`ConfigData`的问题~~
    * ~~声卡定制仍在学习，欢迎有能力的大佬继续挖掘，已经上传Codec和VoodooHDA的dump文件</br><br>~~
 2. ~~**触摸板与触摸屏**  暂时使用十分dirty的`SSDT-XOSI`实现驱动。~~  </br>
    * 触摸板(`_SB.PCI0.I2C0.TPD0`)可以在`SSDT-XOSI`的作用下默认走GPIO中断    
    * 触摸屏(`_SB.PCI0.I2C1.TPL1`)的`APIC Pin`为`0x6e`，转换出来的`GPIO Pin` ~~是`0x6e` 或~~ `0x42`,能否走GPIO中断还有待测试，目前走轮询。  (Matebook 14可以正常使用。Matebook 13不一定，原因未知)
    * 据群友反映，触摸板有一定概率会在睡眠唤醒后失效，由于未提供日志，原因未知。  </br>
    * ~~已经为触摸屏走GPIO中断写了三个SSDT，具体ACPI需要重命名什么打开看就知道了，count skip懒得数（~~
    * ~~同样可以根据这样的SSDT，为触摸板开启macOS下的GPIO中断，以抛弃`SSDT-XOSI`</br></br>~~
 3. **核显**
    * 目前的`platform-id`为`0xa53e0005`，可以正常驱动，HiDPI正常(貌似)
    * 自带HDMI似乎无法正常工作（没有定制端口）
    * 外接扩展坞的HDMI没有问题
    * 受限于DVMT，只能做到外接2K屏幕，外接4K需要解锁BIOS隐藏项目
    * 有一定的概率会出现关机花屏的情况
    * 有更加合适的`platform-id`欢迎提出

 

 #### 2020-Feb.-17 首次更新（OpenCore 0.5.5正常开机使用）
 1. 触摸屏/触摸板使用 [bat.bat](https://github.com/williambj1) 编译的修改版VoodooI2C进行驱动,在此表示感谢  
 2. ~~声卡ALC256，目前**无法驱动**~~
 3. 由于没搞清楚独显的具体PCI地址，使用了一个较为通用的`SSDT-DDGPU`屏蔽独显，可能会屏蔽掉潜在的PCIe通道（可能是给网卡用的，我猜）  
 4. CNVi网卡**无法驱动**，使用`SSDT-Disable-CNVW`屏蔽，感谢 [laozhiang](https://github.com/laozhiang)    
 5. Intel蓝牙使用 [IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware)  驱动，感谢 [zxystd](https://github.com/zxystd)  
 6. 摄像头**无法驱动** （仿冒`FaceTime HD Camera`似乎无效）   
 7. USB端口未定制，有需求请使用 `Hackintool` 自行定制   
 8. 已内置Realtek USB网卡驱动，`Wireless Ultility`请下载 [Wireless-USB-Adapter](https://github.com/chris1111/Wireless-USB-Adapter-Clover/releases)  
 9. 其他的想到了再加</br></br>


 </details>

</br>

____________
 ## Credits
 1. [Acidanthera](https://github.com/acidanthera) for OpenCore (and related documents) , Lilu, AppleALC and other awesome projects.

2. [OC-little](https://github.com/daliansky/OC-little) for their handy ACPI Hotpatches for OpenCore.

3. [VoodooI2C](https://github.com/alexandred/VoodooI2C) for their magnificent work on I2C trackpads.  

4. [zxystd](https://github.com/zxystd)  for awesome works on Intel wireless cards.  

5. [laozhiang](https://github.com/laozhiang) for handy ACPI Hotpatch on Huawei Matebooks.

6. [chris111](https://github.com/chris1111) for maintaing supports on Realtek USB wireless card.  

7. [Daliansky](https://github.com/daliansky) for instructions on AppleALC and ALCPlugFix.

8. All the friends in QQ Group who support my work.
