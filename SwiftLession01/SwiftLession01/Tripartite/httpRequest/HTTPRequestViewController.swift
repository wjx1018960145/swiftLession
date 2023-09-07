//
//  HTTPRequestViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/17.
//

import UIKit

struct BaseModel: Codable {
    let body:String
    let title:String
    let userId:Int
}

struct TestModel:Codable {
    let code:Int
    let message:String
    let result:[Item]
}
struct Item:Codable {
    let text:String
    let video:String
}
struct ResultModel:Codable{
    let city:String
    let citykey:String
    let parent:String
    let updateTime:String
}

class HTTPRequestViewController: UIViewController {

    //设置全局header
    func setHeader() -> Void {
        Mesh.canLogging = true
        Mesh.setGlobalHeaders(["key":"123123"])
        Mesh.setDefaultParameters(["DefKey":"any","a":"1","b":"2"])
    }
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setHeader()
        //防止被人抓包
        Mesh.disableHttpsProxy()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        
        
        MeshRequest.get("https://www.baidu.com", modelType: [BaseModel].self) { data in
            self.label.text = String(describing: data)
            print("\(String(describing: data))")
        }
        
       

        
        let a = MeshRequest.get("https://www.baidu.com", modelType: ResultModel.self, modelKeyPath: "cityInfo") { (model) in
            print("22222\(String(describing: model))")
        }
        a?.cancel()
        Mesh.requestWithConfig { config in
            config.URLString = "https://www.baidu.com"
            config.requestMethod = .get
        } success: { config in
            guard let data = config.response?.data else{
                return
            }
            let dic = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            print("\(String(describing: dic?["holiday"]))")
        } failure: { config in
            print("error getHoliday")
        }

        // Do any additional setup after loading the view.
    }
    func get(dd: Double, ss: String){
        print("\(dd),\(ss)")
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
