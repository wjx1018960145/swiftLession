//
//  ToastViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import UIKit

class ToastViewController: UIViewController {

    
    let dataArray = [
        ["中间显示","中间显示+自定义停留时间"],
                          ["顶端显示","顶端显示+自定义停留时间","顶端显示+自定义距顶端距离","顶端显示+自定义距顶端距离+自定义停留时间"],
                          ["底部显示","底部显示+自定义停留时间","底部显示+自定义距底部距离","底部显示+自定义距底部距离+自定义停留时间"]
    ]
    
    lazy var uitableview :UITableView = {
        
        let table = UITableView()
       
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uitableview.delegate = self
        uitableview.dataSource = self
        view.addSubview(uitableview)
        uitableview.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        // Do any additional setup after loading the view.
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
//MARK: - tableView
extension ToastViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataArray[section]
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil
        {
            cell = UITableViewCell(style:.default ,reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = dataArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        //在window上显示
        self.showInWindow(indexPath: indexPath)
        
        //在view上显示
        //self.showInView(indexPath: indexPath)
        
    }
    
    func showInWindow(indexPath:IndexPath){
        let text = dataArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        //MARK: - 中间
        if (indexPath as NSIndexPath).section == 0
        {
            if (indexPath as NSIndexPath).row == 0
            {
                /**
                 * 中间显示
                 */
                JXToast.showCenterWithText(text)

            }
            else if (indexPath as NSIndexPath).row == 1
            {
                /**
                 *  中间显示+自定义停留时间
                 */
                JXToast.showCenterWithText(text, duration:3.0)

            }
        }
            //MARK: - 顶端
        else if (indexPath as NSIndexPath).section == 1
        {
            /**
             *  顶端显示
             */
            if (indexPath as NSIndexPath).row == 0
            {
                JXToast.showTopWithText(text)

            }
            else if (indexPath as NSIndexPath).row == 1
            {
                /**
                 *  顶端显示 + 自定义停留时间
                 */
                JXToast.showTopWithText(text, duration:3.0)

                
            }
            else if (indexPath as NSIndexPath).row == 2
            {
                /**
                 *  顶端显示 + 自定义到顶端距离
                 */
                JXToast.showTopWithText(text, topOffset:150)

            }
            else if (indexPath as NSIndexPath).row == 3
            {
                /**
                 *  顶端显示+自定义到顶端距离+自定义停留时间
                 */
                JXToast.showTopWithText(text, topOffset:150, duration:3.0)
                
            }
        }
            //MARK: - 底部
        else
        {
            /**
             *  底端显示
             */
            if (indexPath as NSIndexPath).row == 0
            {
                JXToast.showBottomWithText(text)
            }
            else if (indexPath as NSIndexPath).row == 1
            {
                /**
                 *  底端显示 + 自定义停留时间
                 */
                JXToast.showBottomWithText(text, duration:3.0)
                
            }
            else if (indexPath as NSIndexPath).row == 2
            {
                /**
                 *  底端显示 + 自定义到顶端距离
                 */
                JXToast.showBottomWithText(text, bottomOffset:150)
            }
            else if (indexPath as NSIndexPath).row == 3
            {
                /**
                 *  底端显示+自定义到顶端距离+自定义停留时间
                 */
                JXToast.showBottomWithText(text, bottomOffset:150, duration:3.0)
                
            }
        }

    }
    func showInView(indexPath: IndexPath) {
        let text = dataArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        //MARK: - 中间
        if (indexPath as NSIndexPath).section == 0
        {
            if (indexPath as NSIndexPath).row == 0
            {
                /**
                 * 中间显示
                 */

                self.view.showJXToastCenterWithText(text)
                
                
            }
            else if (indexPath as NSIndexPath).row == 1
            {
                /**
                 *  中间显示+自定义停留时间
                 */
                self.view.showJXToastCenterWithText(text, duration: 3.0)
                
            }
        }
            //MARK: - 顶端
        else if (indexPath as NSIndexPath).section == 1
        {

            if (indexPath as NSIndexPath).row == 0
            {
                /**
                 *  顶端显示
                 */
                self.view.showJXToastTopWithText(text)
            }
            else if (indexPath as NSIndexPath).row == 1
            {
                /**
                 *  顶端显示 + 自定义停留时间
                 */
                self.view.showJXToastTopWithText(text, duration: 3.0)
                
            }
            else if (indexPath as NSIndexPath).row == 2
            {
                /**
                 *  顶端显示 + 自定义到顶端距离
                 */
                self.view.showJXToastTopWithText(text, topOffset: 150)
            }
            else if (indexPath as NSIndexPath).row == 3
            {
                /**
                 *  顶端显示+自定义到顶端距离+自定义停留时间
                 */
                self.view.showJXToastTopWithText(text, topOffset: 150, duration: 3.0)
                
            }
        }
            //MARK: - 底部
        else
        {
            if (indexPath as NSIndexPath).row == 0
            {
                /**
                 *  底端显示
                 */
                self.view.showJXToastBottomWithText(text)
            }
            else if (indexPath as NSIndexPath).row == 1
            {
                /**
                 *  底端显示 + 自定义停留时间
                 */
                self.view.showJXToastBottomWithText(text, duration:3.0)
                
            }
            else if (indexPath as NSIndexPath).row == 2
            {
                /**
                 *  底端显示 + 自定义到顶端距离
                 */
                self.view.showJXToastBottomWithText(text, bottomOffset: 150)
            }
            else if (indexPath as NSIndexPath).row == 3
            {
                /**
                 *  底端显示+自定义到顶端距离+自定义停留时间
                 */
                self.view.showJXToastBottomWithText(text, bottomOffset: 150, duration: 3.0)
            }
        }
    }
    
}
