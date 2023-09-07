//
//  ViewController.swift
//  HGPlaceholders
//
//  Created by HamzaGhazouani on 07/20/2017.
//  Copyright (c) 2017 HamzaGhazouani. All rights reserved.
//

import UIKit

import HGPlaceholders

class TableViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,PlaceholderDelegate{
    
    
    var placeholderTableView: TableView?
    
    lazy var tableView: TableView = {
        let table = TableView()
        return table
    }()

    var arrayItems:Array<Any>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "ExampleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomPlaceholderCell")
        
       
        
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        placeholderTableView = tableView as? TableView
        
        placeholderTableView?.placeholderDelegate = self
        
       
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPlaceholderCell", for: indexPath)
        cell.textLabel?.text = arrayItems?[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        placeholderTableView?.showDefault()
        switch indexPath.row {
        case 0:
            placeholderTableView?.showLoadingPlaceholder()
        case 1:
            placeholderTableView?.showNoResultsPlaceholder()
        case 2:
            placeholderTableView?.showErrorPlaceholder()
        case 3:
            placeholderTableView?.showNoConnectionPlaceholder()
        case 4:
            let key = PlaceholderKey.custom(key: "starWars")
            placeholderTableView?.showCustomPlaceholder(with: key)
        case 5:
            let key = PlaceholderKey.custom(key: "XIB")
            placeholderTableView?.showCustomPlaceholder(with: key)
            
            
        default:
            placeholderTableView?.showDefault()
        }
    }
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        self.arrayItems = ["ce","qw"]
        placeholderTableView?.reloadData()
//        self.placeholderTableView?.reloadData()
//        placeholderTableView?.showDefault()
    }
}
