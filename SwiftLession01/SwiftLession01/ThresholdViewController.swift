//
//  ThresholdViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit

class ThresholdViewController: UIViewController {
    
    var uitextview :UITextView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "入门介绍"
        createView()
        
        // Do any additional setup after loading the view.
    }
    
    func createView(){
        uitextview = UITextView.init(frame: UIScreen.main.bounds);
        uitextview?.font = UIFont.systemFont(ofSize: 18)
        uitextview?.text = "Swift 是一门开发 iOS, macOS, watchOS 和 tvOS 应用的新语言。然而，如果你有 C 或者 Objective-C 开发经验的话，你会发现 Swift 的很多内容都是你熟悉的。Swift 包含了 C 和 Objective-C 上所有基础数据类型，Int 表示整型值； Double 和 Float 表示浮点型值； Bool 是布尔型值；String 是文本型数据。 Swift 还提供了三个基本的集合类型，Array、Set 和 Dictionary ，详见 集合类型。就像 C 语言一样，Swift 使用变量来进行存储并通过变量名来关联值。在 Swift 中，广泛的使用着值不可变的变量，它们就是常量，而且比 C 语言的常量更强大。在 Swift 中，如果你要处理的值不需要改变，那使用常量可以让你的代码更加安全并且更清晰地表达你的意图。除了我们熟悉的类型，Swift 还增加了 Objective-C 中没有的高阶数据类型比如元组（Tuple）。元组可以让你创建或者传递一组数据，比如作为函数的返回值时，你可以用一个元组可以返回多个值。Swift 还增加了可选（Optional）类型，用于处理值缺失的情况。可选表示 “那儿有一个值，并且它等于 x ” 或者 “那儿没有值” 。可选有点像在 Objective-C 中使用 nil ，但是它可以用在任何类型上，不仅仅是类。可选类型比 Objective-C 中的 nil 指针更加安全也更具表现力，它是 Swift 许多强大特性的重要组成部分。Swift 是一门类型安全的语言，这意味着 Swift 可以让你清楚地知道值的类型。如果你的代码需要一个 String ，类型安全会阻止你不小心传入一个 Int 。同样的，如果你的代码需要一个 String，类型安全会阻止你意外传入一个可选的 String 。类型安全可以帮助你在开发阶段尽早发现并修正错误。"
        self.view.addSubview(uitextview!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
