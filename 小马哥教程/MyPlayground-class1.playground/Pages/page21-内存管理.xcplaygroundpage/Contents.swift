//: [上一页](@previous)

import Foundation

//:* 内存管理
//:1 跟OC一样swift也是采取基于引用计数的ARC内存管理方案（针对堆空间）
//:2 swift的ARC有三种引用
//:2.1 强引用 默认情况下引用都是强引用
//:2.2 弱引用 通过weak定义弱引用
//:2.2.1 必须是可选类型var 因为实例销毁后，ARC会自动将弱引用设置为nil
//:2.2.2 ARC自动给弱引用设置nil时，不会触发属性观察器

//:2.3 无主引用 通过unowned定义无主引用
//:2.3.1 不会产生强引用，实例销毁后扔然存储着实例的内存地址（类似OC中的unsafe_unretained）
//:2.3.2 试图在实例销毁后访问无主引用，会产生运行时错误（野指针）


// weak unowned 使用限制
//weal unowned 只能用在类实例上面

// Autoreleasepool

//autoreleasepool {
//    let p = Pose(age:2)
//
//}

//循环引用(Reference Cyle)

//weak unowned 都可以解决循环引用的问题 unowned要比weak少一些性能消耗
// 在生命周期中随时可能变为nil使用weak
// 初始化赋值后再也不会变为nil的使用unowned


// 闭包的循环引用
//: 闭包表达式会默认对用到的外层对象产生额外的强引用（对外层对象进行了retain操作）
//: 下面代码会产生循环引用，导致Person对象无法释放（看不到Person的deinit被调用）

class Person {
    var fn:(()->())?
    func run(){
        print("run")
    }
    deinit{
        print("deinit")
    }
}

func test() {
    let p = Person()
    
    p.fn = {
        p.run()
    }
}

// 在闭包表达式的捕获列表声明weak或unowned引用，解决循环引用


func test1(){
    let p = Person()
    p.fn = {
        [weak p] in
        p?.run()
    }
}




//test()

test1()

// 如果想在定义闭包属性的同时引用self，这个闭包必须是lazy的（因为在实例初始化完毕之后才能引用self）

class Cat{
    lazy var fn:(()->()) = {
        [weak self] in
        self?.run()
    }
    func run(){print("run")}
    deinit {
        print("deinit")
    }
}
// 如果lazy属性是闭包调用的结果，那么不用考虑循环引用的问题（因为闭包调用后，闭包的生命周期就结束了）

class Dog{
    lazy var get:Int = {
        self.age
    }()
    var age = 10
    deinit {
     print("deint")
    }
    
}
func test3(){
    var d = Dog()
    d.get
}

test3()

// 逃逸闭包 （@escaping）
// 逃逸闭包 非逃逸闭包 一般当做参数传递给函数
// 非逃逸闭包：闭包调用发生在函数结束前，闭包调用在函数作用域内
// 逃逸闭包 闭包有可能在函数结束后调用，闭包调用逃离了函数的作用域，需要通过@scaping声明

import Dispatch

typealias Fn = ()->()

//fn 是非逃逸
func t(_ fn:Fn){fn()}
//fn 是逃逸闭包
var gFn:Fn?
func t1(_ fn: @escaping Fn){gFn = fn}
// fn是逃逸闭包
func t2(_ fn:@escaping Fn){
    DispatchQueue.global().async{
        fn()
    }
}







//: [下一页](@next)
