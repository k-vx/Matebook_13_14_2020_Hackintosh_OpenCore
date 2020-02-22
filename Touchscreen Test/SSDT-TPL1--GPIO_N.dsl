/*
Necessary Hotpatch for trackpad GPIO Interrupt mode for Huawei Matebook D 2018 by Zero-zer0
With this patch, the dirty SSDT-XOSI is no longer needed.
2 Patches in DSDT is needed, please pair this with "skip" and "count" function of OpenCore
1. _CRS --> XCRS  TgtBridge: TPD0.   5F43525300A00E954F5359530BDC07A453424649A01E935450444D
2. _INI --> XINI  TgtBridge: TPD0.   5F494E4908085F545F3000A012954F5359530BDC075352584F47504449
Don't remember to make changes in Config.plist
*/
DefinitionBlock ("", "SSDT", 2, "hack", "TPD0", 0x00000000)
{

    External (_SB_.PCI0.I2C1.TPL1, DeviceObj)
    External (_SB_.PCI0.I2C1.INT1, IntObj)
    External (_SB_.PCI0.I2C1.INT2, IntObj)
    External (TPLM, FieldUnitObj)
    External (TPLT, FieldUnitObj)
    External (_SB_.PCI0.I2C1._HID, StrObj)
    External (OSYS, FieldUnitObj)
    External (_SB_.SRXO, MethodObj)
    External (GPLI, FieldUnitObj)
    External (TPLS, FieldUnitObj)
    External (TPLH, FieldUnitObj)
    External (TPLB, FieldUnitObj)
    External (_SB_.GNUM, MethodObj)
    External (_SB_.INUM, MethodObj)
    External (_SB_.SHPO, MethodObj)
    External (_SB_.PCI0.I2C1.TPL1.BADR, IntObj)
    External (_SB_.PCI0.I2C1.TPL1.SBFI, BuffObj)
    External (_SB_.PCI0.I2C1.TPL1.SBFB, BuffObj)
    External (_SB_.PCI0.I2C1.TPL1.SBFG, BuffObj)
    External (_SB_.PCI0.I2C1.TPL1.SPED, IntObj)
    External (_SB_.PCI0.I2C1.TPL1.HID2, IntObj)
    External (_SB_.PCI0.I2CM, MethodObj)
    External (_SB_.PCI0.I2C1.I2CX, IntObj)
    

    

    Scope (_SB.PCI0.I2C1.TPL1)
    {    
                Method (_INI, 0, Serialized)  // _INI: Initialize
            {
                If(_OSI ("Darwin")){}
                ElseIf ((OSYS < 0x07DC))
                {
                    SRXO (GPLI, One)
                }

                INT1 = GNUM (GPLI)
                INT2 = INUM (GPLI)
                If ((TPLM == Zero))
                {
                    SHPO (GPLI, One)
                }

                If ((TPLT == One))
                {
                    _HID = "ATML3432"
                    HID2 = Zero
                    BADR = 0x4C
                    SPED = 0x00061A80
                    Return (Zero)
                }

                If ((TPLT == 0x02))
                {
                    _HID = "ATML2952"
                    HID2 = Zero
                    BADR = 0x4A
                    SPED = 0x00061A80
                    Return (Zero)
                }

                If ((TPLT == 0x03))
                {
                    _HID = "ELAN2097"
                    HID2 = One
                    BADR = 0x10
                    SPED = 0x00061A80
                    Return (Zero)
                }

                If ((TPLT == 0x04))
                {
                    _HID = "NTRG0001"
                    HID2 = One
                    BADR = 0x07
                    SPED = 0x00061A80
                    Return (Zero)
                }

                If ((TPLT == 0x05))
                {
                    _HID = "NTRG0002"
                    HID2 = One
                    BADR = 0x64
                    SPED = 0x00061A80
                    Return (Zero)
                }

                If ((TPLT == 0x06))
                {
                    _HID = "WCOM508E"
                    HID2 = One
                    BADR = 0x0A
                    If ((TPLS == Zero))
                    {
                        SPED = 0x00061A80
                    }

                    If ((TPLS == One))
                    {
                        SPED = 0x00061A80
                    }

                    If ((TPLS == 0x02))
                    {
                        SPED = 0x000F4240
                    }

                    Return (Zero)
                }

                If ((TPLT & 0x07))
                {
                    Switch (TPLT)
                    {
                        Case (0x17)
                        {
                            _HID = "SYNA7813"
                        }
                        Case (0x27)
                        {
                            _HID = "ELAN224A"
                        }
                        Case (0x07)
                        {
                            _HID = "CUST0001"
                        }

                    }

                    HID2 = TPLH /* \TPLH */
                    BADR = TPLB /* \TPLB */
                    If ((TPLS == Zero))
                    {
                        SPED = 0x000186A0
                    }

                    If ((TPLS == One))
                    {
                        SPED = 0x00061A80
                    }

                    If ((TPLS == 0x02))
                    {
                        SPED = 0x000F4240
                    }

                    Return (Zero)
                }
            }
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                If (_OSI ("Darwin"))
                {
                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }
                
                If ((OSYS < 0x07DC))
                {
                    Return (SBFI) /* \_SB_.PCI0.I2C1.TPL1.SBFI */
                }

                If ((TPLM == Zero))
                {
                    Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFG))
                }

                Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFI))
            }

            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        

        
             
}

