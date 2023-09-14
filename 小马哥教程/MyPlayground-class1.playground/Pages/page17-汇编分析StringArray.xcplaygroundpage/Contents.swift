//: [上一页](@previous)

import Foundation


//一个String变量占用多少内存
// 下面2个String变量，底层存储有什么不同

var str1 = "0123456789"
var str2 = "0123456789ABCDEF"

// 如果对String进行拼接操作，String变量的存储会发生什么变化？

str1.append("ABCDEF")
str1.append("G")
str2.append("G")






//: [下一页](@next)
