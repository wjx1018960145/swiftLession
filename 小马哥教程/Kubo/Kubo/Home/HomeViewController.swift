//
//  HomeViewController.swift
//  Kubo
//
//  Created by wjx on 2023/9/21.
//

import UIKit


import SwiftyJSON
import KakaJSON
import MJRefresh
import Kingfisher

class HomeViewController: UIViewController {
    
    lazy var tableView = UITableView()//隐式解包 确定有值
    lazy var items = [Move]()
    static let ItemCellid = "Item"
    var page:Int = 1
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellid)
        view.addSubview(tableView)
        let headr = MJRefreshNormalHeader(refreshingBlock: self.loadNewData)
        headr.beginRefreshing()
        tableView.mj_header = headr
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: self.loadModeData)
       
        
        
            
            
           
        }
        
        
    func loadNewData (){
        
        
        print(API.api+API.getVideo())
        AF.request(API.api + API.getVideo()+"/\(1)",method: .get,parameters: ["pageNum":1]).responseJSON {  response in
           
//            guard let dict =  as  else {return}
            guard let dict = response.data else {return}
            
            let jsons = JSON(dict)["records"].arrayObject
            print(jsons)
             let modeArrs =  modelArray(from: jsons!,Move.self)
            
            
            
            self.items.removeAll()
            self.items.append(contentsOf: modeArrs)
            self.tableView.reloadData()
            self.tableView.mj_header?.endRefreshing()
            print(modeArrs)
           
        }
    }
    
    func loadModeData(){
        
        AF.request(API.api + API.getVideo()+"/\(page+1)",parameters: ["pageNum":page+1]).responseJSON {  response in
           
//            guard let dict =  as  else {return}
            guard let dict = response.data else {return}
            
            let jsons = JSON(dict)["records"].arrayObject
            print(jsons!)
             let modeArrs =  modelArray(from: jsons!,Move.self)
            
            
            
//            self.items.removeAll()
            self.items.append(contentsOf: modeArrs)
            self.tableView.reloadData()
            self.tableView.mj_footer?.endRefreshing()
            print(modeArrs)
            self.page+=1
           
        }
        
        
    }
        
        // Do any additional setup after loading the view.
    
    


}

extension HomeViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellid, for: indexPath)
        var tmp = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellid, for: indexPath)
        
        if tmp == nil {
            tmp = UITableViewCell(style: .subtitle, reuseIdentifier: Self.ItemCellid)
        }
        let cell = tmp
        
        let item = items[indexPath.row]
//        print( API.api+API.getImage(item.id))
        cell.imageView?.kf.setImage(with:URL(string: API.api+API.getImage(item.id)))
        cell.textLabel?.text = item.title
         
        return cell
    }
}
extension HomeViewController :UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
