//: [上一页](@previous)

import Foundation
import Security


//溢出运算符

// swift 的算数运算出现溢出时会抛出运算时错误
// swift 有溢出运算符（&+ &- &*） 用来支持溢出运算

print(Int8.min)
print(Int8.max)
print(UInt8.min)
print(UInt8.max)

var v1 = UInt8.min
var v2 = v1 &- 1
var v3 = UInt8.max &+ 10
print(v2)
print(v3)







//: [下一页](@next)
