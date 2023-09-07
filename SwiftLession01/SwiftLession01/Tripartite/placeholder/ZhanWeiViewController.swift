//
//  ZhanWeiViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/16.
//

import UIKit

class ZhanWeiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    let arrayItems = [["列表", "TableViewController"],
                      ["网格列表", "CollectionViewController"],
                    
                     ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrayItems[indexPath.row].first
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = arrayItems[indexPath.row].last!
        guard let vc = vcName.jx.toViewController() else {
           print("没有该名字的控制器：\(vcName)")
            return
        }
        vc.title = vcName
        navigationController?.pushViewController(vc, animated: true)
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
