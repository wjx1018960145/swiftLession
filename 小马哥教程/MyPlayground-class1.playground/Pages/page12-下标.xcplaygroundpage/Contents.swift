//: [上一页](@previous)

import Foundation


//:* 下标 （）使用subscript可以给任意类型（枚举，结构体，类）增加下标功能，有些地方翻译为：下标脚本
//： - subscript的语法类似于实例方法，计算属性，本质就是方法（函数）
// subscript 中定义的返回类型决定了 get方法的返回值类型 set方法中newValue的类型

//subscript 可以接受多个参数 并且类型任意

//: - subscript 可以没有set方法，但是必须要有get方法 有set方法必须要有get方法和计算属性很类似
//： - 可以设置参数标签




class Posint {
    var x = 0,y = 0
    
    subscript(index:Int)->Int {
        set {
            if index == 0 {
                x = newValue
            }else if(index == 1){
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            }else if index == 1{
                return y
            }
            return 0
        }
    }
}

var p = Posint()

p[0] = 11
p[1] = 22

print(p.x)
print(p[0])




//: [下一页](@next)
