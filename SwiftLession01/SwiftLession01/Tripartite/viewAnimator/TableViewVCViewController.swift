//
//  TableViewVCViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/17.
//

import UIKit
import ViewAnimator

class TableViewVCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    
    private var items = [Any?]()
    lazy var tableView :UITableView = {
        let tableview = UITableView()
        
        return tableview
    }()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    private let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupActivityIndicator()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        items = Array(repeating: nil, count: 20)
        activityIndicator.stopAnimating()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        tableView.reloadData()
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {
//            sender.isEnabled = true
        })
        // Do any additional setup after loading the view.
    }
    private func setupActivityIndicator() {
        activityIndicator.center = CGPoint(x: view.center.x, y: 100.0)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }

    // MARK: - Table view data source

   
    
     func animateTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 20)
        tableView.reloadData()
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {
            sender.isEnabled = true
        })
    }

    func resetTapped(_ sender: UIBarButtonItem) {
        items.removeAll()
        UIView.animate(views: tableView.visibleCells, animations: animations, reversed: true,
                       initialAlpha: 1.0, finalAlpha: 0.0, completion: {
            self.tableView.reloadData()
            self.activityIndicator.startAnimating()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return items.count
   }
	
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
       cell.textLabel?.text = "Cell: \(indexPath.row + 1)"
       cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
       return cell
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
