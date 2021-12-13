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
            self.navigationController?.pushViewController(CommentsViewController(), animated: true)
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
        self.dataSource = NSMutableArray.init(array: ["入门介绍","注释","常量与变量","基本数据类型与运算符","元组","逻辑分支","循环","字符","字符串","数组","集合","字典","可选型","函数","闭包","高阶函数","实用知识点","枚举","结构体","类","属性与方法","构造与析构函数","结构体与类","类型转换","协议","扩展","Associated Object","泛型","异常","Result","Never","元类型、.self 与 Self","@objc","where","Key Path","@dynamicMemberLookup","@dynamicCallable","访问权限","Codable协议","playground可视化开发","混合开发","命名空间","常用数据类型"])
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

