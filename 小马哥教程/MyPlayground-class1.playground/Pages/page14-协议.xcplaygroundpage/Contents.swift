//: [上一页](@previous)

import Foundation
import Darwin
import CoreGraphics

//协议（Protocol） 协议可以用来定义方法，属性，下标的声明，协议可以被枚举，结构体。类准守（多个协议之间逗号隔开）

protocol Drawable {
    func draw()
    var x:Int{get set}
    var y:Int{get}
    subscript(index:Int)->Int{get set}
}

// 协议中定义方法时不能有默认参考值
// 默认情况下，协议中定义的内容必须全部都实现
// 也有办法办到只实现部分内容，

//协议中的属性
//
class Person : Drawable {
    var x:Int = 0
    let y:Int = 0
    func draw(){
        print("Person draw")
    }
    subscript(index:Int)->Int{
        set{
            
        }
        get{
            0
        }
    }
}

class Person1 : Drawable {
    var x:Int {
        get {
            0
        }
        set{}
    }
    var y:Int{0}
    func draw(){
        print("Person draw")
    }
    subscript (index:Int)->Int{
        set{}
        get{index}
    }
    
}

// 协议中定义属性时必须用var关键字
// 实现协议时的属性权限要不小于协议中定义的属性权限
// 协议定义get set 用var存储属性或get set 计算属性去实现
// 协议定义get 用任何属性都可以实现


// static class
// 为了保证通用，协议中必须用static定义类型方法，类型属性，类型下标

protocol p1{
    static func f1()
    
}

class person2 : p1 {
    class func f1(){
        
    }
//    static func
}

// mutating
//只有将协议中的实例方法标记为mutating
// 才允许结构体。枚举的具体实现修改自身内存
//

protocol p2{
    mutating func f1()
}

class Size:p2{
    var width:Int=0
    func f1(){
        width = 10
    }
}
struct Point:p2{
    var x:Int=0
    mutating func f1(){
        x = 10
    }
}

// init

//协议中还可以定义初始化器init
// 非final类实现时必须加上required

protocol p3{
    init(x:Int,y:Int)
}
class c1:p3{
    required init(x:Int,y:Int){}
}
final class c2:p3{
    init(x:Int,y:Int){}
}
// 如果从协议实现的初始化器，刚好是重写了父类的指定初始化器，那么这个初始化器必须同时加上 required，override
protocol p4 {
    init(age:Int)
}
class c3{
    init(age:Int){}
}
class student : c3, p4{
    required override init(age:Int){
        super.init(age:age)
        
    }
}


// init init? init!

//协议中定义的 init? init! 可以用init init? init!去实现
//协议中定义的init 可以用init init!去实现

protocol Livable {
    init()
    init?(age:Int)
    init!(no:Int)
}

class c4 : Livable {

    required init(){}
//    required init!(){}
    
    required init?(age:Int){}
//    required init!(age:Int){}
//    required init(age:Int){}
    
    required init!(no:Int){}
//    required init?(no:Int){}
//    required init(no:Int){}
    
}

//协议的继承

//一个协议可以继承其他协议

protocol p5 {
    
    func run()
}
protocol p6:p5 {
    func breath()
}

class c5 :p6 {
    func run(){}
    func breath(){}
}

//: *协议组合
protocol p7 {}
protocol p8{}
class c6{}

//接收f1或者其子类的实例
func f1(obj:c6){}
//接收遵守p7协议的实例
func f2(obj:p7){}
// 接收同时遵守p7 p8协议的实例
func f3(obj:p7 & p8){}
//接收同时遵守p7 p8 协议 并且是c6或者其子类的实例
func f4(obj:c6 & p7 & p8){}
// 协议组合，可以包含一个类类型（最多一个）

typealias relP = c6 & p7 & p8
//接收同时遵守p7 p8 协议 并且是c6或者其子类的实例
func f5(obj:relP){}

//CaseIterable
// 让枚举遵守CaseIterable协议，可以实现遍历枚举值
enum Season:CaseIterable {
    case spring,summer,autumn,winter
}

let season = Season.allCases
print(season.count)

for season in season {

    print(season)
}

//CustomStringConvertible 遵守这个协议可以自定义实例的打印字符串

class c7 :CustomStringConvertible {

    var name:String
    init (name:String){
        self.name = name
    }
    
    var description:String {
        "name=\(name)"
    }
    
}

var c8 = c7(name:"jack")
print(c8)


// Any AnyObject
//swift提供了两种特殊类型 Any AnyObject
//any :可以代表任意类型（枚举，结构体，类，也包括函数类型）

//anyObject ：可以代表任意类类型（在协议后面写上：AnyObject代表只有类能遵守这个协议）
protocol Runable :AnyObject{
    
}

class c10:Runable{
    
}

//struct c11:Runable{} 错误写法

var str:Any = 10
str = "jack"
str = c10()


//创建一个能存放任意类型的数组

//var data= Array<Any()
var data = [Any]()

data.append(1)
data.append(3.14)
data.append(c10())
data.append("jack")
data.append({10})
data.append({
    
    ()->Int in
    return 10
    
})
print(data)
//data

//is as? as! as
// is 用来判断是否为某种类型，as 用来做强制类型转换

protocol p10{
    func run()
}
class c11 {
}
class c12 : c11 ,p10{
    func run() {
        
    }
    func student(){
        print("STudent")
    }
}
var stu:Any = 10

print(stu is Int)
stu = "jack"
print(stu is String)
stu = c12()
print(stu is c11)
print(stu is c12)
print(stu is p10)


(stu as! c12).student()
(stu as? c12)?.student()

var data1 = [Any]()
data1.append(Int("123") as Any)
print(data1.count)


// X.self X.type AnyClass
// X.self 是一个元类型（metadata）的指针，metadata存放这类型相关的信息
// X.self 属性X.Type
class x{}
var xx :x = x()

print(type(of: xx))

var xType:x.Type = x.self

var xxx:AnyObject = x()
var px :x.Type = x.self
var px2 :AnyObject.Type = x.self

// 元类型应用

class Animal{required init(){}}

class cat:Animal{}
class dog:Animal{}
class pig:Animal{}
func create(_ clss:[Animal.Type])->[Animal]{
    var arr = [Animal]()
    for cls in clss {
        arr.append(cls.init())
    }
    return arr
}
print(create([cat.self,dog.self,pig.self]))




class_getInstanceSize(x.self)


// Self 一般用作返回值类型，限定返回值跟方法调用者必须是同一类型（也可以作为参数类型）

protocol RunAble{
    func test()->Self
}

class c14 :RunAble {

    required init(){}
    func test() -> Self {
        type(of: self).init()
    }
}

class c140 :c14{
    
}
var c1401 = c14()
c1401.test()

var c1402 = c140()
c1402.test()

// 如果Self用在类中，要求返回时调用的初始化器是required的


//: [下一页](@next)
