//
//  StringExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/11.
//

import UIKit

class StringExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、字符串基本的扩展", "二、沙盒路径的获取", "三、iOS CharacterSet（字符集）", "四、字符串的转换", "五、字符串UI的处理", "六、字符串有关数字方面的扩展", "七、苹果针对浮点类型计算精度问题提供出来的计算类", "八、字符串包含表情的处理", "九、字符串的一些正则校验", "十、字符串截取的操作", "十一、字符串编码的处理", "十二、进制之间的转换", "十三、String -> NSMutableAttributedString", "十四、MD5 加密 和 Base64 编解码", "十五、AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密", "十六、SHA1, SHA224, SHA256, SHA384, SHA512", "十七、unicode编码和解码", "字符值引用 (numeric character reference, NCR)与普通字符串的转换"]
        
        dataArray = [["字符串的长度", "判断是否包含某个子串", "判断是否包含某个子串 -- 忽略大小写", "字符串转 base64", "base64转字符串转", "将16进制字符串转为Int", "判断是不是九宫格键盘", "字符串转 UIViewController", "字符串转 AnyClass", "字符串转数组", "JSON 字符串 -> Dictionary", "JSON 字符串 -> Array", "转成拼音", "提取首字母：爱国->AG", "字符串根据某个字符进行分隔成数组", "设备的UUID", "复制", "提取出字符串中所有的URL链接", "String或者String HTML标签转富文本设置", "计算字符个数（英文 = 1，数字 = 1，汉语 = 2）"], ["获取Home的完整路径名", "获取Documnets的完整路径名", "获取Library的完整路径名", "获取/Library/Cache的完整路径名", "获取Library/Preferences的完整路径名", "获取Tmp的完整路径名"],["去除字符串前后的 空格", "去除字符串前后的 换行", "去除字符串前后的 换行和换行", "去掉所有 空格", "去掉所有 换行", "去掉所有空格 和 换行", "是否是 0-9的数字，也不包含小数点", "url进行编码", "url进行解码", "某个字符使用某个字符替换掉", "使用正则表达式替换某些子串", "删除指定的字符"], ["字符串 转 CGFloat", "字符串转bool", "字符串转 Int", "字符串转 Double", "字符串转 Float", "字符串转 Bool", "字符串转 NSString", "字符串转 Int64", "字符串转 NSNumber"], ["对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)", "对字符串(多行)指定字体及Size，获取 (高度)", "对字符串(多行)指定字体及Size，获取 (宽度)", "对字符串(单行)指定字体，获取 (Size)", "对字符串(单行)指定字体，获取 (width)", "对字符串(单行)指定字体，获取 (Height)", "字符串通过 label 根据高度&字体—>Size", "字符串通过 label 根据高度&字体—>Width", "字符串通过 label 根据宽度&字体—>height", "字符串根据宽度 & 字体&行间距->Size", "字符串根据宽度 & 字体 & 行间距->width", "字符串根据宽度&字体&行间距->height"], ["将金额字符串转化为带逗号的金额 按照千分位划分，如 1234567 => 1,234,567", "字符串差不多精确转换成Double——之所以差不多，是因为有精度损失", "去掉小数点后多余的 0", "将数字的字符串处理成  几位 位小数的情况"], ["+", "-", "*", "/"], ["检查字符串是否包含 Emoji 表情", "去除字符串中的Emoji表情"], ["判断是否全是空白,包括空白字符和换行符号，长度为0返回true", "判断是否全十进制数字，长度为0返回false", "判断是否是整数", "判断是否是Float,此处Float是包含Int的，即Int是特殊的Float", "判断是否全是字母，长度为0返回false", "判断是否是中文, 这里的中文不包括数字及标点符号", "是否是有效昵称，即允许“中文”、“英文”、“数字”", "判断是否是有效的手机号码", "判断是否是有效的电子邮件地址", "判断是否有效的身份证号码，不是太严格", "严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码", "校验字符串位置是否合理，并返回String.Index", "隐藏手机号中间的几位", "检查字符串是否有特定前缀", "检查字符串是否有特定后缀", "是否为0-9之间的数字(字符串的组成是：0-9之间的数字)", "是否为数字或者小数点(字符串的组成是：0-9之间的数字或者小数点即可)", "验证URL格式是否正确", "是否是一个有效的文件URL", "富文本匹配(某些关键词高亮)"], ["截取字符串从开始到 index", "截取字符串从index到结束", "获取指定位置和长度的字符串", "切割字符串(区间范围 前闭后开)", "子字符串第一次出现的位置", "子字符串最后一次出现的位置", "获取某个位置的字符串", "获取某个子串在父串中的范围->Range", "获取某个子串在父串中的范围->NSRange", "在任意位置插入字符串"], [""], ["二进制 -> 八进制", "二进制 -> 十进制", "二进制 -> 十六进制", "八进制 -> 二进制", "八进制 -> 十进制", "八进制 -> 十六进制", "十进制 -> 二进制", "十进制 -> 八进制", "十进制 -> 十六进制", "十六进制 -> 二进制", "十六进制 -> 八进制", "十六进制 -> 十进制"], ["String 添加颜色后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 font 后转 NSMutableAttributedString", "String 添加 text 后转 NSMutableAttributedString", "String 添加 删除线 后转 NSMutableAttributedString"], ["MD5加密 默认是32位小写加密", "Base64 编解码"], ["字符串 AES, AES128, DES, DES3, CAST, RC2, RC4, Blowfish 多种加密"], ["SHA1, SHA224, SHA256, SHA384, SHA512 加密"], ["unicode编码", "unicode解码"], ["将普通字符串转为字符值引用", "字符值引用转普通字符串"]]
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

extension StringExtensionViewController {
    // MARK: 18.2、字符值引用转普通字符串
    @objc func test182() {
        let str = "潘美丽，最美丽"
        let newString = str.jx.toHtmlEncodedString()
        guard let newString2 = newString.jx.htmlEncodedStringToString() else {
            return
        }
        
        print("字符值引用转普通字符串", "原始字符串：\(str) 转为字符值引用：\(newString)", "字符值引用：\(newString) 转为普通字符串为：\(newString2)")
    }
    
}
