//
//  UIVisualEffectViewExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIVisualEffectViewExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["创建一个UIVisualEffectView对象"]]
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

// MARK: - 一、基本的扩展
extension UIVisualEffectViewExtensionViewController {
    
    // MARK: 1.1、创建一个UIVisualEffectView对象
    @objc func test11() {
        let visualEffectView = UIVisualEffectView.jx.visualEffectView(size: CGSize(width: 100, height: 100))
        let image = UIImage(named: "testicon")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.jx.centerX = self.view.jx.centerX
        imageView.addSubview(visualEffectView)
        self.view.addSubview(imageView)
        JXAsyncs.asyncDelay(3, {
        }) {
            imageView.removeFromSuperview()
        }
    }
}
