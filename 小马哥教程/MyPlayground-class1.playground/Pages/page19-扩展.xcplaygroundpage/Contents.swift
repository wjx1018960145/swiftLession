//: [上一页](@previous)

import Foundation
import CoreGraphics
import Darwin



// 协议 swift中的扩展，有点类似OC中的分类（category）
// 扩展可以为枚举，结构体，类，协议添加新的功能
// 可以添加方法，计算属性，下标，便捷初始化器，嵌套类型，协议等等

//: *协议不能办的事
//: 1 不能覆盖原有的功能，
//: 2 不能添加存储属性，不能向已有的属性添加属性观察器
//: 3 不能添加父类
//: 4 不能添加指定初始化器，不能添加反初始化器

extension Double {

    var km:Double{self*1000}
    var m:Double{self}
    var dm:Double{self/10.0}
    var cm:Double{self/100.0}
    var mm:Double{self/1_000.0}
}

var d = 100.0

d.km

d.m

var arr:Array<Int> = [10,20,19]


var aage = arr[1]

print(arr.startIndex)
print(arr.endIndex)

extension Array {
    subscript(nullable index:Int) ->Element? {
        if (startIndex..<endIndex).contains(index){
            return self[index]
        }
        return nil
    }
}


extension Int {
    func repeats(task:()->Void){
        for _ in 0..<self {
            task()
        }
    }
    mutating func square()->Int {
        self = self*self
        return self
    }
    enum Kind{case engative,zero,positive}
    var king :Kind {
        switch self{
        case 0:
            return .zero
        case let x where x>0:return .positive
        default :return .engative
        }
    }
    subscript (digitIndex:Int) -> Int {
        var decimalBase = 1
        for _ in  0..<digitIndex{
            decimalBase *= 10
        }
        return (self/decimalBase)%10
    }
}

//10.Kind


// 协议 初始化器

class Person{
    var age:Int
    var name:String
    init(age:Int,name:String){
        self.age = age
        self.name = name
    }
}

extension Person :Equatable {
    static func == (left:Person,right:Person)->Bool {
        left.age == right.age && left.name == right.name
    }
    convenience init(){
        self.init(age:0,name:"")
    }
}


struct Point {
    var x:Int = 10
    var y:Int = 10
    
}
extension Point {
    init(_ point:Point) {
        self.init(x:point.x,y:point.y)
    }
}
// 如果希望自定义初始化器的同时，编译器也能够生成默认初始化器
// 可以在扩展中编写自定义初始化器
// required 初始化器，也不能写在扩展中

// 协议
// 扩展可以提供默认实现，也间接实现【可选协议】的效果
// 扩展可以给协议扩充【协议中从未声明过的方法】

protocol TestProtocol {
    func test1()
}

extension TestProtocol {
    func test1(){
        
    }
    func test2(){
        print("test2")
    }
}


class testC:TestProtocol {
    
}

var c = TestC()

c.test2()




//: [下一页](@next)
