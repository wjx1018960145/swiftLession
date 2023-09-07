//
//  LoginViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/21.
//

import UIKit


typealias callBackType = (String)->() //这个是在类外部定义
typealias callBackType2 = (String,String)->()//

class LoginViewController: UIViewController {
    
    
   
    @objc var name: String?

    @objc var image:UIImage?

   
//    let  image:UIImage = UIImage()
    @objc var  callback:(()->())?
    @objc var callBacks:callBackType?
    @objc var callBack2:callBackType2? //@objc 注解后悔会自动生成一个set方法
    var label:UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    var header:UIImageView = {
        let header = UIImageView()
        
        return header
    }()
    
    var button:UIButton = {
        let button = UIButton()
        button.setTitle("callback", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(callbacks), for: .touchUpInside)
        return button
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(header)
        view.addSubview(button)
        label.snp.makeConstraints { make in
            make.top.equalTo(164)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(40)
        }
        header.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        label.text = name
        header.image = image
//        self.callBack?()
//        self.callback
//        self.callback2
        // Do any additional setup after loading the view.
    }
    
    
     
    
    @objc func callbacks(){
      
       callBacks?("")
        callBack2?("123","wqweq")
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
