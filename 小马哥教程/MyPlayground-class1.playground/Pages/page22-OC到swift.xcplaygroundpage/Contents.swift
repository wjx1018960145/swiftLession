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


// OC桥接swift转换表
/*
 String     <--> NSString
 String     <--  NSMutableString
 Array      <--> NSArray
 Array      <--  NSMutableArray
 Dictionary <--> NSDictionary
 Set        <--> NSSet
 Set        <--  NSMutableSet
 
 
 
 **/

//只能被class继承的协议
protocol ble:AnyObject{}
protocol Runable1:class{}
@objc protocol Runable2{}

//可选协议
// 可以通过@objc 定义可选协议，这种协议只能被class遵守
@objc protocol Runable{
    func fn1()
    @objc optional func fn2()
    func fn3()
}

class Dog:Runable {
    func fn1() {
        
    }
    
    func fn3() {
        
    }
}

// dynamic 被@objc dynamic 修饰的内容具有动态性，比如调用方法会走runtime那一套流程

class Dog1:NSObject {
    @objc dynamic func fn1(){}
    func test1(){}
}


//kvc kvo
//swift 支持kvc kvo的条件
// 属性所在的类，监听器最终继承自NSObject
// 用@objc dynamic 修饰对应属性

class Observer :NSObject {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observerValue",change?[.newKey] as Any)
    }
}

class Cat :NSObject {
    @objc dynamic var age = 0
    var observer:Observer = Observer()
    override init() {
        super.init()
        self.addObserver(observer, forKeyPath: "age", options: .new, context: nil)
    }
    deinit {
        self.removeObserver(observer, forKeyPath: "age")
    }
}

var c = Cat()
c.age = 20
c.setValue(25, forKey: "age")


//block 方式的kvo
class Cat1: NSObject {
    @objc dynamic var age:Int = 0
    var observer:NSKeyValueObservation?
    override init() {
        super.init()
         
        observer = observe(\Cat1.age,options:.new){//
            (cat ,chang) in
            print(chang.newValue as Any)
        }
    }
}

var c1 = Cat1()
c1.age = 20
c1.setValue(34, forKey: "age")


// 关联对象
// 在swift 中class依然可以使用关联对象
// 默认情况下 extension 不可以增加存储属性
// 借助关联对象，可以实现类似extension为增加存储属性的效果

class Person3 {}
extension Person3 {
    private static var AGE_KEY :Void?
    var age :Int {
        get{
            (objc_getAssociatedObject(self, &Self.AGE_KEY)as?Int) ?? 0
        }
        set{
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

var pp = Person3()
pp.age = 10
print(pp.age)



// 资源名管理
//  R.Swift库 仿安卓开发


// 多线程开发-一、异步

public typealias Task = () -> Void

class Async {
    
    public static func async(_ task:@escaping Task){
        _async(task)
    }

    public static func async(_ task:@escaping Task,_ mainTask:@escaping Task){
        _async(task, mainTask)
    }


    private static func _async(_ task:@escaping Task,_ mainTask:Task?=nil){
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async {
            if let main = mainTask {
                item.notify(queue: DispatchQueue.main, execute: main)
            }
        }
    }
    
    
    // 多线程开发--延迟
    
    @discardableResult //返回值可以忽略
    public static func delay(_ seconds:Double,_ block:@escaping Task)->DispatchWorkItem{
        let item = DispatchWorkItem(block: block)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+seconds, execute: item)
        return item
    }
    
    @discardableResult
    public static func asyncDelay(_ seconds:Double,_ task:@escaping Task)->DispatchWorkItem{
        return _asyncDelay(seconds, task)
    }
    public static func asyncDelay(_ second:Double,_ task:@escaping Task,_ mainTask:@escaping Task)->DispatchWorkItem{
        return _asyncDelay(second, task, mainTask)
    }
    
    
    
    private static func _asyncDelay(_ second:Double,_ task:@escaping Task,_ mainTask:Task?=nil)->DispatchWorkItem{
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+second, execute: item)
        return item
    }
    
    
}

//Async.async {
//    print(1)
//}

//Async.async {
//    print("1")
//} _: {
//    print("2")
//}


private var item : DispatchWorkItem? = nil

  item =  Async.asyncDelay(3) {
    print(1)
} _: {
    print(2)
}
item?.cancel()


// swift中dispatch_onec被废除 取而代之的是
//
fileprivate var initTask:Void = {
    print("init ----")
}()


let _ = initTask
let _ = initTask



// 多线开发-加锁

public struct Cache{
    private static var data = [String:Any]()
    
    private static var lock = DispatchSemaphore(value: 1)
//    private static var lock  = NSLock
//    private static var lock = NSRecursiveLock //递归锁
    public static func get(_ key:String)->Any?{
        return data[key]
    }
    public static func set(_ key:String,_ value:Any){
        
        
        lock.wait()
//        lock.lock()
        defer {//无论如何都要解锁
            lock.signal()
//            lock.unlock
        }
        
        data[key] = value
        
    }
}







//: [下一页](@next)
