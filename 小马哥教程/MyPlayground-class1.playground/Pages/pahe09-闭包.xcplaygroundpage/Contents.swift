//: [上一页](@previous)

import Foundation


//: * 闭包表达式 在swift中可以使用func定一个函数 也可以通过闭包表达式定义一个函数

func sun(_ v1:Int,_ v2:Int)->Int{
    return 0
}

var fc = {
    (v1:Int,y:Int)->Int in
        return v1+y
    }

/**
 {
 
 (参数列表) -> 返回值类型 in
  函数体代码
    
 }
  
 **/


//: 闭包表达式简写
func exec (v1:Int,v2:Int,fn:(Int,Int)->Int){
    print(v1+v2)
}

exec(v1: 1, v2: 1, fn: {
    (v3:Int, v4:Int) ->Int in
    return v3 + v4
})

exec(v1: 10, v2: 10, fn: {
    v3,v4 in return v3 + v4
})

exec(v1: 10, v2: 10, fn: {$0+$1})

exec(v1: 10, v2: 10) {
    v1,v2 in return v1+v2
}

//: *尾随闭包 如果我们将一个很长的闭包表达式作为函数的最后一个实参，使用尾随闭包可以增强函数的可读性
// 尾随闭包是一个被书写在函数调用括号外卖的闭包表达式
// 如果闭包表达式是函数的唯一实参，而且使用尾随闭包语法，那就不需要在函数名后面写圆括号

func test(v1:Int,v2:Int,fn:(Int,Int)->Int){
    
}

test(v1: 10, v2: 10) { _,_ in
    return 0
}
func test1(fn:(Int,Int)->Int){}

test1(fn: {$0+$1})
test1(){$0+$1}
test1{$0+$1}
 
//: *数组的排序




func testArr(){
    var arr = [10,34,1,4]
    arr.sort()
//    arr.sorted(by: <#T##(Int, Int) throws -> Bool#>)
}

testArr()

//func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool)

// 返回true i1排在i2前面
// 返回false i1排在i2后面
func cmp(i1:Int,i2:Int) ->Bool {
    return i1>i2
}

var num = [11,2,18,6,5,68,45]

num.sorted(by: cmp(i1:i2:))
//[11, 2, 18, 6, 5, 68, 45]

num.sorted(by: {i1,i2 in return i1<i2})
num.sorted(by: {i1,i2 in i1<i2})
num.sorted(by: {$0<$1})
num.sorted(by: <)
num.sort(){$0<$1}
num.sort{ $0<$1}

//: * 闭包 一个函数和它捕获的变量/常量环境组合起来，称为闭包

//: - 一般指定义在函数内部的函数
//: - 一般它捕获的是外层函数的局部变量、常量


typealias ddd = (Int)->Int



typealias  fd = (Int)->Int

func fn ()->fd{
    var num = 0
    func f(i:Int)->Int{
        num+=i
        return num
    }
    return f
}

var ff = fn()
print(ff(1))
print(ff(2))
print(ff(3))
print(ff(4))

//: * 可以把闭包想象成是一个类的实例对象
//" - 内存在堆空间 捕获的局部变量常量就是对象成员变量（存储属性）
//: - 组成闭包的函数是类内部定义的方法

//: * 注意点 如果返回值是函数类型 那么参数的修饰要保持一致

//:* 自动闭包

func getfirstPositive(_ v1:Int,_ v2 :Int)->Int{
    return v1  > 0 ? v1 : v2
}

//getfirstPositive(10, 20)//20
//getfirstPositive(-2, 20)//20
//getfirstPositive(0, -4)//-4

//改成函数类型的参数，可以让v2延迟加载

func getfirstPostive(_ v1:Int,_ v2:()->Int) ->Int?{
    return v1>0 ? v1 : v2()
}
getfirstPostive(-4){20}//

func getfirstPositive(_ v1:Int,_ v2: @autoclosure ()->Int)->Int?{
    return  v1 > 0 ? v1 : v2()
}

//getfirstPositive(-4, 20)

// @autoclosure 会自动将20 封装成闭包{20}
// @autoclosure 只支持()->T 格式参数
// @autoclosure 并非只支持最后一个参数
// 空合并运算符？？使用了 @autoclosure 技术
// 有 @autoclosure 无 @autoclosure 构成了函数重载

//:* 为了避免与期望冲突，使用了 @autoclosure 的地方最好明确注释清楚：这个值会被延迟执行







//: [下一页](@next)
