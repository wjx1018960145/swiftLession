//
//  UIDeviceExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/8.
//

import UIKit

class UIDeviceExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展", "二、设备的基本信息", "三、有关设备运营商的信息"]
        dataArray = [["设备的名字", "获取设备类型", "判断是否为 iPad", "判断是否是 pad", "判断是否为 iphone", "判断是否是 iphone5", "判断是否是 iphone6", "是不是 x 系列", "是不是 xs系列", "当前设备是不是模拟器"], ["当前设备的系统版本", "当前系统更新时间", "当前设备的类型", "当前系统的名称", "当前设备的名称", "当前设备是否越狱", "当前硬盘的空间", "当前硬盘可用空间", "当前硬盘已经使用的空间", "获取总内存大小", "当前设备能否打电话", "当前设备语言", "设备区域化型号"], ["sim卡信息", "数据业务对应的通信技术", "设备网络制式", "运营商名字", "移动国家码(MCC)", "移动网络码(MNC)", "ISO国家代码", "是否允许VoIP"]]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - 三、有关设备运营商的信息
extension UIDeviceExtensionViewController {
    
    // MARK: 3.8、是否允许VoIP
    @objc func test38() {
        guard let isAllows = UIDevice.jx.isAllowsVOIPs() else {
            return
        }
        print("是否允许VoIP：\(isAllows)")
    }
    
    // MARK: 3.7、ISO国家代码
    @objc func test37() {
        guard let isoCountryCode = UIDevice.jx.isoCountryCodes() else {
            return
        }
        print("ISO国家代码：\(isoCountryCode)")
    }
    
    // MARK: 3.6、移动网络码(MNC)
    @objc func test36() {
        guard let mobileNetworkCode = UIDevice.jx.mobileNetworkCodes() else {
            return
        }
        print("移动网络码(MNC)：\(mobileNetworkCode)")
    }
    
    // MARK: 3.5、移动国家码(MCC)
    @objc func test35() {
        guard let mobileCountryCode = UIDevice.jx.mobileCountryCodes() else {
            return
        }
        print("移动国家码：\(mobileCountryCode)")
    }
    
    // MARK: 3.4、运营商名字
    @objc func test34() {
        guard let carrierName = UIDevice.jx.carrierNames() else {
            return
        }
        print("运营商名字：\(carrierName)")
    }
    
    // MARK: 3.3、设备网络制式
    @objc func test33() {
        guard let networkType = UIDevice.jx.networkTypes() else {
            return
        }
        print("设备网络制式：\(networkType)")
    }
    
    // MARK: 3.2、数据业务对应的通信技术
    @objc func test32() {
        guard let currentRadioAccessTechnology = UIDevice.jx.currentRadioAccessTechnologys() else {
            return
        }
        print("数据业务对应的通信技术：\(currentRadioAccessTechnology)")
    }
    
    // MARK: 3.1、数据业务对应的通信技术
    @objc func test31() {
        guard let currentRadioAccessTechnology = UIDevice.jx.currentRadioAccessTechnologys() else {
            return
        }
        print("数据业务对应的通信技术：\(currentRadioAccessTechnology)")
    }
}

// MARK: - 二、设备的基本信息
extension UIDeviceExtensionViewController {
    
    //MARK: 2.13、设备区域化型号
    @objc func test213() {
        print("设备区域化型号：\(UIDevice.jx.localizedModel)")
    }
    
    //MARK: 2.12、当前设备语言
    @objc func test212() {
        print("当前设备语言：\(UIDevice.jx.deviceLanguage)")
    }
    
    // MARK: 2.11、当前设备能否打电话
    @objc func test211() {
        print("当前设备能否打电话：\(UIDevice.jx.isCanCallTel())")
    }
    
    // MARK: 2.10、获取总内存大小
    @objc func test210() {
        print("获取总内存大小", "\(FileManager.jx.covertUInt64ToString(with: UInt64(UIDevice.jx.memoryTotal)))")
    }
    
    // MARK: 2.9、当前硬盘已经使用的空间
    @objc func test29() {
        print("当前硬盘已经使用的空间", "\(FileManager.jx.covertUInt64ToString(with: UInt64(UIDevice.jx.diskSpaceUsed)))")
    }
    
    // MARK: 2.8、当前硬盘可用空间
    @objc func test28() {
        print("当前硬盘可用空间", "\(FileManager.jx.covertUInt64ToString(with: UInt64(UIDevice.jx.diskSpaceFree)))")
    }
    
    // MARK: 2.7、当前硬盘的空间
    @objc func test27() {
        print("当前硬盘的空间", "\(FileManager.jx.covertUInt64ToString(with: UInt64(UIDevice.jx.diskSpace)))")
    }
    
    // MARK: 2.6、当前设备是否越狱
    @objc func test26() {
        print("当前设备是否越狱", "\(UIDevice.jx.isJailbroken)")
    }
    
    // MARK: 2.5、当前设备的名称
    @objc func test25() {
        print("当前设备的名称", "\(UIDevice.jx.currentDeviceName)")
    }
    
    // MARK: 2.4、当前系统的名称
    @objc func test24() {
        print("当前系统的名称", "\(UIDevice.jx.currentSystemName)")
    }
    
    // MARK: 2.3、当前设备的类型
    @objc func test23() {
        print("当前系统的类型", "\(UIDevice.jx.deviceType)")
    }
    // MARK: 2.2、当前系统更新时间
    @objc func test22() {
        print("当前系统更新时间", "\(UIDevice.jx.systemUptime)")
    }
    
    // MARK: 2.1、当前设备的系统版本
    @objc func test21() {
        print("当前设备的系统版本", "\(UIDevice.jx.currentSystemVersion)")
    }
}
// MARK: - 一、基本的扩展
extension UIDeviceExtensionViewController {
    
    // MARK: 1.1、设备的名字
    @objc func test11() {
        print("设备的名字", "\(UIDevice.jx.modelName)")
    }
    
    // MARK: 1.2、获取设备类型
    @objc func test12() {
        let screenType = UIDevice.jx.screenType
        print("获取设备类型", "\(String(describing: screenType))")
    }
    
    // MARK: 1.3、判断是否为 iPad
    @objc func test13() {
        print("判断是否为 iPad", "\(UIDevice.jx.isIpad())")
    }
    
    // MARK: 1.4、判断是否是 pad
    @objc func test14() {
        print("判断是否是 pad", "\(UIDevice.jx.isPadDevice())")
    }
    
    // MARK: 1.5、判断是否为 iphone
    @objc func test15() {
        print("判断是否为 iphone", "\(UIDevice.jx.isIphone())")
    }
    
    // MARK: 1.6、判断是否是 iphone5
    @objc func test16() {
        print("判断是否是 iphone5", "\(UIDevice.jx.isIphone5Screen())")
    }
    
    // MARK: 1.7、判断是否是 iphone6
    @objc func test17() {
        print("判断是否是 iphone6", "\(UIDevice.jx.isIphone6Screen())")
    }
    
    // MARK: 1.8、是不是 x 系列
    @objc func test18() {
        print("是不是 x 系列", "\(UIDevice.jx.isIphoneXScreen())")
    }
    
    // MARK: 1.9、是不是 xs系列
    @objc func test19() {
        print("是不是 xs系列", "\(UIDevice.jx.isIphoneXSScreen())")
    }
    
    // MARK: 1.10、当前设备是不是模拟器
    @objc func test110() {
        print("当前设备是不是模拟器", "\(UIDevice.jx.isSimulator())")
    }
}
