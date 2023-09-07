//: [上一页](@previous)

import Foundation


//结构体 在swift标准库中 绝大部分的公开类型都是结构体 而枚举和类只占很小一部分
//比如bool int double string array dictionary 等常见类型都是结构体
//多有的结构体都有一个编译器自动生成的初始化器（初始化方法，构造器，构造方法）
//调用初始化方法 可以传入多有的成员值，用以初始化多有成员(存储属性)

//: * 结构体初始化器
//: .1 编译器会根据情况，可能为结构体生成多个初始化器，宗旨是保证所有成员都有初始化值

struct Point{
    var x:Int
    var y:Int
}

//var p1 = Point(x: 10, y: 10)
//var p2 = Point(y:10) 错误写法
//var p3 = Point(x:10)错误写法
//var p4 = Point()错误写法

struct Point1{
    var x:Int = 0
    var y:Int
}

//var p1 = Point1(x: 10, y: 10)
//var p2 = Point1(y:10)
//var p3 = Point1(x:10)错误写法
//var p4 = Point1()错误写法


struct Point2{
    var x:Int = 0
    var y:Int
}

//var p1 = Point2(x: 10, y: 10)
//var p2 = Point2(y:10)错误写法
////var p3 = Point2(x:10)
////var p4 = Point2()错误写法

struct Point3{
    var x:Int = 0
    var y:Int = 0
}

//var p1 = Point3(x: 10, y: 10)
//var p2 = Point3(y:10)
////var p3 = Point3(x:10)
////var p4 = Point3()

//当成员变量是可选项时 成员变量都有默认值的为 nil

struct test{
   var x:Int?
   var  y:Int?
}

//var t = test(x: 10, y: 10)
//var t1 = test(x:10)
//var t2 = test(y:10)
//var t3 = test()
//以上代码可以编译通过


//: * 自定义初始化器
//: ** 一旦在定义结构体时自定义初始化器，编译器就不会帮我们自动生成其他初始化器

struct test1{
    var x:Int = 0
    var y:Int = 0
    init(x:Int,y:Int) {
        self.x = x
        self.y = y
    }
}

var t1  = test1(x: 10, y: 10)
//var t2 = test1(y:10)错误写法
//var t3 = test1(x:10)错误写法
//var t4 = test1()错误写法

//: *** 初始化器本质

print(MemoryLayout<test1>.size)








//: [下一页](@next)
