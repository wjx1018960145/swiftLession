//
//  RouterViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/21.
//

import UIKit

typealias callback = (String)->()

class RouterViewController: UIViewController {
    
    
   
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("跳转", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(offline), for: .touchUpInside)
        return button
    }()
    
    lazy var paybutton: UIButton = {
        let button = UIButton()
        button.setTitle("支付", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "路由器"
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(paybutton)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(164)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(45)
        }
        paybutton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(45)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func offline(){
        let vc = H5ViewController()
        vc.title = "H5容器"
        
//         let  todo = {(value:String) -> () in
//
//             print("12312312"+value)
//         }
        
        
        let closure = {
            print("block")
        }
        let block: @convention(block) () -> () = closure
//        self.perform(selector, with: block)
        
        let block2: @convention(block)(_ name:String,_ age:String)->() = {res,res1 in
            print("block2:\(res+res1)")
        }
        
        let image = UIImage(named: "header") as Any
        
//        let dic = ["Key":{(value:AnyObject) -> String in return value.description}]
            
        _ =  WJXVCRouter.openURL(url: "Pages/Login$Regs/login", parameters: ["name": "Jersey","image":image,"setCallBack":block,"setCallBack2":block2])
        
       // [WJXVCRouter openURL:"" parameters:["name": "Jersey", "image":[UIImage imageNamed:"header"]],@"callback": callback, @"callback2": callback2]];
//        Navigator.push("asdas")
        
//        HTSDKEngine.registerDefaults(appId: "12345678")
        
        
        
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func pay(){
        _ = WJXVCRouter.openURL(url: "Pages/Pay/pay", parameters:  ["params":["payId":"123123"],"arr":[1,2,"qwe","fgt"]])
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
