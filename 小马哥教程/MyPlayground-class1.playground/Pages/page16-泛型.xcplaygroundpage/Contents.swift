//: [上一页](@previous)

import Foundation



//:* 泛型 泛型可以将类型参数化，提高代码复用率，减少代码量，


var n1 = 10
var n2 = 20

func swapValue<T>(_ a: inout T , _ b:inout T){
    (a,b) = (b,a)
}



var dn =  swapValue(&n1,&n2)

var d1  = 10.0
var d2 = 20.0

swapValue(&d1, &d2)

// 泛型函数赋值给变量

func sum(){
    
}
var fn:(inout Int,inout Int)->() = swapValue

//var fn1:(inout Int,inout Double) ->() = swapValue

func test1<T, T1>(_ t1:T,_ t2:T1)->(){}

var ff:(Int,Double)->() = test1


// 泛型类型

class Stack<E>{
    var elements = [E]()
    init(_ element:E){
        elements.append(element)
    }
    func push(_ element :E){
        elements.append(element)
    }
    func pop() ->E {
        elements.removeLast()
    }
    func top()->E {
        elements.last!
    }
    func siz()->Int {
        elements.count
    }
}

var intStack = Stack(10)
var strStack = Stack("Str")
var arrStack = Stack([1,2,3])

// 泛型继承
class subStack<E> : Stack<E>{
    
}

// 结构体泛型】
struct SStack<E>{
    var elements = [E]()
    init(_ element:E){
        elements.append(element)
    }
  mutating  func push(_ element :E){ //修改结构体内存 所以加上mutating
        elements.append(element)
    }
  mutating  func pop() ->E {
        elements.removeLast()
    }
    func top()->E {
        elements.last!
    }
    func siz()->Int {
        elements.count
    }
}


//枚举泛型

enum Score<T>{
    case point(T)
    case grade(String)
}

let score = Score<Int>.point(100)
let score1 = Score.point(99)
let score2 = Score.point(99.4)
let score3 = Score<Int>.grade("A")// 加上<Int> 为了让枚举知道T的类型 否则不知道开辟多少内存









//: [下一页](@next)
