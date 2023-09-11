//: [上一页](@previous)

import Foundation
import Darwin


//：*错误处理
//：1开发过程常见错误
//:2 语法错误
//:3 逻辑错误
//:4 运行时错误（可能会导致闪退）

//:* 自定义错误
// swift可以通过Error协议自定义运行时的错误信息
enum SomeError:Error {
    case illegalArg(String)
    case outOfBound(Int,Int)
    case outOfMemory
}

//函数内部通过throw抛出自定义Error，可能会抛出Error的函数必须加上throws声明

func divide(_ num1:Int,_ num2:Int) throws -> Int {

    if num2 == 0{
        throw SomeError.illegalArg("0不能作为除数")
//        throw someError
    }
    return num1/num2

}
// 使用try 调用可能会抛出Error的函数

func test(){
    
    do{
        print("2")
        print(try divide(10,0))
        print("3")
    }catch let SomeError.illegalArg(msg) {
        print("参数异常",msg)
    }catch let SomeError.outOfBound(size,index) {
        print("下标越界","size=\(size)","index=\(index)")
    }catch  SomeError.outOfMemory {
        print("内存移除")
    }catch {
        print("其他错误")
    }
    print("4")
}

test()
// 处理Error
//:两种方式
//:1 通过do-catch捕捉Error
//:2 不捕捉 Error 在当前函数增加throws声明，Error将自动抛给上层函数
//: 如果顶层函数（main函数）依然没有捕捉Error 那么程序将终止

func test1(){
    do {
        print("2")
        print(try divide(10,2))
        
    }catch let error as SomeError {
        print(error)
    }catch {
        
    }
    print("4")
}

test1()

//:* try? try! 可以使用try？ 和try！调用可能会抛出Error的函数，这样就不用去处理Error

func test3(){
    print("1")
    var resu = try? divide(10, 0)
    print("2")
}

//test3()


// a b 是等价的

var a = try? divide(20, 0)

var b : Int?
do {
    b = try divide(20, 0)
}catch {
    b = nil
}


// rethrows 表明函数本身不会抛出错误，但是调用闭包参数抛出错误，那么它将错误向上抛


func exec(_ fn:(Int,Int) throws ->Int,_ num1:Int,_ num2:Int)  rethrows{
    print( try  fn(num1,num2))
    
}

//defer defer语句用来定义任何方式抛出错误离开代码块前必须执行的代码
//defer语句将延迟至当前作用域结束之前执行
func open(_ fileName:String)->Int{
    return 0
}
func close(_ file:Int){
    print("file close")
}

func processFile(_ fileName:String) throws {
    let file = open(fileName)
    defer {
        close(file)
    }
    try divide(10, 0)
}

try processFile("test.txt")
// defer 语句的执行顺序与定义顺序相反





//: [下一页](@next)
