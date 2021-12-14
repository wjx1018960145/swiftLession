//
//  UIKitViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/14.
//

import UIKit

class UIKitViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var utils:Utils?
    var tableView :UITableView?
    var dataSource :NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        utils = Utils()
        let arr = utils!.getlockSourceForArr(fileName: "UIkit.geojson")
        dataSource = NSMutableArray.init(array:arr)
    
        
        
        createView()
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
        
        cell.textLabel?.text = (dataSource?[indexPath.row] as! NSDictionary)["title"] as! String
        cell.accessoryType = .disclosureIndicator
        return cell
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
