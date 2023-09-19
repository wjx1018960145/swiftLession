//: [上一页](@previous)

import Foundation


// ios 程序的入口
// 在APPdelegate上面默认有个@UIApplicationMain标记 这表示
// 编译器自动生成入口代码（main函数代码）自动设置APppdelegate为APP的代理

// 也可以删掉@UIApplicationMain 自定义入口代码，新建一个main.swift文件

// swift调用OC
// 新建一个桥头文件 文件名称默认为 {taegetName}-Bridgeing-Header.h


// 如果 c语言暴露给swift的函数名称跟swift中的其他函数名称冲突了
// 可以在swift的使用@_silgen_name修改C函数名

// oc调用swift xcode已经默认生成一个OC调用swift的头文件，文件名称格式是 {targetName}-Swift.h

// OC调用swift-@objc
// 可以=通过@objc重命名swift暴露给OC的符号名（类名，属性名，函数名等）
@objc(JXCar)
 @objcMembers class Car:NSObject {
    var price:Double
     @objc(name)
    var band:String
   @objc init(price:Double,band:String){
        self.price = price
        self.band = band
    }
     @objc(drive)
    func run(){print("run")}
    static func run(){print("static run")}
}
extension Car{
    @objc(exec:v2:)
    func test(_ a:Double,_ b:String){print(price,band ,"test")}
}

//JXCar *car = [[JXCar alloc] initWithPrice:20 band:@""];
//car.name = @"qwe";
//[car drive];
//[car exec:29 v2:@"qwe"];
//[JXCar run];



//选择器
// swift 中依然可以使用选择器，使用#select(name)定义一个选择器
// 必须是被@objcMembers或者@objc修饰的方法才可以定义选择器
@objcMembers class Person:NSObject {
    func test1(v1:Int){print("test1")}
    func test2(v1:Int,v2:Int){print("test2")}
    func test2(_ v1:Double,_ v2:Double){print("test(_:_:)")}
    func run (){
        perform(#selector(test1(v1:)))
        perform(#selector(test1))
        perform(#selector(test2(v1:v2:)))
        perform(#selector(test2(_:_:)))
        perform(#selector(test2 as (Double,Double)->Void))
    }
}



// String swift的字符串类型是String 跟OC的NSString 在API设计上还是有较大的差异
//: String 插入与删除
var str = "1_2"
print(str.startIndex,str.endIndex)
print(str.insert("_", at: str.endIndex))
print(str)
str.insert(contentsOf: "3_4", at: str.endIndex)
print(str)
str.insert(contentsOf: "666", at: str.index(after: str.startIndex))
print(str)
str.insert(contentsOf: "888", at: str.index(before: str.endIndex))
print(str)
str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 4))
print(str)

str.remove(at: str.firstIndex(of: "1")!)
print(str)
str.removeAll{
    $0=="6"
}
print(str)
var range = str.index(str.endIndex,offsetBy: -4)..<str.index(before: str.endIndex)

str.removeSubrange(range)
print(str)

// substring 子串
//String可以通过下标，prefix suffix 等截取子串，子串类型不是String而是Substring

var str1 = "1_2_3_4_5"

var substr1 = str1.prefix(3)
print(substr1)
var substr2 = str1.suffix(3)
print(substr2)
var range1 = str1.startIndex..<str1.index(str1.startIndex, offsetBy: 3)
var substr3 = str1[range1]
print(substr3.base)

var str2 = String(substr3)
print(str2)
// Substring 和它的Base共享字符串数据
// Substring 转为String 会重新分配新的内存存储字符串数据


//String相关的协议
//BidirectionalCollection 协议包含的部分内容
//StartIndex endIndex属性 index 方法
//String Array 都遵守这个协议

// RangeReplaceableCollection 协议包含的部分内容
// append insert remove 方法
//String Array 都遵守这个协议
 
//Dictionary Set

// 多行字符串

// String 和NSString
// String与NSString 之间可以随时随地桥接转换
// 如果你觉得String 的API过于复杂难用，可以考虑将String转为NSString

var str4:String = "jack"
var str5:NSString = "Rose"

var str6 = str4 as NSString
var str7 = str5 as String

var str8 = str6.substring(with: NSRange(location: 0, length: 2))

print(str8)







//: [下一页](@next)
