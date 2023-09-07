//
//  FullViewViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/17.
//

import UIKit
import ViewAnimator

class FullViewViewController: UIViewController {
    var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 90, height: 90)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: 100), collectionViewLayout: layout)
        
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(tableView)
        collectionView.register(ACollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(64)
            make.left.equalTo(10)
            make.width.equalTo(kScreenWidth-20)
            make.height.equalTo(130)
        }
        
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 65, bottom: 0, right: 0)
        tableView.register(ATableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(50)
            make.left.equalTo(10)
            make.width.equalTo(kScreenWidth-20)
            make.height.equalTo(kScreenHeight-180)
        }
        
        let buttonSearch = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
    buttonSearch.setImage(UIImage.init(named: "home_navitem_search"), for: UIControl.State.normal)
    buttonSearch.setTitle("动画", for: UIControl.State.normal)
        let color = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        buttonSearch.setTitleColor(color , for: .normal)
        
    buttonSearch.addTarget(self, action: #selector(animate), for: UIControl.Event.touchUpInside)
        let barButtonSearch = UIBarButtonItem(customView: buttonSearch)
    self.navigationItem.rightBarButtonItems = [barButtonSearch]
        // Do any additional setup after loading the view.
    }
    
  @objc  func animate() {
        // Combined animations example
        let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        UIView.animate(views: collectionView.visibleCells,
                       animations: [zoomAnimation, rotateAnimation],
                       duration: 0.5)
        
        UIView.animate(views: tableView.visibleCells,
                       animations: [fromAnimation, zoomAnimation], delay: 0.5)
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

extension FullViewViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ATableViewCell
        cell.userImageView.image = UIImage(named: "\(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension FullViewViewController: UICollectionViewDataSource ,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACollectionViewCell
        cell.backgroundColor = UIColor.red
        cell.layer.cornerRadius = 5.0
        cell.imageView.image = UIImage(named: "\(indexPath.item)")
        return cell
    }

}
