//
//  ViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit
import ViewAnimator
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
           let vc = ThresholdViewController()
            vc.title = dataSource[indexPath.row] as? String
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = BaseViewController()
            vc.title = dataSource[indexPath.row] as? String
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = UIKitViewController()
            vc.title = dataSource[indexPath.row] as? String
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = TripartiteListVC()
            vc.title = dataSource[indexPath.row] as? String
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let vc = FoundationExtensionViewController()
            vc.title = dataSource[indexPath.row] as? String
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            let vc = UIKitExtensionViewController()
            vc.title = dataSource[indexPath.row] as? String
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 7{
//            Themes.switchToNext()
        }
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableview?.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        
        let cell = tableView.jx.dequeueReusableCell(cellType: TableViewCell.self, cellForRowAt: indexPath)
        
        cell.contentLabel.text = dataSource[indexPath.row] as? String
//        cell?.textLabel?.textColor = UIColor.black
//        cell?.accessoryType = .disclosureIndicator
//        cell?.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
    
    private var isTabBarHidden = false // TabBar是否隐藏
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
        
      
        
        if #available(iOS 15.0, *) {
//             let app = UINavigationBarAppearance()
//             app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
//             app.titleTextAttributes = [
//                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
//                   NSAttributedString.Key.foregroundColor: UIColor.white
//             ]
//             app.backgroundColor = UIColor.init(hexString: "#2C81EC")  // 设置导航栏背景色
//             app.shadowColor = .clear
//             UINavigationBar.appearance().scrollEdgeAppearance = app  // 带scroll滑动的页面
//             UINavigationBar.appearance().standardAppearance = app // 常规页面。描述导航栏以标准高度
        }
        self.title = "Events"
        self.dataSource = NSMutableArray.init(array: ["入门介绍","基础知识","UIKit","常用第三方","Foundation扩展","Protocol","UIKit扩展"])
        createTableview()
        
        let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//        UIView.animate(views: collectionView.visibleCells,
//                       animations: [zoomAnimation, rotateAnimation],
//                       duration: 0.5)
        
        UIView.animate(views: tableview!.visibleCells ,
                       animations: [fromAnimation, zoomAnimation], delay: 0.5)
        // Do any additional setup after loading the view.
    }
    func inverseColor() {
        view.backgroundColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
//        lblTitle.textColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return view.backgroundColor == UIColor.white ? .default : .lightContent
    }

    
    func  createTableview(){
        tableview = UITableView.init(frame: CGRect(x: 10, y: 100, width: self.view.frame.size.width-20, height: self.view.frame.size.height-280),style: .plain)
        tableview?.dataSource = self
        tableview?.delegate = self;
        tableview?.estimatedRowHeight = 80.0
        tableview?.backgroundColor = UIColor.clear
        tableview?.jx.register(cellClass: TableViewCell.self)
        tableview?.layer.masksToBounds = true
        tableview?.layer.cornerRadius = 10.0
        //去掉多余的分割线
        tableview?.tableFooterView = UIView()
        //去除滚动条
        tableview?.showsVerticalScrollIndicator = false
        self.view.addSubview(tableview!)
        
        
        
    }

}

