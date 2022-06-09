//
//  BaseVC.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/23.
//

import UIKit

class BaseVC: UIViewController {
    ///是否隐藏导航栏，默认false
        open var yl_naviBarIsHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    ///push下一个或 pop 上一个，是否隐藏导航栏
        private func yl_pushOrPopIsHidden() -> Bool {
            if let viewcontrollers = navigationController?.viewControllers {
                if let vc = viewcontrollers[viewcontrollers.count - 1] as? BaseVC {
                    return vc.yl_naviBarIsHidden
                }
                return false
            }
            return false
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if yl_naviBarIsHidden {
                navigationController?.setNavigationBarHidden(true, animated: animated)
            }
        }
        open override func viewWillDisappear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if yl_naviBarIsHidden {
                if yl_pushOrPopIsHidden() == false {
                    navigationController?.setNavigationBarHidden(false, animated: animated)
                }
            }
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
