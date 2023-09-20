//: [Previous](@previous)

import Foundation


//:*面向协议编程

//:* 利用协议实现前缀效果
//前缀类型
struct JX<Base>{
    var base:Base
    init(_ base:Base){
        self.base = base
    }
}
//利用协议扩展前缀属性
protocol JXCompatible{}
extension JXCompatible{
    var jx:JX<Self>{
        set{ }
        get{
            JX(self)
        }
    }
    static var jx:JX<Self>.Type{
    
        set{}
        get{
            JX<Self>.self
        }
    }
}
//给字符串扩展功能
extension String:JXCompatible{}
extension NSString:JXCompatible{}
// 给前缀扩展功能 jx
extension JX where Base :ExpressibleByStringLiteral {
    var numberCount:Int {
        var count = 0
        for c in (base as! String) where ("0"..."9").contains(c){
            count += 1
        }
        return count
    }
    static func test(){}
}
 
print("qwe232".jx.numberCount)
var str :NSString = "qwe222"
var str1:NSMutableString = "qwe222"
print(str.jx.numberCount)
print(str1.jx.numberCount)



// 利用协议实现类型判断

protocol ArrayType{}
extension Array : ArrayType{}
extension NSArray :ArrayType{}
func isArrayType(_ type:Any.Type)->Bool{
    type is ArrayType.Type
}

print(isArrayType([Int].self))
print(isArrayType([Any].self))
print(isArrayType([Double].self))
print(isArrayType(NSMutableArray.self))
print(isArrayType(NSArray.self))
 


// 响应式编程

//RxSwfit








//: [Next](@next)
