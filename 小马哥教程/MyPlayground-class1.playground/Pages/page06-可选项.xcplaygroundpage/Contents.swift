//: [Previous](@previous)

import Foundation


/**
 
 可选项 一般也叫可选类型，它允许将值设置为nil
    在类型名称后加个问号? 来定一个一个可选项
 */

var name:String? = "jack"
var age:Int?
age = 10
age = nil
name = nil

var array = [1,23,55,6]

func get (_ index:Int) ->Int?{
    if index < 0 || index >= array.count{
        return nil
    }
    return array[index]
}
print(get(1))
print(get(-1))


//强制解包 可选项是对其他类型的一层包装，可以将理解为一个盒子
//如果为nil 那么也是个空盒子
//如果要从可选项中取出被包装的数据(将盒子里装的东西取出来)，需要使用感叹号！进行强制解包

var age1:Int? = 10

var ageInt:Int = age1!
ageInt += 10

//如果对值为nil的可选项进行强制解包，将会产生运行时错误
var sex :Int?
//sex!

//判断可选项是否包含值

let number = Int("123")

if number != nil {
    print("字符串转换成功\(number!)")
}else{
    print("字符串转换失败")
}

//可选项绑定 （optional binding）
//可以使用可选项绑定来判断可选项是否包含值
//如果包含就自动解包，把值赋给一个临时的常量或者变量，并返回true，否则返回false
if let num = Int("123") {
    //num 作用域仅限于大括号
    print("字符串转换成功\(num)")
}else{
    print("字符串转换失败")
}
enum Season: Int{
    case spring = 1,summer,autumn,winter
}

if let s = Season(rawValue: 6) {
    switch s {
    case .spring:
        print("the season is spring")
    default:
        break
    }
}else{
    print("no such season")
}

//等价写法

if let first = Int("4") {
    
    if let second = Int("42"){
        if first < second && second < 100 {
            print("成功")
        }
    }
}
// 如果多个可选项绑定判断条件需要用逗号隔开
if let first = Int("4"),
    let second = Int("42"),
     first < second && second < 100 {
    print("成功")
}

//while 循环中使用可选项绑定

var arr = ["10","34","qw","-23","34"]

var index = 0;
var sum = 0;
while let num = Int(arr[index]), num > 0 {
    sum+=num
    index+=1
}
print(sum)

//空和并运算符 ？？
//a??b

 

/**
 a 是可选项
 b 是可选项或者不是可选项
 b跟a的存储类型必须相同
 如果a 不为nil 就返回a
 如果a为nil 就返回b
 如果b不是可选项，就返回a时自动解包
 

{
    let a:Int? = 1
    let b:Int? = 2
    let c = a ?? b //c是int？，optional（1）
}
{
    let a:Int? = nil
    let b:Int? = 2
    let c = a ?? b //c是int? optional（2）
}
{
    let a:Int? = nil
    let b:Int? = nil
    let c = a ?? b //c是int? nil
}

{
    let a:Int? = 1
    let b:Int = 2
    let c = a ?? b //c是int 1
}

 **/
//
//let a:Int? = nil
//let b:Int = 2
////let d:Int? = 3
//let c = a ?? b

//？与if let 配合使用

let a:Int? = nil
let b:Int? = nil
if let c = a ?? b {
    print(c)
}else{
    print("asd")
}

//guard 语句
//guard 条件 else{
//do
//    return break continue thow error
//}

// 当guard 语句的条件为false时 就会执行大括号里面的代码
// 当guard 语句的条件为true时，就会跳过guard语句
// guard语句特别适合用来提前退出
//当guard语句进行可选项绑定时，绑定的常量（let ）变量（var）也能在外层作用域中使用

func login (_ info:[String:String]){
    
    
    guard let username = info["username"] else {
        print("请输入用户名")
        return
    }
    
    guard let password = info["password"] else {
        print("请输入密码")
        return
    }
    
    print("用户名:\(username),密码:\(password)")
}
//隐式解包 在某些情况下 可选项一旦被设定值之后，就会一直拥有值
//在这种情况下 可以去掉检查，也不必每次访问的时候都进行解包，因为他能确定每次访问的时候都有值
//可以在类型后面加个感叹号！定义一个隐式解包的可选项

let p :Int! = 10
let q:Int = p

//字符串插值
var x:Int? = 19
print("age is \(x!)")
print("age is \(String(describing: x))")
print("age is \(x ?? 0)")


//多重可选项
var y:Int? = 10
var y1:Int?? = y
var y2:Int?? = 10
print(y == y2)









//: [Next](@next)
