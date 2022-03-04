//
//  FoundationExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/4.
//

import Foundation
import UIKit

class FoundationExtensionViewController :UIViewController {
   
    
    
    fileprivate static let FoundationExtensionViewControllerCellIdentifier = "FoundationExtensionViewControllerCellIdentifier"
    ////资源数组
    ///
    fileprivate var dataArray = [Any]()
    //完成的类
    fileprivate var finishedDataArray :[String] = []
    lazy var tableview :UITableView = {
        let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: jx_kScreenH-CGFloat(jx_kNavFrameH)), style: .grouped)
        if #available(iOS 11, *){
            tableview.estimatedSectionFooterHeight = 0
            tableview.estimatedSectionHeaderHeight = 0
//            tableview.contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        tableview.backgroundColor = UIColor.white
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableview.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: 0.01))
        tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: 0.01))
        tableview.rowHeight = UITableView.automaticDimension
        tableview.jx.register(cellClass: BaseViewCell.self)
        
        
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.edgesForExtendedLayout = [];
        self.view.backgroundColor = .white
        dataArray = ["Array+Extension", "DispatchQueue+Extension", "NumberFormatter+Extension", "CLLocation+Extension", "NSRange+Extension", "Range+Extension", "AVAssetExportSession+Extension", "NSIndexPath+Extension", "Bundle+Extension", "UserDefaults+Extension", "Date+Extension", "NSObject+Extension", "String+Extension", "UIDevice+Extension", "UIFont+Extension", "Timer+Extension", "Int+Extension", "Double+Extension", "UInt+Extension", "Int64+Extension", "Float+Extension", "Data+Extension", "Bool+Extension", "CGFloat+Extension", "Character+Extension", "DateFormatter+Extension", "Dictionary+Extension", "FileManager+Extension", "URL+Extension", "NSDecimalNumberHandler+Extension", "NSAttributedString+Extension", "NSMutableAttributedString+Extension"]
        finishedDataArray = ["String+Extension", "NumberFormatter+Extension", "Range+Extension", "CLLocation+Extension", "NSRange+Extension", "AVAssetExportSession+Extension", "Data+Extension", "Date+Extension", "Character+Extension", "Int+Extension", "Int64+Extension", "UIFont+Extension", "Bool+Extension", "DispatchQueue+Extension", "CGFloat+Extension", "Float+Extension", "UIDevice+Extension", "UInt+Extension", "URL+Extension", "UserDefaults+Extension", "Double+Extension", "FileManager+Extension", "NSDecimalNumberHandler+Extension", "Bundle+Extension", "NSAttributedString+Extension"]
        initUI()
    }
    
    
    private func initUI() {
        
        view.addSubview(tableview)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
extension FoundationExtensionViewController :UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jx.dequeueReusableCell(cellType: BaseViewCell.self, cellForRowAt: indexPath)
        let cellName = dataArray[indexPath.row] as! String
        cell.contentLabel.text = "\(indexPath.row + 1)：\(cellName)"
        cell.contentLabel.textColor = finishedDataArray.contains(cellName) ? UIColor.hexStringColor(hexString: "#006400") : UIColor.gray
        // cell.lineView.isHidden = indexPath.row == dataArray.count - 1 ? true : false
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height:0.01))
        return sectionView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionFootView = UIView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: 0.01))
        return sectionFootView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellName = dataArray[indexPath.row] as! String
        let vcName = cellName.jx.removeSomeStringUseSomeString(removeString: "+") + "ViewController"
        guard let vc = vcName.jx.toViewController() else {
           print("没有该名字的控制器：\(vcName)")
            return
        }
        vc.title = cellName
        navigationController?.pushViewController(vc, animated: true)
    }
}
