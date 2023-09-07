//
//  PayViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/22.
//

import UIKit

class PayViewController: UIViewController {
    
    
    @objc  var params:NSDictionary=[:] //接收传值必须在变量前加 @objc
    @objc var arr :Array<Any>?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(params)
        print(arr as Any)
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
