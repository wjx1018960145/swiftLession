//
//  BaseViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/14.
//

import UIKit

class BaseViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
  
    var utils:Utils?
    var tableView :UITableView?
    var dataSource :NSMutableArray?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        utils = Utils()
        let arr = utils!.getlockSourceForArr(fileName: "Base.geojson")
        
        dataSource = NSMutableArray.init(array:(arr))
    
        
        
        createView()
        self.hidesBottomBarWhenPushed = true
        // Do any additional setup after loading the view.
    }
   
    
    func createView(){
        tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dic = dataSource?[indexPath.row] as! NSDictionary
        cell.textLabel?.text = dic["title"] as! String?

        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc =  MarkDownViewController()
        let dic =  dataSource?[indexPath.row] as![String:Any]
        vc.url = dic["mdName"] as? NSString
        vc.titleStr = dic["title"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
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
