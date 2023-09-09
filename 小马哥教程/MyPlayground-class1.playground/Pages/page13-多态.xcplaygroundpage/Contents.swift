//: [上一页](@previous)

import Foundation
import CoreGraphics
import Darwin




//初始化器 类，结构体，枚举都可以定义初始化器
// 类有两种初始化器，指定初始化器，便捷初始化器
// 每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
// 默认初始化器总是类的指定初始化器
// 类偏向于少量指定初始化器，一个类通常只有一个指定初始化器

//初始化器的相互调用规则
//: -指定初始化器必须从它的直系父类调用指定的初始化器
//: - 便捷初始化器必须从相同的类里调用另一个初始化器
//: - 便捷初始化器最终必须调用一个指定初始化器


// 初始化器的相互调用


/*
 
 designated <-Convenicence<-Convenience
    ^
    |


 **/

//两段式初始化

// swift 哎编码安全方面是煞费苦心 为了保证初始化过程安全，设定了两段式初始化，安全检查

// 两段式初始化
// 第一阶段 初始化多所有的存储属性
//1 外层调用指定便捷初始化器
//2 分配内存给实例，但未初始化
//3 指定初始化器确保当前类定义的存储属性都初始化
//4 指定初始化器调用父类的初始化器，不断向上调用，形成初始化器链

// 第二阶段 设置新的存储属性
//1 从顶部初始化器往下，链中的每一个指定初始化器都有机会进一步定制实例
//2 初始化器现在能够使用self（访问，修改的属性，调用它的实例方法等等）
//3 最终，链中任何便捷初始化器都有机会定制实例以及self


//安全检查
// 指定初始化器必须保证在调用父类初始化器之前，其所再类定义的所有存储属性都要初始化完成
// 指定初始化器必须先调用父类初始化器，然后才能为继承的属性设置新值
// 便捷初始化器必须先调用同类中的其他初始化器，然后再为任意属性设置新值
// 初始化器在第一阶段初始化完成之前，不能调用人格实例，不能读取任何实例属性的值，也不能引用self
// 直到第一阶段结束，实例才能算完全合法



class Person {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    init(age: Int) {
        self.age = age
        self.name = "Jack"
    }
}

class Student: Person {

}

var s1 = Student(age: 10)
var s2 = Student(age: 10, name: "Rose")


// 重写
// 当重写父类的指定初始化器时，必须加上override （即使子类的实现是便捷初始化器）
// 如果子类写了一个匹配父类便捷初始化器的初始化器，不用加override
//因为父类的便捷初始化器永远不会通过子类直接调用，因此 严格的说子类无法重写父类的便捷初始化器

//: *自动继承
//:- 1如果子类没有定义任何指定初始化器，它会自动继承父类所有的指定初始化器
//:- 2如果子类提供了父类所有指定初始化器的实现（要么通过方式1继承，要么重写）
//:   1 子类自动继承所有的父类便捷初始化器
//: 3 就算子类添加了更多的便捷初始化器，这些规则仍然适用
//: 4 子类便捷初始化器的形式重写父类的指定初始化器，也可以作为满足规则2的一部分


//: * Required
//: - 用required修饰指定初始化器，表明其所有的子类都必须实现该初始化器（通过继承或者重写实现）
//: - 如果子类重写看了required初始化器，也必须加上required 不用加override

class Persons{
    required init(){
        
    }
    
}

class Students:Persons{
    required init(){
        super.init()
    }
}

//:*属性观察器
//: - 父类的属性在它自己的初始化器中赋值不会触发属性观察器，但在子类的初始化器中赋值会触发属性观察器
class P1{
    var age:Int{
        willSet{
            print("willSet")
        }
        didSet {
            print("didSet")
        }
        
    }
    init(){
        self.age = 0
    }
}

class p2:P1 {
    override init() {
        super.init()
        self.age = 1;
    }
    
}

var stu = p2()


// 可失败初始化器
//:* 类 结构体，枚举都可以使用init定义可失败初始化器
//: -
class p3 {
    var name:String
    init?(name:String){
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

var p4 = p3(name:"")
//: * 不允许同时定义参数标签，参数个数，参数类型相同的可失败初始化器和非可失败初始化器 造成混淆不知道调用哪个
//: * 可以用init！定义隐式解包的可失败初始化器
//： * 可失败初始化器可以调用非可失败初始化器，非可失败初始化器调用可失败初始化器需要进行解包
//: * 如果初始化器调用一个可失败初始化器导致初始化失败，那么整个初始化过程都失败，并且之后的代码都停止执行

//: * 反初始化器（deint）
// : - deinit叫做反初始化器，类似c++的析构函数，OC里的Dealloc
//: - 当类的实例对象被释放内存时，就会调用实例对象的deinit方法
class Persion {
    deinit {
        print("销毁")
    }
}

// deinit 不接受任何参数 不能写小括号，不能自行调用
// 父类的deinit能被子类继承
// 子类的deinit 实现执行完毕后会调用父类的deinit

//: * 可选链

class Car {var price = 0}
class Dog {var weight = 0}
class Per{
    
    var name:String = ""
    var dog: Dog = Dog()
    var car :Car? = Car()
    func age()->Int{return 19}
    func eat(){print("person ear")}
    
    subscript(index:Int)->Int {
        index
    }
   
}

var ppp :Per? = Per()



var age =  ppp?.age()//int?
var age1 =  ppp!.age()//int
var str =  ppp?.name//string
var index = ppp?[7]//int?

//如果可选项为nil 调用方法，下标，属性失败，结果为nil
//如果可选项不为nil 调用方法，下标，属性成功，结果会被包装成可选项
//如果结果本来就是可选项，不会进行再次包装

//多个？可以连接在一起
//如果链中任何一个节点是nil 那么整个链就会调用失败

var dic = ["jack":[1,2,3],"rouse":[3,4,5]]

var s = dic["jack"]?[0]






//: [下一页](@next)
