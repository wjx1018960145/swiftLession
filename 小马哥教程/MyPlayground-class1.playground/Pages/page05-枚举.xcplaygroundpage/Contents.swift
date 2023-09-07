//: [Previous](@previous)

import Foundation


//枚举的基本用法

enum Direction{
    case north
    case south
    case east
    case west
}

var dir = Direction.west
dir = Direction.east
dir = .north
print(dir)

//关联值 将枚举的成员值跟其他类型的关联存储在一起，非常有用

enum Score{
case points(Int)
case grade(Character)
}
var score = Score.points(98)
score = .grade("A")

switch score {
    
case let .points(i):
    print(i,"points")
case let .grade(i):
    print("grade",i)
}

enum Date{
    case digit(year:Int,month:Int,day:Int)
    case string(String)
}

var date = Date.digit(year: 2023, month: 9, day: 1)
date = .string("2023-09-01")

switch date {
case .digit(let year,let month, let day):
    print(year,month,day)
case let .string(value):
    print(value)
}

//原始值 枚举成员可以使用相同类型的默认值预先关联，这个默认值叫做原始值

enum Poker : Character{
    case spade = "♠"
    case heart = "♥"
    case diamond = "♦"
    case club = "♣"
}
var suit = Poker.spade
print(suit)
print(suit.rawValue)
//隐式原始值 如果枚举的原始值类型是int String Swift会自动分配原始值

enum Directions :String {
    case north
    case south
    case east
    case west
}

//递归枚举
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr,ArithExpr)
    case diff(ArithExpr,ArithExpr)
}

let five = ArithExpr.number(5)
let four = ArithExpr.number(4)
let two = ArithExpr.number(2)
let sum = ArithExpr.sum(five, four)
let diff = ArithExpr.diff(sum, two)

func calculate(_ expr:ArithExpr)->Int{
    switch expr{
    case let .number(value):
        return value
    case let .sum(left, right):
        return calculate(left)+calculate(right)
    case let .diff(left , right):
        return calculate(left) - calculate(right)
    }
}
calculate(diff)

//MemmoryLayout 可以获取数据占用的内存大小

var  age = 10
//MemoryLayout<Int>.size 实际用到的空间大小
//MemoryLayout<Int>.stride 分配占用的空间大小
//MemoryLayout<Int>.alignment 对齐参数
MemoryLayout.size(ofValue: age)

enum Password{
    case number(Int,Int,Int,Int)
    case other
}
enum Season :Int{case spring = 1 ,summer = 2,autumn = 3,winter = 4}

MemoryLayout<Season>.size//1
MemoryLayout<Season>.stride//1
MemoryLayout<Season>.alignment//1
MemoryLayout<Password>.size//33
MemoryLayout<Password>.stride//40
MemoryLayout<Password>.alignment//8

//关联值需要存储在枚举内存中 关联值的值不固定 每次实例化都需要内存存储 原始值是固定不需要枚举内存存储和值没关系



/*
 枚举内存分布
 多个case情况
 如果有关联值 取一个字节存储成员值 N个字节存储关联值(N取占用内存最大的关联值) 任何一个case的关联值都公用这个N个字节
 
 如果只有原始值 那么多占用字节为一个字节
 
 原始只有一个case 实际占用内存为0 会分配一个字节
 
 **/



//: [Next](@next)
