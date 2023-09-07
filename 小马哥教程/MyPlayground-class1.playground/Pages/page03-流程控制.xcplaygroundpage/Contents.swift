//: [Previous](@previous)

import Foundation
import CoreGraphics

/*
 if-else
 if后面的条件只能是bool类型 条件可以省略小括号 条件后面的大括号不能省略
 
 错误
  let age = 4
  if age {
  }
 //while
 **/

var num = 5
while num>0{
    print("num is\(num)")
    num-=1
}//打印5次

var num1 = -1;
repeat {
    print("num is \(num1)")
}while num1>0//打印1次
//repeat -while 相当于C语言中的do-while
//这里不用num--，因为在swift3开始去除了自增（++）。自减(--)

 //for

//闭区间运算符 a...b , a<=取值<=b
let nums = ["Anna","alex","Brian","Jack"]
for i in 0...3{
    print(nums[i])
}
let rang = 1...3
for i in rang{
    print(nums[i])
}
let a = 1
let b = 3
for i in a...b{
    print(nums[i])
}
for i in a...3{
    print(nums[i])
}
//i 默认是let 有时需要可以声明成var
for var i in 1...3{
    i += 5
    print(i)
}
for _ in 1...3{
    print("没有用到遍历的值可以用下划线代替")
}
//半开区间运算符 a..<b, a<=取值<b
for i in 1..<5{
    print(i)
}//打印1234

//for -区间运算符用在数组上
let names = ["wang","li","zhang","sun"]
for item in names[0...3] {
    print(item)
}//打印 wang li zhang sun
//单侧区间 让区间朝一个方向尽可能的远
for name in names[2...]{
    print(name)
}//zhang sun
for name in names[...2]{
    print(name)
}// wang li zhang
for name in names[..<2]{
    print(name)
}// wang li
let  rangs = ...5
rangs.contains(7) //false
rangs.contains(4) //true
rangs.contains(-3)//true

//区间类型
let rang1 :ClosedRange<Int> = 1...3
let rang2 :Range<Int> = 1..<3
let rang3 :PartialRangeThrough<Int> = ...5

//字符串 字符也能使用区间运算符 但默认不能用在for-in
let stringRang1 = "cc"..."ff"//closeRang<String>
stringRang1.contains("cd")//false
stringRang1.contains("dz")//true
stringRang1.contains("fg")//false

let stringRang2 = "a"..."f"
stringRang2.contains("d")//true
stringRang2.contains("h")//false
//带间隔的区间值
let hours = 11
let hoursInterval = 2
//tickMark的取值 从4开始累加2 不超过11

for tickMark in stride(from: 4, to: hours, by: hoursInterval){
    print(tickMark)
}//

//switch
var number = 1
switch number {
case 1:
    print("num is 1")
    break
case 2:
    print("num is 2")
    break
case 3:
    print("num is 3")
    break
default:
    print("num is other")
    break
}// case default 后面不能写大括号 {}
 var number1 = 1
switch number1 {
case 1:
    print("num is 1")
case 2:
    print("num is 2")
case 3:
    print("num is 3")
default:
    print("num is other")
}
//默认可以不写 break 并不会贯穿到后面的条件

//fallthrough
//使用fallthrough 可以实现贯穿效果
var number2 = 1
switch number2 {
case 1:
    print("num is 1")
    fallthrough//贯穿到case2
case 2:
    print("num is 2")
case 3:
    print("num is 3")
default:
    print("num is other")
    
}//
//switch 注意点
//switch 必须保证能处理多有情况
var number4 = 1
//switch number4 {
//case 1:
//    print("num is 1")
//case 2:
//    print("num is 2")
//
//} case default后面至少要有一条语句
//如果不想做任何事，加上break即可
switch number4 {
case 1:
    print("num is 1")
case 2:
    print("num is 2")
default:
    break
}
//如果能保证已处理所有情况，也可以不必使用default
enum Answer {case right,wrong}
let answer = Answer.right

switch answer {
case Answer.right:
    print("right")
case Answer.wrong:
    print("wrong")
    
}
//由于已确定answer是Ansewer类型，因此可以省略Answer
switch answer {
case .right:
    print("right")
case .wrong:
    print("wrong")
    
}

//复合条件
let str = "jack"
switch str {
case "jack":
    fallthrough
case "Rose":
    print("right peron")
default:
    break
}
switch str {
case "jack","Rose":
    print("right person")
default:
    break
}

var character:Character = "a"

switch character {
case "a","A":
    print("the letter A")
default:
    print("not the letter A")
//    break
}
//区间匹配 元组匹配
let count = 62

switch count {
case 0:
    print("none")
case 1..<5:
    print("a few")
case 5..<12:
    print("several")
case 12..<100:
    print("dozens")
case 100..<1000:
    print("hunderds of")
default:
    print("many")
     
}
let point = (1,1)
switch point {
case (0,0):
    print("the origin")
case (_,0)://忽略左侧值
    print("on the x-axis")
case (0,_)://忽略右侧值
    print("on the y-axis")
case (-2...2,-2...2):
    print("inside the box")
default:
    print("outside of the box")
}
//值绑定
let point1 = (2,0)
switch point1 {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0,let y):
    print("on the y-axis with an y value of \(y)")
case let(x,y):
    print("somewhere else at (\(x),\(y))")

}
//where
let point2 = (1,-1)

switch point2 {
case let(x,y) where x==y:
    print("on the line x==y")
case let (x,y) where x == -y:
    print("on the line x==-y")
case let (x,y):
    print("(\(x),\(y) is just some arbitrary poin")
}

var number5 = [10,-20,34,-23,87,23]

var sun = 0;
for num in number5 where num>0{
    sun+=num
}
print(sun)
//标签语句
outer:for i in 1...4{
    for k in 1...4{
        if k==3{
            continue outer
        }
        if i == 3{
            break outer
        }
        print("i == \(i), k==\(k)")
    }
}
//: [Next](@next)
