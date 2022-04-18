//
//  TimerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/15.
//

import UIKit

class TimerExtensionViewController: TestBaseViewController {
    fileprivate lazy var timer1: Timer? = {
        let timer = Timer(safeTimerWithTimeInterval: 3, repeats: true) { [weak self] _ in
            print("定时器打印中...................")
        }
        RunLoop.main.add(timer, forMode: .default)
        return timer
    }()

    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["构造器创建定时器", "类方法创建定时器", "C语言的形式创建定时器(创建后立即执行一次)", "销毁定时器", "开", "关"]]
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
// MARK: - 一、基本的扩展
extension TimerExtensionViewController {
    
    // MARK: 1.1、构造器创建定时器
    @objc func test11() {
        timer = Timer(safeTimerWithTimeInterval: 1, repeats: true) { (timer) in
            print("构造器创建定时器", "a--\(timer)")
        }
    }
    
    // MARK: 1.2、类方法创建定时器
    @objc func test12() {
        
        timer = Timer.scheduledSafeTimer(timeInterval: 5, repeats: true) { (timer) in
            print("类方法创建定时器", "b--\(timer)")
        }
    }
    
    // MARK: 1.3、C语言的形式创建定时器(创建后立即执行一次)
    @objc func test13() {
        
        timer = Timer.runThisEvery(timeInterval: 5) {[weak self] (timer1) in
            guard let _ = self, let tr = timer1 else { return }
            print("C语言的形式创建定时器(创建后立即执行一次)", "c--\(tr)")
        }
    }
    
    // MARK: 1.4、销毁定时器
    @objc func test14() {
        
        timer?.invalidate()
    }
    
    // MARK: 1.5、开
    @objc func test15() {
        timer1?.fireDate = NSDate.distantPast
    }
    
    // MARK: 1.6、关
    @objc func test16() {
        
        timer1?.invalidate()
        timer1 = nil
    }
}
