//
//  LogViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import UIKit

/**
 控制台展示(Console Log)，兼顾NSLog的特性

  日志文件存储(File Log)，配置文件日志的高级属性

  用户自定义日志,继承JJLogObject

  全局开关日志

  只显示指定文件日志

  自定义过滤

  自定义日志格式，任意组合, 内置样式供开发者选择，内置了ANSIColor格式

  支持多平台iOS,MacOS,Windows和Linux
 
 一般推荐在程序的入口处，进行初始化，默认配置了控制台和文件日志，只需要配置日志级别即可，以下是示例:
 
 JXLogger.setup(level: .verbose)

 JXLogger.format = JXSwiftLog.simpleFormat
//        JJLogger.onlyLogFile("ViewController")

 JXLogger.verbose("verbose")
 JXLogger.debug("debug")
 JXLogger.info("info")
 JXLogger.warning("warn")
 JXLogger.error("error")
 
 高级使用
 let file = JXFileOutput(delegate: JXLogger, identifier: "file")
 if file != nil {
     file?.targetMaxFileSize = 1000 * 1024
     file?.targetMaxTimeInterval = 600
     file?.targetMaxLogFiles = 20
     file?.formatters = [JXFormatterLogANSIColor()]
     JXLogger.addLogOutput(file!)
 }
 #if DEBUG
 let console = JXConsoleOutput(identifier: "console")
 console.isUseNSLog = false
 JXLogger.addLogOutput(console)
 #endif
 JXLogger.startLogInfo()
 
 JJSwiftLog支持自定义格式日志，以下表格是简写字母对应关系:
 简写    描述
 %M    日志文本
 %L    日志级别
 %l    行数
 %F    文件名，不带后缀
 %f    函数名
 %D    日期(目前仅支持yyyy-MM-dd HH:mm:ss.SSSZ)
 %T    线程，如果主线程显示main，子线程显示地址或者QueueLabel
 %t    显示HH:mm:ss格式
 %d    显示yyyy-MM-dd格式
 %N    文件名，带后缀

 
 */

class LogViewController: UIViewController {

    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("发送到后台", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(sendSerevr), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        JXLogger.setup(level: .verbose)
        
        JXLogger.format = JXSwiftLog.simpleFormat
//        JJLogger.onlyLogFile("ViewController")

        JXLogger.verbose("verbose")
        JXLogger.debug("debug")
        JXLogger.info("info")
        JXLogger.warning("warn")
        JXLogger.error("error")

        JXLogger.verbose(123)
        JXLogger.debug(1.2)
        JXLogger.info(Date())
        JXLogger.warning(["1", "2"])
        
        JXLogger.enable = true
        
        setupLog()
        setupVendor(parameter: "Show the error log")
        JXLogger.verbose("Start the record")
        JXLogger.debug("Debug the world")
        JXLogger.info("Show log info")
        JXLogger.warning("Build warning")
        JXLogger.error("can’t fetch user info without user id")
        
        let button = UIButton(type: .custom)
        button.setTitle("Add log", for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.frame = CGRect(x: 0, y: 200, width: 200, height: 50)
        self.view.addSubview(button)
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
        // Do any additional setup after loading the view.
    }
    //发送到后台
    @objc func sendSerevr(){
        let sentry = JXSentryOutput(sentryKey: "key", sentryURL: URL(string: "http://www.exmaple.com/api/5/store/")!, delegate: JXLogger)
        sentry.completion = { result in
            
        }
        sentry.failure = { error in
            
        }
        JXLogger.addLogOutput(sentry)
    }
    //自定义日志文件路径 大小
    func advanceUsage() {
        let file = JXFileOutput(delegate: JXLogger, identifier: "file")
        if file != nil {
            file?.targetMaxFileSize = 1000 * 1024
            file?.targetMaxTimeInterval = 600
            file?.targetMaxLogFiles = 20
            file?.formatters = [JXFormatterLogANSIColor()]
            JXLogger.addLogOutput(file!)
        }
        #if DEBUG
        let console = JXConsoleOutput(identifier: "console")
        console.isUseNSLog = false
        JXLogger.addLogOutput(console)
        #endif
        JXLogger.startLogInfo()
    }
    @objc func clickButton() {
        JXLogger.verbose("Start the record")
        JXLogger.debug("Debug the world")
        JXLogger.info("Show log info")
        JXLogger.warning("Build warning")
        JXLogger.error("can’t fetch user info without user id")
    }
    func setupLog() {

    }
    
    func setupVendor(parameter: String) {
        JXLogger.verbose("method set the parameter")
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
