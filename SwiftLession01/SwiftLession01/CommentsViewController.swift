//
//  CommentsViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit

class CommentsViewController: UIViewController {

    var titleLab:UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        titleLab = UILabel.init(frame: CGRect.init(x: 10, y: 100, width: self.view.frame.size.width-20, height: 35))
        titleLab?.numberOfLines = 3;
        titleLab?.adjustsFontSizeToFitWidth = true
        titleLab?.text = "Swift 中的注释与 C 语言的注释非常相似。单行注释以双正斜杠（//）作为起始标记"
        let des = UILabel.init(frame: CGRect.init(x: 10, y: 140, width: self.view.frame.size.width-20, height: 35))
        des.textColor = UIColor.gray
        des.text = "// 这是一个注释"
        self.view.addSubview(titleLab!)
        self.view.addSubview(des)
        
        let titleLab1 = UILabel.init(frame: CGRect.init(x: 10, y: 170, width: self.view.frame.size.width-20, height: 35))
        titleLab1.numberOfLines = 4;
        titleLab1.adjustsFontSizeToFitWidth = true
        titleLab1.text = "你也可以进行多行注释，其起始标记为单个正斜杠后跟随一个星号（/*），终止标记为一个星号后跟随单个正斜杠（*/）:"
        self.view.addSubview(titleLab1)
        
        let des1 = UILabel.init(frame: CGRect.init(x: 10, y: 210, width: self.view.frame.size.width-20, height: 35))
        des1.textColor = UIColor.gray
        des1.text = "/* 这也是一个注释/n，\n但是是多行的 */"
        des1.numberOfLines =  2
        des1.adjustsFontSizeToFitWidth = true
        self.view.addSubview(des1)
        
        // Do any additional setup after loading the view.
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
