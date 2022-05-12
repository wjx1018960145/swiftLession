//
//  UIImageViewExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIImageViewExtensionViewController: TestBaseViewController {
    var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、加载 gif"]
        dataArray = [["加载本地的gif图片", "加载 asset 里面的图片", "加载网络 url 的 gif 图片"]]
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

// MARK: - 一、加载 gif
extension UIImageViewExtensionViewController {
    // MARK: 1.3、加载网络 url 的 gif 图片
    @objc func test13() {
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        gifImageView.jx.loadGif(url: "http://qq.yh31.com/tp/zjbq/201711092144541829.gif")
        gifImageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(gifImageView)
        JXAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、加载 asset 里面的图片
    @objc func test12() {
        guard let image = UIImage.jx.gif(asset: "pika3") else {
            return
        }
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: image.size.width, height: image.size.height))
        gifImageView.jx.loadGif(asset: "pika3")
        gifImageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(gifImageView)
        JXAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、加载本地的gif图片
    @objc func test11() {
      
        gifImageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        gifImageView.jx.loadGif(name: "pika2")
        gifImageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(gifImageView)
        JXAsyncs.asyncDelay(5) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.gifImageView.removeFromSuperview()
        }
    }
}
