//
//  HTH5ViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/28.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge
//适配iPhone X
let kNavBarHeight = 44
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
//TabBarHeight
let kTabBarHeight = kStatusBarHeight > 20 ? 83 : 49
//NavBarHeight
let kTopHeight =  Float(kNavBarHeight) + Float(kStatusBarHeight)

class HTH5ViewController: UIViewController, WKNavigationDelegate {

    
    @objc  var params:NSDictionary=[:]
    
    fileprivate var webView: WKWebView!
    
    fileprivate var progressView: UIProgressView!
    
    public var jsBridge:WKWebViewJavascriptBridge!
    
    override func viewWillAppear(_ animated: Bool) {
        HTSDKManager.bridgeMgr().registerJavaScriptHandler(bridge: self.jsBridge!, ids: self)
//        [[HTSDKManager bridgeMgr] registerJavaScriptHandler:self.jsBridge ids:self];
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if params["nav"] != nil {
            self.initNaviItem()
        }
        
        
        self.initWkWebView()
        self.initProgressView()
        
        
        
        // Do any additional setup after loading the view.
    }
    private func initNaviItem(){
        
        let backImage = HTWebAppearance.sharedAppearance.backItemImage;
        
        let backItem = UIBarButtonItem.init(image: backImage, style: .plain, target: self, action: #selector(naviBackButtonClicked))
        
        // [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(naviBackButtonClicked)];
        
        let closeImage = HTWebAppearance.sharedAppearance.closeItemImage;
        
        let closeItem = UIBarButtonItem.init(image: closeImage, style: .plain, target: self, action: #selector(closeButtonClicked))
        // [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonClicked)];
        
        
        self.navigationItem.leftBarButtonItems = [backItem,closeItem];
    }
    func initWkWebView() {
        
        self.webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView!)
        
        self.webView.navigationDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
        //监听进度
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        self.jsBridge = WKWebViewJavascriptBridge.init(webView: webView)
        
        
//        weak var weakSelf = self
        self.loadingURL(urltring: params["url"] as! String)
        //空数据界面
//        let emptyV:HDEmptyView = HDEmptyView.emptyActionViewWithImageStr(imageStr: "net_error_tip", titleStr: "暂无数据", detailStr: "请检查网络连接或稍后再试", btnTitleStr: "重新加载") {
//            print("点击刷新")
//            weakSelf!.loadingURL(urltring: "http://news.baidu.com/")
//        }
//
//        emptyV.contentViewY = -100
//        emptyV.actionBtnBackGroundColor = .lightGray
//        self.webView.scrollView.ly_emptyView = emptyV
//
//        self.webView.scrollView.ly_emptyView?.tapContentViewBlock = {
//            weakSelf!.loadingURL(urltring: "http://news.baidu.com/")
//        }
    }
    //MARK: ---------- 初始化progressView ----------
    func initProgressView() {
        
        self.progressView = UIProgressView(progressViewStyle: UIProgressView.Style.bar)
        self.progressView.frame = CGRect(x: 0, y:CGFloat(kTopHeight) , width: self.view.bounds.width, height: 5.0)
        self.view.addSubview(self.progressView)
        self.progressView.isHidden = true
        self.progressView.trackTintColor = UIColor.clear
        self.progressView.progressTintColor = UIColor.blue
    }
    
    func loadingURL(urltring: String) {
        let urlstr =  URL(string: urltring)
        
        
        
        self.webView!.load(URLRequest(url: urlstr!))
       
    }
    
    @objc func naviBackButtonClicked() {
        if self.webView.canGoBack {
            self.webView.goBack()
        } else {
            //            [self closeButtonClicked];
        }
    }
    @objc func closeButtonClicked(){
        
        self.view.resignFirstResponder()
        let nav = self.navigationController
        let vccount = self.navigationController!.viewControllers.count
        if (nav != nil
            &&  vccount > 1) {
            self.navigationController!.popViewController(animated: true)
            
        } else {
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    //MARK: ----  observeValue ---
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if object as? NSObject == self.webView {
                print(self.webView.estimatedProgress)
                if self.webView.estimatedProgress > 0.2 {
                    self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
                }
            }
            if self.webView.estimatedProgress >= 1.0 {
                self.progressView.setProgress(0.99999, animated: true)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.autoreverse, animations: {
                    self.progressView.isHidden = true
                    self.progressView.setProgress(0.0, animated: false)
                }, completion: nil)
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //MARK: ---- WKNavigationDelegate ----
    //开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.progressView.isHidden = false
        self.progressView.setProgress(0.2, animated: true)
        print("_____开始加载_____")
    }
    
    //完成加载
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("_____完成加载_____")
//        self.webView.scrollView.ly_hideEmptyView()
        
    }
    //加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("_____加载失败_____")
//        self.webView.scrollView.ly_showEmptyView()
        self.progressView.isHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
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
