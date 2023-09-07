//: [Previous](@previous)

import Foundation

//函数的定义
func pi()->Double{
    return 3.14
}
//形参默认是let 只能是let
//无返回值
func sayHell()->Void{
    print("Hello")
}

func sayHello()->(){
    print("Hello")
}
//隐式返回(implicit return)
//如果整个函数体是一个单一表达式，那么函数隐式返回这个表达式

//func sum(v1:Int,v2:Int)->Int{
//    v1+v2
//}
//
//sum(v1: 10, v2: 20)
//返回元组
func calculate(v1:Int,v2:Int)->(sum:Int,defference:Int,average:Int){
    let sum = v1+v2
    return (sum,v1-v2,sum>>1)
}
let result = calculate(v1: 109, v2: 20)
result.sum
result.defference
result.average

//函数文档注释
/// 求和
func sum1(v1:Int,v2:Int)->Int{
    v1+v2
}

sum1(v1: 19, v2: 10)
// 参数标签
//可以修改参数标签
func goWork(at time:String){
    print("time is \(time)")
}
goWork(at: "12:00")
//可以使用下划线_省略参数标签
func sum1(_ v1:Int)->Void{
    
}
//默认参数值
func check(name:String="nobody",age:Int,job:String="none"){
    print("name=\(name),age=\(age),job=\(job)")
}
 check(age: 12)
check(name: "jack", age: 12, job: "coder")
check(age: 12,job: "coder")
check(name:"jeck",age: 12)
//C++的默认参数值有个限制：必须从右往左设置，swift拥有参数标签，因此并没有此类限制
//但是在省略参数标签时，需要特别注意，避免出错
func test(_ first:Int=10,second:Int,_ last:Int = 20){}//如果中间参数也使用省略标签将会报错
test(second: 30)
//可变参数
func sums(_ numbers:Int...)->Int{
    var total = 0;
    for number in numbers{
        total+=number
    }
    return total
}
sums(19,34,34)
//一个函数最对只能有一个可变参数
//紧跟在可变参数后面的参数不能省略参数标签 容易导致传参无法对齐
func test1(_ numbers:Int...,string:String,_ other:String){}

//swift 自带的函数
print("1","2","3",separator: "/")//三个参数 第一个为省略便签可变参数 第二个是以什么形式分割，第三个是换行符
//输入输出函数 in-out parameter
//可以用inout 定义一个输入输出参数：可以在函数内部修改外部实参的值
//
var a = 10
func test2(_ num:inout Int){
    num = 20
}
test2(&a)
print(a)
//可变参数不能标记为inout
//inout参数不能有默认值
//inout参数本质是地址传递（引用传递）
//inout参数只能传入可以被多次赋值的 比如 49 这样的字面量不行 let 类型也不行、、


//函数重载
//函数名称相同 参数个数不同 参数类型不同 参数标签不同
func sum(v1:Int,v2:Int){}
func sum(v1:Int,v2:Int,v3:Int){}//个数不同
func sum(v1:Int,v2:Double){}//参数类型不同
func sum(v1:Double,v2:Int){}//参数类型不同
func sum(_ v1:Int,_ v2:Int){}//参数标签不同
func sum(a:Int,b:Int){}//参数标签不同

//函数重载注意点
//返回值类型与函数重载无关
func sex(v1:Int,v2:Int)->Int{v1+v2}
func sex(v1:Int,v2:Int){}
//调用时无法分清调用的哪一个
//默认参数值和函数重载一起使用产生二义性时，编译器不会报错
func sex(v1:Int,v2:Int,v3:Int=12){}

//可变参数，省略参数标签，函数重载一起使用产生二义性时，编译器有可能会报错
func sex(v1:Int...,v2:Int,v3:Int=12){}


//内联函数
//如果开启编译器优化 编译器会自动讲某些函数变成内联函数
//将函数调用展开成函数体
//哪些函数不会被内联 1 函数体比较长 2 含有递归调用 3 包含动态派发

//函数类型
//每一个函数都是有类型  函数类型有形参类型，返回值类型组成
func test2(){print("hanshu")}
var fn:()->() = test2

//函数类型作为函数参数
func age(v1:Int,v2:Int)->Int{
    v1+v2
}
func defference(v1:Int,v2:Int)->Int{
    v1-v2
}

func printResu(_ myFunc:(Int,Int)->Int,_ a:Int,_ b:Int){
    print("Resu :\(myFunc(a,b))")
}
printResu(age, 7, 9)
printResu(defference(v1:v2:), 4, 8)

//函数类型作为函数返回值
func next(_ input:Int)->Int{
    input+1
}
func previous(_ input:Int)->Int{
    input-1
}

func forward(_ f:Bool)->(Int)->Int{
    f ? next : previous
}

forward(true)(3)
forward(false)(3)
//返回值是函数类型的函数叫做高阶函数

//typealias
//typealias 用来给类型起别名

typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64

typealias Date = (year:Int,month:Int,dat:Int)

func testD(_ date:Date){
    print(date.year)
    print(date.month)
}
testD((2023,9,1))

typealias intFn = (Int ,Int) ->Int

func deff(v1:Int,v2:Int)->Int{
    v1-v2
}

let fc:intFn = deff

fc(23,34)

func setfc(_ fc:intFn){}
setfc(deff(v1:v2:))

func getfc()->intFn{
    deff(v1:v2:)
}

//嵌套函数 讲函数定义在函数内部
func forwards(_ f:Bool)->(Int)->Int{
    
    func next(_ input:Int)->Int{
        input+1
    }
    func previous(_ input:Int)->Int{
        input-1
    }
    return f ? next(_:) : previous(_:)
}
forward(true)(3)
forward(false)(3)
 
func xx(_ x:Int...,y:Int){
     
}

xx(2,3, y: 3)

//: [Next](@next)
