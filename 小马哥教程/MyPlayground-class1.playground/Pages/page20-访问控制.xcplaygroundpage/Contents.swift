//: [上一页](@previous)

import Foundation


//：* 访问控制 swift 提供了5个不同访问级别（以下从高到低排列，实体值被访问级别修饰的内容）

//:1 Open 允许在定义实体的模块，其他模块中访问，允许其他模块进行继承，重写（Open只能用在类，类成员上）
//:2 public 允许在定义实体的模块，其他模块中访问，不允许其他模块进行继承重写
//:3 internal 只允许在定义实体的模块中访问，不允许在其他模块中访问
//:4 fileprivate 只允许在定义实体的源文件中访问
//:5 private 只允许在定义实体的封闭声明中访问

// 绝大部分实体默认是internal 级别

// 访问级别的使用准则
//:* 一个实体不可以被更低访问级别的实体定义，
//: 1 变量、常量类型>= 变量，常量
//: 2 参数类型，返回值类型>=函数
//: 3 父类>子类
//: 4 父协议>=子协议
//: 5 原类型>= typealias
//: 6 原始类型 关联类型>= 枚举类型
//: 7 定义类型A时用到的其他类型>=类型A

// 元组类型的访问级别是所有成员类型最低的那个

internal struct Dog{}
fileprivate class Person{}
fileprivate var data1:(Dog,Person)
private var data2:(Dog,Person)

// 泛型类型的访问级别是类型的访问级别以及所有泛型类型参数的访问级别中最低的那个
internal class Car{}
fileprivate class Cat{}
public class Persons<T1,T2>{}

fileprivate var p = Persons<Car,Cat>()

//: 成员 嵌套类型 访问级别会影响成员（属性，方法，初始化器，下标）嵌套类型的默认访问级别
//: 1 一般情况 类型为private或者fileprivate 那么嵌套 成员类型的默认也是private或者fileprivate
//: 2 一般情况 类型为internal或者public 那么成员、嵌套类型默认是internal
public class PublicClass{
    public var p1 = 0
    var p2 = 0//internal
    fileprivate func f1(){}//fileprivate
    private func f2(){}//private
    
}

class InternalClass{//internal
    var p = 0 //internal
    fileprivate func f1(){}//fileprivate
    private func f2(){}//private
    
}

fileprivate class FilePrivateClass{ //fileprivate
    func f1(){}//fileprivate
    private func f2(){}//private
}

private class PrivateClass{//private
    func f(){}//private
}

// get set 默认自动接收他们所属环境的访问级别
// 可以给setter单独设置一个比getter更低的访问级别，用以限制写的权限


// 初始化器 如果一个public类 想在另一个模块调用编译生成的默认无参初始化器，必须显示提供public的无参初始化器
// 因为public类的默认初始化器是internal级别

// required 初始化器必须跟它的所属类拥有相同的访问级别

//如果结构体有private fileprivate的存储实例属性，那么它的成员初始化器也是private fileprivate


// 枚举 不能给enum的每个case单独设置访问级别

// 每个case自动接收enum的访问级别
// public enum 定义的case也是public


// 协议 协议中定义的要求自动接收协议的访问级别，不能单独设置访问级别
// public协议定义的要求也是public

//协议实现的访问级别必须>=类型的访问级别或者>= 协议的访问级别


// 扩展
// 如果有显式设置扩展的访问级别，扩展添加的成员自动接收扩展的访问级别
// 如果没有显式设置扩展的访问级别，扩展添加的成员默认访问级别，跟直接的类型中定义成员一样
// 可以单独给扩展添加的成员设置访问级别
// 不能给用于遵守协议的扩展显式设置扩展的访问级别










//: [下一页](@next)
