//: [上一页](@previous)

import Foundation


//常量
// 只能赋值一次
//错误写法
/**
 let a = 10
 a = 20
 */
//正确写法
let agee = 10
let age2:Int
age2 = 20

//他的值不要求在编译时期确定，但使用之前必须赋值一次
func getAge()->Int{
    return 10
}

let age3 = getAge()

//常量变量在初始化之前，都不能使用
let age4 :Int
var height:Int
//错误使用
//print(age4)
//print(height)

//标识符 (比如常量名 变量名，函数名)几乎可以使用任何字符
// 标识符不能以数字开头，不能包含空白字符 制表符 箭头等特殊字符

//常见数据类型
/*
 1 值类型
 1.1 枚举类型 （enum） optional
 1.2 结构体类型(struct) bool int float double character Sring array dictionary set
 
 2 引用类型（reference type）
 2.1 类（class）
    
 整数类型 int8 int18 int32 int64 uint8 uint16 uint32 uint64
 在32bit平台 int 等价于int32 int等价于int64
 
 **/

//字面量
//bool
let bool = true //去反false
//字符串
let string = "wang"
//字符
let character:Character = "狗"
//整数
let intDecimal = 17 //十进制
let intBinary = 0b10001//二进制
let intOctal = 0o21//八进制
let intHexadecimal = 0x11//十六进制
//数组
let array = [1,2,3,4,]
//字典
let dictionary = ["age":18,"height":168,"weight":56];

//类型转化
let int1:UInt16 = 2_000
let int2:UInt8 = 1
let int3 = int1+UInt16(int2)

//元组
let http = (404,"not find")
print(http.0)
let (strtusCode,statusMsg) = http
let (justTheStatusCode,_) = http
let http2 = (status:200,des:"ok")














//: [下一页](@next)
