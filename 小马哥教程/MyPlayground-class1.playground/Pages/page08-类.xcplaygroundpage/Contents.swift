//: [上一页](@previous)

import Foundation

 
//: * 类 类的定义和结构体很类似，但编译器并没有为类自动生成可以传入成员值的初始化器

class Point {
    var x:Int = 0
    var y:Int = 0
}
let c1 = Point()
//let c2 = Point(x:10,y:10) 错误写法
//let c3 = Point(x:10)错误写法
//let c4 = Point(y:10)错误写法

//: * 类的初始化器
//: - 如果类的所有成员都在定义时指定了初始值，编译器会为类生成无参的初始化器
//: - 成员的初始化是在这个初始化器中完成的

//: *结构体和类的本质区别
// **结构体是值类型（枚举也是值类型），类是引用类型(指针类型)

//: * 值类型
//: - 值类型赋值给var let 或者给函数传值，是直接将内容拷贝一份 类似于文件copy paste操作 产生了全新的文件副本，属于深拷贝 （deep copy）
// 值类型赋值操作
var s1 = "jack"
var s2 = s1
s2.append("_rouse")
print(s1)
print(s2)

var a1 = [1,2,3]
var a2 = a1
a2.append(4)
a1[0] = 2
print(a1)
print(a2)

var d1 = ["max":10,"min":1]

var d2 = d1
d1["other"] = 7
d2["max"] =  12

print(d1)
print(d2)
// 在Swift 标准库中 为了提升性能 String array dictionary set 采取了copy on write的技术 比如尽当有写操作时，才会有真执行拷贝操作
// 对于标准库值类型的操作 swift 能确保最佳性能 所以没必要为了保证最佳性能来避免赋值
// 建议不需要修改的 尽量定义成let

//: * 引用类型
//: - 引用赋值给var let或者给函数传值，是将内存地址拷贝一份 类似于制作一个文件替身（快捷方式，连接）指向的是同一个文件，属于浅拷贝（shallow copy）

//: * 引用类型的赋值操作

class yy {
    var x:Int = 10
    var y:Int = 10
    init(x:Int,y:Int){
        self.x = x
        self.y = y
    }
}
var cc = yy(x: 10, y: 10)

cc  = yy(x: 12, y: 12)

//cc 的指针变量发生变化 栈空间的内存数据改变 内存地址没变   堆空间
//: * 值类型。引用类型的let
    
struct p {
    var x:Int
    var y:Int
    
}
class s {
    var h:Int
    var w:Int
    init(w:Int,h:Int){
        self.w = w
        self.h = h
        
    }
}

let p1 = p(x: 10, y: 10)
//p1 = p(x: 10, y: 23) 错误
//
//p1.x = 12 错误
//p1.y = 23 错误
// 一旦定义了值类型对象为let 不可再次对当前对象进行修改实例 包括里面的值

let cs1 = s(w: 23, h: 23)
//cs1 = s(w: 34, h: 34) //错误 引用类型的实例一旦定义为let  不可修改当前栈区的内存内容 但是不影响堆区内容的修改
cs1.w = 45
cs1.h = 45

let str = "jack"
//str.append("_Rose") 错误
let arr = [1,2,3]
//arr[0] = 11 错误
//arr.append(4) 错误




//



//: [下一页](@next)
