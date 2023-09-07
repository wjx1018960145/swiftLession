//: [上一页](@previous)

import Foundation


//:* 继承 值类型（枚举，结构体）不支持继承 只有类支持继承
//: - 没有父类的类成为：基类
//swift没有像OC Java那样的规定，任何类最终都要继承自某个基类
//子类可以重写父类的下标，方法，属性，重写必须加上override关键字

//内存结构
//8个字节存储实例地址 8个存储引用数据 每个int类型8个字节 每个继承过来的属性也要加上 最后补上无用的必须是16的倍数

//重写实例方法，下标

class Animal {
    
    func speak(){
        print(" speak")
    }
    subscript(index :Int)->Int{
        return index
        
    }
}

class Cat :Animal {
    override func speak() {
        super.speak()
        print("cat spek")
    }
    override subscript(index: Int) -> Int {
        return super[index]+1
    }
    
}

// 重写类型方法 下标

//:- 被class修饰的类型方法，下标，允许被子类重写
//: - 被static修饰的类型方法，下标，不允许被子类重写

//重写属性
//:- 子类可以将父类的属性（存储，计算） 重写为计算属性
//:- 子类不可以将父类重写为存储属性
//: - 只能重写var属性，不能重写let属性
//: - 重写是，属性名，类型要一致
//: - 子类重写后的属性权限不能小于父类属性权限
//: - 如果父类属性是只读，那么子类重写后属性可以是只读，也可以是可读写的
//: - 如果父类属性是可读写的，那么子类重写后属性必须是可读写的


//

//重写属性观察器 可以在子类为父类属性（除了只读计算属性，let属性）增加属性观察器

class Circle {
    var radius:Int = 1{
        willSet{
            print(" circle willsetRadius",newValue)
        }
        didSet {
            print("circle didSetRadius",oldValue,radius)
        }
    }
}

class subCircle :Circle{
    override var radius:Int {
        willSet {
            print("Subcircle willSetRadius",newValue)
        }
        didSet{
            print("SubCircle didSetRadius",oldValue,radius)
        }
    }
}

var c = subCircle()
c.radius = 10

//:* final 被final修饰的方法，下标，属性，禁止被重写
// - 被final修饰的类，禁止被继承






//: [下一页](@next)
