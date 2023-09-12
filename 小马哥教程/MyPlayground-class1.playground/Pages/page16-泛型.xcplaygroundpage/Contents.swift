//: [上一页](@previous)

import Foundation



//:* 泛型

var n1 = 10
var n2 = 20

func swapValue(_ a: inout Int , _ b:inout Int){
    (a,b) = (b,a)
}

swapValue(n1,n2)







//: [下一页](@next)
