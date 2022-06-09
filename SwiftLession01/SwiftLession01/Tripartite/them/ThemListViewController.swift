//
//  ThemListViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/24.
//

import UIKit

class ThemListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate {
    
    
   
    var isOn : Bool!
    var dataSource:NSMutableArray=[]
    var tableView : UITableView = {
        let tableview = UITableView()
        tableview.jx.register(cellClass: ThemTableViewCell.self)
        return tableview
    }()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.jx.dequeueReusableCell(cellType: ThemTableViewCell.self, cellForRowAt: indexPath)
        cell.model = (self.dataSource[indexPath.row] as? Them)!
        cell.callBackBlock(indexPath: indexPath as NSIndexPath) { str in
            print(str)
            let  alterview =   UIAlertView(title: "提示", message: "切换", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
            self.view.addSubview(alterview)
            
            alterview.show()
        }
        return cell
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int){
        if buttonIndex == 1{
            Themes.switchToNext()
            
        }
       
        print(buttonIndex)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        isOn = false
        
        //navitem search 搜索按钮
            let buttonSearch = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        buttonSearch.setImage(UIImage.init(named: "home_navitem_search"), for: UIControl.State.normal)
        buttonSearch.setTitle("下载", for: UIControl.State.normal)
        buttonSearch.addTarget(self, action: #selector(navigationItemSearchAction), for: UIControl.Event.touchUpInside)
            let barButtonSearch = UIBarButtonItem(customView: buttonSearch)
        self.navigationItem.rightBarButtonItems = [barButtonSearch]
        
        tableView.dataSource = self
        tableView.delegate = self;
        tableView.backgroundColor = .white
        
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 45))
        footView.backgroundColor = UIColor.white
        
        let title = UILabel()
        title.text = "切换Night"
        title.textAlignment = .right
        title.textColor = .black
        footView.addSubview(title)
        let switchView = UISwitch()
       
        
        //开关回调事件
//        switchView.addTarget(self,action: #selector(changNight,:), for: .valueChanged)
//        switchView.backgroundColor = .brown
        switchView.jx.setHandle { (result) in
            guard let weakResult = result else { return }
            print("开关的状态", "\(weakResult)")
            Themes.switchNight(weakResult)
        }
        //设置开关按钮的颜色
        //switchOnOff.onTintColor = UIColor.red
        //自定义设置开关图片无效果
        //switchOnOff.onImage = UIImage(named: "group_icon@2x.png")
        switchView.setOn(false, animated: false)
        //默认为ON打开状态
//        self.view.addSubview(switchOnOff)
        
        footView.addSubview(switchView)
        
        switchView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(35)
            
        }
        title.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.centerY.equalToSuperview()
            make.right.equalTo(switchView.snp_leftMargin)
//            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
        tableView.tableFooterView = footView
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        let colors = ["#061f5c","#c3282b","#097f6f","#b30f31","#0c5cca","#1c326b"]
        let colorsName = ["浦发色","工商色","农业色","中国色","建设色","交通色"]
        for index in 0..<colors.count{
            print(index)
            let them = Them(themName: colorsName[index], colorValue: colors[index])
            self.dataSource.add(them)
        }
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    @objc func changNight(){
        Themes.switchNight(isOn)
        isOn = !isOn
    }
    @objc func navigationItemSearchAction(){
        guard Themes.isBlueThemeExist() else {

//            let title   = "Not Downloaded"
//            let message = "Download the theme right now?"
//
//            if #available(iOS 8.0, *) {
//
//                let alert = UIAlertController(title: title,
//                                              message: message,
//                                              preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(
//                    title: "Cancel",
//                    style: .cancel,
//                    handler: nil)
//                )
//                alert.addAction(UIAlertAction(
//                    title: "Sure",
//                    style: .default,
//                    handler: { [unowned self] _ in
//                        self.downloadStart()
//                    })
//                )
//
//                present(alert, animated: true, completion: nil)
//
//            } else {
//
//                UIAlertView(title: title,
//                            message: message,
//                            delegate: self,
//                            cancelButtonTitle: "Cancel",
//                            otherButtonTitles: "Sure").show()
//
//            }
            downloadStart()
            return
           
        }
        
        Themes.switchTo(theme: .blue)
    }
//    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
//        if buttonIndex == 1 {
//            downloadStart()
//        }
//    }
    fileprivate func downloadStart() {
        let HUD = navigationController!.showHUD("Download Theme...")
        
        Themes.downloadBlueTask() { isSuccess in
            HUD.label.text = isSuccess ? "Successful!" : "Failure!"
            HUD.mode = .text
            HUD.hide(animated: true, afterDelay: 1)
            
            if isSuccess {
                Themes.switchTo(theme: .blue)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
