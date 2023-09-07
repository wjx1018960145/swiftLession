//
//  TripartiteListVC.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/9.
//

import UIKit

class TripartiteListVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var utils:Utils?
    var tableView :UITableView?
    var dataSource :NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        utils = Utils()
        let arr = utils!.getlockSourceForArr(fileName: "Tripartite.geojson")
        dataSource = NSMutableArray.init(array:arr)
        createView()
        // Do any additional setup after loading the view.
    }
    func createView(){
        tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.backgroundColor = UIColor.white
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = (dataSource?[indexPath.row] as! NSDictionary)["title"] as! String
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic =  dataSource?[indexPath.row] as![String:Any]
        
        if(dic["vc"] as! String=="BubbleTabBarController"){
            let eventsVC = SampleViewController()
            eventsVC.tabBarItem = UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "dashboard"), tag: 0)
            let searchVC = SampleViewController()
            searchVC.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "clock"), tag: 3)
            let activityVC = SampleViewController()
            activityVC.tabBarItem = UITabBarItem(title: "Activity", image: #imageLiteral(resourceName: "folder"), tag: 0)
            let settingsVC = SampleViewController()
            settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "menu"), tag: 0)
            settingsVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "clock")
            settingsVC.inverseColor()

            let tabBarController = BubbleTabBarController()
            tabBarController.viewControllers = [eventsVC, searchVC, activityVC, settingsVC]
            tabBarController.tabBar.tintColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
//        else if ((dic["vc"]! as! String).contains("_xib")){
//            let cellName = dic["vc"] as! String
//            
//            _ = cellName.range(of: "_xib")
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "photo")
//            
////            guard let vc = UIViewController.init(nibName: "CusomDemoViewController", bundle: nil)
//            
//            vc.title = dic["title"] as? String
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }
        else{
            let cellName = dic["vc"] as! String
            let vcName = cellName
            guard let vc = vcName.jx.toViewController() else {
               print("没有该名字的控制器：\(vcName)")
                return
            }
            vc.title = dic["title"] as? String
            navigationController?.pushViewController(vc, animated: true)
        }
        
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
