//
//  H5ViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/20.
//

import UIKit

class H5ViewController: UIViewController {
    
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("打开离线包应用", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.addTarget(self, action: #selector(openJsApiDemo), for: .touchUpInside)
        return button
    }()
    
    lazy var web: UIButton = {
        let button = UIButton()
        button.setTitle("更新离线包", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(updateOffLinePackage), for: .touchUpInside)
        return button
    }()
    
    lazy var offlinePackage: UIButton = {
        let button = UIButton()
        button.setTitle("预置离线包", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(openPresetPackage), for: .touchUpInside)
        return button
    }()
    
    lazy var jsapi: UIButton = {
        let button = UIButton()
        button.setTitle("远程离线包", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(openJsApiDemo), for: .touchUpInside)
        return button
    }()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(web)
        view.addSubview(offlinePackage)
        view.addSubview(jsapi)
        button.snp.makeConstraints { make in
            make.top.equalTo(164)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(45)
        }
        
        web.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(45)
        }
        offlinePackage.snp.makeConstraints { make in
            make.top.equalTo(web.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(45)
        }
        jsapi.snp.makeConstraints { make in
            make.top.equalTo(offlinePackage.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalTo(kScreenWidth-40)
            make.height.equalTo(45)
        }
        
//        HTSDKEngine.sharedInstance.startH5ViewControllerWithParams(params: ["url":"/www/main.html"])
        
        
        // Do any additional setup after loading the view.
    }
    
   @objc  func openJsApiDemo() {
       
       let package = ["appId":"12345678"]
       
       HTSDKEngine.sharedInstance.startH5ViewControllerWithNebulaApp(params: package)
       
//        [[HTSDKEngine shareInstance] startH5ViewControllerWithNebulaApp:@{@"appId":@"70000000"}];
    }
    
    @objc func updateOffLinePackage()
    {
        // 更新离线包
//        [[MPNebulaAdapterInterface shareInstance] requestNebulaAppsWithParams:@{@"70000000":@"*"} finish:^(NSDictionary *data, NSError *error) {
//            if (!error) {
//                NSLog(@"[mpaas] nebula rpc data :%@", data[@"data"]);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"message" message:@"更新成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//                    [alert show];
//                });
//            }
//        }];
    }
    
    @objc func openPresetPackage() {
//        [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithNebulaApp:@{@"appId":@"00025000"}];
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
