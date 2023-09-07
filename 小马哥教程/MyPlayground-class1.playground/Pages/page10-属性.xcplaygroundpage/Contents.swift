//: [上一页](@previous)

import Foundation



//:* 属性
//: ** 存储属性（store Property）
//: - 类似于成员变量这个概念
//: - 存储在实例的内存中
//: - 结构体，类可以定义存储属性
//: - 枚举不可以定义存储属性

//: ** 关于存储属性 swift明确的规定
//: - 在创建类或结构体实例时 必须所有的存储属性设置一个合适的初始值
//: - 可以在初始化器里为存储属性设置一个初始值
//: - 可以发分配一个默认的属性作为属性定义的一部分









//: ** 计算属性（computed property）
//: - 本质就是方法（函数）
//: - 不占用实例内存
//: - 枚举 结构体 类都可以定义计算属性

//: ** 关于计算属性的注意点
//: - set传入的新值默认叫做newValue，也可以自定义
//: ** 只读计算属性 只有get 没有set 但是设置了set必需要设置get
//: - 定义计算属性只能用var  不能用let let 代表常量：值是一成不变的
//： - 计算属性的值可能发生变化(即使是只读计算属性)
//: -
struct circle {
    var radius:Double
    var diameter:Double {
        get{
            radius * 2
        }
//        set {
//            radius/2
//        }
    }
}

//: * 枚举rawValue原理 本质就是只读的计算属性
//: -
enum Season:Int {
    case spring ,sunmmer,autumi,winter
    
    var rawValue:Int{
        switch self {
        case .spring:
            return 10
        case .sunmmer:
            return 20
        case .autumi :
            return 30
        case .winter :
            return 40
            
        }
    }
}

//: * 延迟存储属性 （lazy stored property）

// - 使用lazy可以定义一个延迟存储属性，在第一次用到属性的时候才会进行初始化
// - lzay 属性必须是var 不能是let
// - let  必须在实例的初始化方法之前就拥有值
// - 如果多条线程同时第一次访问lazy属性 无法保证属性只被初始化一次

//: ** 当结构体包含一个延迟存储属性时，只有var才能访问延迟存储属性 因为延迟属性初始化时需要改变结构体的内存


 

class Car{
    init(){
        print("car init")
        
    }
    func run (){
        print("Car runing")
    }
}

class Person{
    lazy var car = Car()
    
    init() {
        print("Persion init")
    }
    func goOut(){
        car.run()
    }
}
let p = Person()

print("-------")

p.goOut()

//: * 属性观察器
 
//: -  可以为非lazy的var 存储属性设置属性观察器

//: ** 属性观测器注意点
//: - willSet 会传递心智 默认叫newValue didSet 会传递旧值 默认叫oldValue
//: - 在初始化器中设置默认属性值不会触发willSet和didSet
//: - 在属性定义时设置初始值也不会触发willSet和didSet

struct Circle {
    
    var radius:Double {
        willSet {
            print(" willset ",newValue)
        }
        didSet {
            print("didSet ",oldValue,radius)
        }
    }
    init(){
        self.radius = 1.0
        print("init")
    }
    
}

var c = Circle()

c.radius = 10

print(c.radius)


//: *inout再次研究 本质就是引用地址传递
//: -如果实参有物理内存地址，且没有设置属性观察器 直接将实参的内存地址传入函数（实参进行引用传递）
//: - 如果实参是计算属性 或者设置了属性观察器 采取copy in copy out 的做法
//: 1 调用该函数时先复制实参的值，产生副本【get】
//: 2 将副本的内存地址传入函数（副本进行引用传递）在函数内部可以修改副本值
//: 3 函数返回后 再将副本的值覆盖实参的值【set】



func test(_ num: inout Int){
    num = 10
}

var age = 20
test(&age)
print(age)


//:* 类型属性
//: ** 实例属性 只能通过实例去访问
//: - 存储实例属性：存储在实例的内存中 每个实例都有一份
//: - 计算实例属性

//: ** 类型属性 只能通过类型访问
//: - 存储类型属性 整个程序运行过程中就只有一份内存
//: - 计算类型属性

// * 可以通过static定义类型属性
//如果是类 也可以用关键字 class

//类型属性细节
//不同于存储实例属性，你必须给存储实例属性设定初始值 因为类型没有像实例那样的init初始化器存储属性

//存储类型属性默认就是lazy 会在第一次使用的时候才初始化 就算被多个线程同时访问，保证会初始化一次
//存储类型属性可以是let

//枚举类型也可以定义类型属性（存储类型属性，计算类型属性）

//单例模式

class FileManager {
    public static let  shared  = FileManager()
   private init(){
        
    }
    func close(){
        
    }
    static func open(){
        
    }
}


FileManager.shared.close()

FileManager.open()



//: [下一页](@next)
