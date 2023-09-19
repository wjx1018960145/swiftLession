//
//  main.swift
//  Class
//
//  Created by wjx on 2023/9/2.
//

import Foundation

//@objcMembers
@objc(JXCar)
 @objcMembers class Car:NSObject {
    var price:Double
     @objc(name)
    var band:String
   @objc init(price:Double,band:String){
        self.price = price
        self.band = band
    }
     @objc(drive)
    func run(){print("run")}
    static func run(){print("static run")}
}
extension Car{
    @objc(exec:v2:)
    func test(_ a:Double,_ b:String){print(price,band ,"test")}
}

testSwift()

//enum test {
//    case test1(Int,Int,Int)
//    case test2(Int,Int)
//    case test3(Int)
//    case test4(Bool)
//    case test5
//}
//
//var e = test.test1(1, 2, 3)
//e = test.test2(4, 5)
//e = test.test3(6)
//e = test.test4(true)
//e = test.test5
//
//print("asdasd")
//
//
//class test1 {
//
//}
//
//var a = test1()


var str2 = "0123456789ABCDEF"
print("1")
//0x100003F10 是0123456789ABCDEF的

 // 0x7fffffffffffffe0

var person = JXPerson()
print(person)

//sum(12, 12)

@_silgen_name("sum")
func swift_sum(_ v1:Int32,_ v2:Int32)->Int32
print(swift_sum(30, 20))




@objcMembers class Person:NSObject {
    func test1(v1:Int){print("test1")}
    func test2(v1:Int,v2:Int){print("test2")}
    func test2(_ v1:Double,_ v2:Double){print("test(_:_:)")}
    func run (){
        perform(#selector(test1(v1:)))
        perform(#selector(test1))
        perform(#selector(test2(v1:v2:)))
        perform(#selector(test2(_:_:)))
        perform(#selector(test2 as (Double,Double)->Void))
    }
}
