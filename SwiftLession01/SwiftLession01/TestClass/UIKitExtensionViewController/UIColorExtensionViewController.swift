//
//  UIColorExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIColorExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、构造器设置颜色", "二、使用方法设置颜色", "三、UIColor的一些方法", "四、UIColor 的一些属性", "五、获取UIColor的HSV/HSB值（Hue色相、S饱和度、B亮度）", "六、暗黑模式颜色处理类"]
        dataArray = [["根据 RGBA 设置颜色", "十六进制字符串设置颜色", "十六进制 Int 设置颜色"], ["根据 RGBA 设置颜色(方法)", "十六进制字符串设置颜色(方法)", "十六进制 Int 颜色的使用(方法)"], ["根据 十六进制字符串 获取 RGB，如：#3CB371 或者 ##3CB371 -> 60,179,113", "根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113", "color 转 RGBA"], ["UIColor 转十六进制颜色的字符串", "随机色"], ["返回HSBA模式颜色值"], ["深色模式和浅色模式颜色设置，非layer颜色设置"]]
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
// MARK: - 业务颜色的使用
extension UIColor {
    /// 颜色
    private(set) static var cB1: UIColor = UIColor.darkModeColor(lightColor: UIColor.green, darkColor: UIColor.blue)
    /// 背景色
    private(set) static var cBackViewColor: UIColor = JXDarkModeUtil.colorLightDark(lightColor: UIColor.hexStringColor(hexString: "#FAFAFA"), darkColor: UIColor.hexStringColor(hexString: "#121212"))
    /// 字体颜色
    private(set) static var cN1: UIColor = JXDarkModeUtil.colorLightDark(lightColor: UIColor.hexStringColor(hexString: "#333333"), darkColor: UIColor.hexStringColor(hexString: "#FFFFFF").withAlphaComponent(0.85))
    /// N2 适用辅助标题、辅助文字色、未选中、不可选置灰 #999999
    private(set) static var cN2: UIColor = JXDarkModeUtil.colorLightDark(lightColor: UIColor.hexStringColor(hexString: "#999999"), darkColor: UIColor.hexStringColor(hexString: "#FFFFFF").withAlphaComponent(0.6))
    private(set) static var cN3: UIColor = JXDarkModeUtil.colorLightDark(lightColor: UIColor.hexStringColor(hexString: "#666666"), darkColor: UIColor.hexStringColor(hexString: "#FFFFFF").withAlphaComponent(0.4))
    /// 横线颜色
    private(set) static var cN4: UIColor = UIColor.darkModeColor(lightColor: UIColor.hexStringColor(hexString: "#EBEBEB"), darkColor: UIColor.hexStringColor(hexString: "#FFFFFF").withAlphaComponent(0.10))
}
    
// MARK: 六、暗黑模式颜色处理类
extension UIColorExtensionViewController {
    
    // MARK: 6.1、深色模式和浅色模式颜色设置，非layer颜色设置
    @objc func test61() {
        self.tableView.backgroundColor = .cB1
    }
}

// MARK: - 五、获取UIColor的HSV/HSB值（Hue色相、S饱和度、B亮度）
extension UIColorExtensionViewController {
    
    // MARK: 5.1、返回HSBA模式颜色值
    @objc func test51() {
        
        let orange = UIColor.orange
        print("--- 橙色HSB值 ---", "色相:", orange.hsba.hue, "饱和度: \(orange.hsba.saturation)", "亮度: \(UIColor.orange.hsba.brightness)", "透明度: \( orange.hsba.alpha)")
        
        let color = UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 0.5)
         print("--- 自定义颜色HSB值 ---", "色相: \(color.hsba.hue)", "饱和度: \(color.hsba.saturation)", "亮度: \(color.hsba.brightness)", "透明度: \(color.hsba.alpha)")
    }
}

// MARK: - 四、UIColor 的一些属性
extension UIColorExtensionViewController {
    
    // MARK: 4.1、UIColor 转十六进制颜色的字符串
    @objc func test41() {
        // 纯蓝：#0000FF -> 0,0,255
        let alpha1: CGFloat = 0.48
        let color1 = UIColor(hexString: "#3CB371", alpha: alpha1)
        let hesString1 = color1?.hexString ?? "颜色有问题"
        let newAlpha1 = String(
            format: "%0.2f",hesString1.jx.sub(from: hesString1.count - 2).jx.hexadecimalToDecimal().jx.toCGFloat()! / CGFloat(255.999999))
        
        let alpha2: CGFloat = 0.44
        let color2 = UIColor(hexString: "#3CB371", alpha: alpha2)
        let hesString2 = color2?.hexString ?? "颜色有问题"
        let newAlpha2 = String(
            format: "%0.2f",hesString2.jx.sub(from: hesString2.count - 2).jx.hexadecimalToDecimal().jx.toCGFloat()! / CGFloat(255.999999))
        
        print("UIColor 转十六进制颜色的字符串", "原始颜色：纯蓝：#3CB371 -> 60,179,113 透明度：\(alpha1)", "color 转化为 十六进制字符串为：\(hesString1)", "最后的两位是：\(hesString1.jx.sub(from: hesString1.count - 2)) 透明度是：\(newAlpha1)", "", "color 转化为 十六进制字符串为：\(hesString2)", "最后的两位是：\(hesString2.jx.sub(from: hesString2.count - 2)) 透明度是：\(newAlpha2)")
    }
    
    // MARK: 4.2、随机色
    @objc func test42() {
        self.navigationController?.navigationBar.barTintColor = UIColor.randomColor
    }
}

// MARK: - 三、UIColor的一些方法
extension UIColorExtensionViewController {
    
    // MARK: 3.1、根据 十六进制字符串颜色 获取 RGB
    @objc func test31() {
        // 春天的绿色：60,179,113 -> #3CB371
        let rgb = UIColor.hexStringToColorRGB(hexString: "#3CB371")
        guard let r = rgb.r, let g = rgb.g, let b = rgb.b else {
            print("颜值值有问题")
            return
        }
        print("根据 十六进制颜色获取 RGB", "原始的十六进制颜色为：#3CB371", "原始的RGB为：60,179,113", "r = \(r)", "g = \(g)", "b = \(b)" )
    }
    
    // MARK: 3.2、根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113
    @objc func test32() {
        // 春天的绿色：60,179,113 -> #3CB371
        let rgb = UIColor.hexIntToColorRGB(hexInt: 0x3CB371)
        let r = rgb.r
        let g = rgb.g
        let b = rgb.b
        print("根据 十六进制值 颜色获取 RGB， 如：0x3CB371 -> 60,179,113", "原始的RGB为：60,179,113", "r = \(r)", "g = \(g)", "b = \(b)" )
    }
    
    // MARK: 3.3、color 转 RGBA
    @objc func test33() {
        // 热情的粉红：#FF69B4 -> 255,105,180
        guard let color = UIColor(hexString: "#FF69B4", alpha: 0.6) else {
            return
        }
        self.navigationController?.navigationBar.barTintColor = color
        let rgba = color.colorToRGBA()
        guard let r = rgba.r, let g = rgba.g, let b = rgba.b, let a = rgba.a else {
            return
        }
        print("1---color 转 RGBA", "原始颜色：热情的粉红：#FF69B4 -> 255,105,180 透明度 0.6", "color 转化为 RGBA为", "r = \(r)", "g = \(g)", "b = \(b)", "a = \(a)")
        
        // 春天的绿色：60,179,113 -> #3CB371
        let color2 = UIColor(r: 60, g: 179, b: 113, alpha: 0.5)
        let rgba2 = color2.colorToRGBA()
        guard let r2 = rgba2.r, let g2 = rgba2.g, let b2 = rgba2.b, let a2 = rgba2.a else {
            return
        }
        print("2---color 转 RGBA", "原始颜色：春天的绿色：60,179,113 -> #3CB371 透明度 0.5", "color 转化为 RGBA为", "r = \(r2)", "g = \(g2)", "b = \(b2)", "a = \(a2)")
    }
}

// MARK: - 二、使用方法设置颜色
extension UIColorExtensionViewController {
    
    // MARK: 2.1、根据 RGBA 设置颜色颜色
    @objc func test21() {
        // 春天的绿色：60,179,113 -> #3CB371
         self.navigationController?.navigationBar.barTintColor = UIColor.color(r: 60, g: 179, b: 113, alpha: 1)
    }
    
    // MARK: 2.2、十六进制字符串设置颜色(方法)
    @objc func test22() {
        // 橙色：255,165,0 -> #FFA500
        self.navigationController?.navigationBar.barTintColor = UIColor.hexStringColor(hexString: "#FFA500", alpha: 1.0)
    }
    
    // MARK: 2.3、十六进制 Int 颜色的使用(方法)
    @objc func test23() {
        // 适中的板岩暗蓝灰色：123,104,238 -> #7B68EE
        self.navigationController?.navigationBar.barTintColor = UIColor.hexIntColor(hexInt: 0x7B68EE, alpha: 1.0)
    }
}

// MARK: - 一、构造器设置颜色
extension UIColorExtensionViewController {
    
    // MARK: 1.1、根据 RGBA 设置颜色颜色
    @objc func test11() {
        // 春天的绿色：60,179,113 -> #3CB371
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 60, g: 179, b: 113, alpha: 1)
    }
    
    // MARK: 1.2、十六进制字符串设置颜色
    @objc func test12() {
        // 深橙色：255,140,0 -> #FF8C00
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#FF8C00", alpha: 1.0)
    }
    
    // MARK: 1.3、十六进制 Int 设置颜色
    @objc func test13() {
        // 淡珊瑚色：240,128,128 -> #F08080
        self.navigationController?.navigationBar.barTintColor = UIColor(hexInt: 0xF08080, alpha: 1.0)
    }
}
