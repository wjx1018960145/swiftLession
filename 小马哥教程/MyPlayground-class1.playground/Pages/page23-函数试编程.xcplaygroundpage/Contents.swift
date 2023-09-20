//: [上一页](@previous)

import Foundation


//:*函数式编程
// Array 常用操作
var arr = [1,2,3,4]

var arr1 = arr.map{$0*2}
print(arr1)
var arr2 = arr.filter { i in // 可以简化 $0 % 2 == 0
    return i % 2 == 0
}
print(arr2)
var arr3 = arr.reduce(0) { result, elements in
    return result+elements
}
print(arr3)

//lazy的优化
let result = arr.lazy.map { (i :Int)->Int in
    print(i)
    return i*2
}

print("mapped",result[2])


// optional的map 和flatMap
var num1:Int? = 10
var num2 = num1.map{$0*2}
var num3 = num1.flatMap{ $0*2}
//print(num3?)

var items = [1,2]

var index = items.firstIndex{
    $0 == 20
}

//print(index)

struct Person{
    var name: String
    var age:  Int
    init?(_ json:[String:Any]){
        guard let name = json["name"]as? String,
              let age = json["age"] as? Int else{
                  return nil
              }
        self.name = name
        self.age = age
    }
}


//var nameItems = [Person(name:"",age:23)]
//
//func getPerson1(_ name:String)->Person?{
//    let index = nameItems.firstIndex{$0.name == name}
//    return index != nil ? nameItems[index!] : nil
//}
//
//func getPerson2(_ name:String) -> Person? {
//    return nameItems.firstIndex{$0.name == name}.map{nameItems[$0]}
//
//}


var json :Dictionary? = ["name":"jack","age":23]

//old
var p1 = json != nil ? Person(json!) :  nil

var p2 = json.flatMap(Person.init)



// 函数式编程 简称FP 是一种编程规范，也就是如何编写程序的方法论
// 主要思想 把计算机过程尽量分解成一些列可复用的函数的调用
// 主要特征 函数时第一等公民
var num = 1
func add(_ v:Int)->(Int)->Int{{$0+v}}
func sub(_ v:Int)->(Int)->Int{{$0-v}}
func multiple(_ v:Int)->(Int)->Int{{$0*v}}
func divide(_ v:Int)->(Int)->Int{{$0/v}}
func mod(_ v:Int)->(Int)->Int{{$0%v}}

infix operator >>> : AdditionPrecedence
func >>> <A,B, C> (_ f1:@escaping (A)->B,_ f2:@escaping (B)->C)->(A)->C{{f2(f1($0))}}

var fn = add(3)>>>multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
print(fn(num))


// 高阶函数











//: [下一页](@next)
