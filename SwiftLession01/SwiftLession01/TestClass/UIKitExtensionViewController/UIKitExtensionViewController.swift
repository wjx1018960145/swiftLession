//
//  UIKitExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class UIKitExtensionViewController: UIViewController {

    fileprivate static let UIKitExtensionViewControllerCellIdentifier = "UIKitExtensionViewControllerCellIdentifier"
    /// 资源数组
    fileprivate var dataArray = [Any]()
    /// 完成的类
    fileprivate var finishedDataArray: [String] = []
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame:CGRect(x:0, y: 0, width: jx_kScreenW, height: jx_kScreenH - CGFloat(jx_kNavFrameH)), style:.grouped)
        if #available(iOS 11, *) {
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: 0.01))
        // 设置行高为自动适配
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BaseViewCell.self, forCellReuseIdentifier: UIKitExtensionViewController.UIKitExtensionViewControllerCellIdentifier)
        // tableView.addWater(markText: "JKSwiftExtension", textColor: UIColor.randomColor(), font: UIFont.systemFont(ofSize: 12))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
  
        dataArray = ["UITabBarController+Extension", "WKWebView+Extension", "CAGradientLayer+Extension", "UIView+Extension", "UITableViewCell+Extension", "UISlider+Extension", "UICollectionView+Extension", "UINavigationBar+Extension", "CALayer+Extension", "CATextLayer+Extension", "UIAlertController+Extension", "UIApplication+Extension", "UIBarButtonItem+Extension", "UIBezierPath+Extension", "UIButton+Extension", "UIControl+Extension", "UIImage+Extension", "UIImageView+Extension", "UILabel+Extension", "UINavigationController+Extension", "UIColor+Extension", "UIScreen+Extension", "UIScrollView+Extension", "UIStackView+Extension", "UISwitch+Extension", "UITableView+Extension", "UITextField+Extension", "UITextView+Extension", "UIViewController+Extension"]
        finishedDataArray = ["CAGradientLayer+Extension", "WKWebView+Extension", "UITableView+Extension", "UIImage+Extension", "CALayer+Extension", "UIImageView+Extension", "UIButton+Extension", "UILabel+Extension", "UIScreen+Extension", "UISwitch+Extension", "UINavigationController+Extension", "UIScrollView+Extension", "UITextView+Extension", "UITextField+Extension", "UIViewController+Extension", "UIView+Extension", "UITableViewCell+Extension", "UIApplication+Extension", "UIBarButtonItem+Extension", "UIBezierPath+Extension", "UITabBarController+Extension", "UISlider+Extension"]
        initUI()
        // Do any additional setup after loading the view.
    }
    
    /// 创建控件
    private func initUI() {
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension UIKitExtensionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIKitExtensionViewController.UIKitExtensionViewControllerCellIdentifier, for: indexPath) as! BaseViewCell
        let cellName = dataArray[indexPath.row] as! String
        cell.contentLabel.text = "\(indexPath.row + 1)：\(cellName)"
        cell.contentLabel.textColor = finishedDataArray.contains(cellName) ? UIColor.hexStringColor(hexString: "#006400") : UIColor.hexStringColor(hexString: "#333333")
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
