//: [上一页](@previous)

import Foundation


//常量
// 只能赋值一次
//错误写法
/**
 let a = 10
 a = 20
 */
//正确写法
let agee = 10
let age2:Int
age2 = 20

//他的值不要求在编译时期确定，但使用之前必须赋值一次
func getAge()->Int{
    return 10
}

let age3 = getAge()

//常量变量在初始化之前，都不能使用
let age4 :Int
var height:Int
//错误使用
//print(age4)
//print(height)

//标识符 (比如常量名 变量名，函数名)几乎可以使用任何字符
// 标识符不能以数字开头，不能包含空白字符 制表符 箭头等特殊字符

//常见数据类型
/*
 1 值类型
 1.1 枚举类型 （enum） optional
 1.2 结构体类型(struct) bool int float double character Sring array dictionary set
 
 2 引用类型（reference type）
 2.1 类（class）
    
 整数类型 int8 int18 int32 int64 uint8 uint16 uint32 uint64
 在32bit平台 int 等价于int32 int等价于int64
 
 **/

//字面量
//bool
let bool = true //去反false
//字符串
let string = "wang"
//字符
let character:Character = "狗"
//整数
let intDecimal = 17 //十进制
let intBinary = 0b10001//二进制
let intOctal = 0o21//八进制
let intHexadecimal = 0x11//十六进制
//数组
let array = [1,2,3,4,]
//字典
let dictionary = ["age":18,"height":168,"weight":56];

//类型转化
let int1:UInt16 = 2_000
let int2:UInt8 = 1
let int3 = int1+UInt16(int2)

//元组
let http = (404,"not find")
print(http.0)
let (strtusCode,statusMsg) = http
let (justTheStatusCode,_) = http
let http2 = (status:200,des:"ok")


//关联类型 给协议中用到的类型定义一个占位名称
//协议有多个关联类型
protocol Stackable{
    associatedtype Element//关联类型
//    associatedtype Element2//关联类型
    mutating func push(_ element:Element)
    mutating func pop()->Element
    func top()->Element
    func size()->Int
}


class StringStack :Stackable {
   
    
    
    typealias Element = String
    
//    typealias Element2 = <#type#>
    
    var elements = [String]()
    func push(_ element: String) {
        elements.append(element)
    }
    func pop() -> String {
        elements.removeLast()
    }
    func top() -> String {
        elements.last!
    }
    func size() -> Int {
        elements.count
    }
}

var ss = StringStack()
ss.push("jack")
ss.push("rose")


class ClassStack<E> :Stackable {
    
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E {
        elements.removeLast()
    }
    func top() -> E {
        elements.last!
    }
    func size() -> Int {
        elements.count
    }
}


// 类型约束

protocol Stackables{
    associatedtype Element :Equatable
}

class CCStack<E:Equatable>:Stackables {
    typealias Element = E
    

    
    
}

func equal<S1:Stackables,S2:Stackables>(_ s1:S1,_ s2:S2)->Bool
    where S1.Element == S2.Element, S1.Element:Hashable {
    return false
    
}

var s1 = CCStack<Int>()
var s2 = CCStack<Int>()
var s3 = CCStack<String>()



equal(s1, s2)

// 协议类型注意点

//protocol Runable{
//
//}
//class Person:Runable {}
//class Car:Runable{}
//
//
//func get(_ type:Int)->Runable {
//    if type == 0{
//        return Person()
//    }
//    return Car()
//}
//
//
//var r1 = get(0)
//var r2 = get(2)

// 如果协议中有关联类型 associatedtype

protocol Runable{
    associatedtype Speed
    var speed:Speed{get}
}
class Person:Runable {
    var speed: Double {0.0}
}
class Car:Runable{
    var speed: Int{0}
}


func get<T:Runable>(_ type:Int)->T {
    if type == 0{
        return Person() as! T
    }
    return Car() as!T
}


var r1:Person = get(0)
var r2:Car = get(2)


// 不透明类型  使用some关键字声明一个不透明类型 只能返回一种类型
// some除了用在返回值类型上，一般还可以用在属性上
func get1(_ type:Int) -> some Runable{
    Car()
}


protocol A{associatedtype eat}

class Dog:A {typealias eat = Double}
class Cat{
    var sleep:some A{
    return Dog()
    }
}






//: [下一页](@next)
