//
//  OfflinePackageViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/20.
//

import UIKit

class OfflinePackageViewController: UIViewController {

//    lazy var button: UIButton = {
//        let button = UIButton()
//        button.setTitle("更新离线包", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
//        button.addTarget(self, action: #selector(offline), for: .touchUpInside)
//        return button
//    }()
    
    lazy var web: UIButton = {
        let button = UIButton()
        button.setTitle("在线页面", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(weboffline), for: .touchUpInside)
        return button
    }()
    
    lazy var offlinePackage: UIButton = {
        let button = UIButton()
        button.setTitle("离线包", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(openNebulaPage), for: .touchUpInside)
        return button
    }()
    
    lazy var jsapi: UIButton = {
        let button = UIButton()
        button.setTitle("自定义 JsApi", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(customJsApi), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(button)
        view.addSubview(web)
        view.addSubview(offlinePackage)
        view.addSubview(jsapi)
//        button.snp.makeConstraints { make in
//            make.top.equalTo(164)
//            make.left.equalTo(20)
//            make.width.equalTo(kScreenWidth-40)
//            make.height.equalTo(45)
//        }
        
        web.snp.makeConstraints { make in
            make.top.equalTo(164)
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
        
        HtmlURLProtocol.HtmlURLProtocolRegisterScheme(scheme: "http")
        HtmlURLProtocol.HtmlURLProtocolRegisterScheme(scheme: "https")
        // Do any additional setup after loading the view.
    }
    
    @objc func offline(){
        let vc = H5ViewController()
        vc.title = "H5容器"
        
        HTSDKEngine.registerDefaults(appId: "12345678")
        
        
        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func weboffline(){
//        let vc = H5ViewController()
        
        HTSDKEngine.sharedInstance.startH5ViewControllerWithParams(params:["asd":"asd","url":"http://172.17.1.196:8080/offline/#/Demo"])
        
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func openNebulaPage(){
        let vc = H5ViewController()
        vc.title = "H5容器"
        self.navigationController?.pushViewController(vc, animated: true)
//        MPNebulaViewController *vc = [[MPNebulaViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
    @objc func customJsApi(){
//        let vc = TestJSCallNativeViewController()
        let vc = TestVuejsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
       // [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithNebulaApp:@{@"appId":@"70000000"}];
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
