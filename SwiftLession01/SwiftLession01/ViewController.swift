//
//  ViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var tableview :UITableView?
    //数据
    var dataSource:NSMutableArray=[]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataSource[indexPath.row])
        if indexPath.row == 0{
            self.navigationController?.pushViewController(ThresholdViewController(), animated: true)
        }else if indexPath.row == 1 {
            self.navigationController?.pushViewController(BaseViewController(), animated: true)
        }else if indexPath.row == 2{
            self.navigationController?.pushViewController(UIKitViewController(), animated: true)
        }else if indexPath.row == 3{
            self.navigationController?.pushViewController(TripartiteListVC(), animated: true)
        }
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview?.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell?.textLabel?.text = dataSource[indexPath.row] as? String
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.title = "Swift课堂"
        self.dataSource = NSMutableArray.init(array: ["入门介绍","基础知识","UIKit","常用第三方"])
        createTableview()
        // Do any additional setup after loading the view.
    }
    func  createTableview(){
        tableview = UITableView.init(frame: UIScreen.main.bounds,style: .plain)
        tableview?.dataSource = self
        tableview?.delegate = self;
        tableview?.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        //去掉多余的分割线
        tableview?.tableFooterView = UIView()
        self.view.addSubview(tableview!)
        
        
        
    }

}

