//
//  TestVuejsViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/7/2.
//

import UIKit
import WebKit
import Alamofire
import KKJSBridge

class TestVuejsViewController: UIViewController ,KKWebViewDelegate{
    
    
    
    
//    lazy var webView: WKWebView = {
//        let configuration = WKWebViewConfiguration();
//        //设置URLSchemeHandler来处理特定URLScheme的请求，URLSchemeHandler需要实现WKURLSchemeHandler协议
//        //本例中WKWebView将把URLScheme为customScheme的请求交由CustomURLSchemeHandler类的实例处理
//        configuration.setURLSchemeHandler(HTWKURLSchemeHandler(), forURLScheme: "customScheme")
//
//        let webView = WKWebView(frame: UIScreen.main.bounds,configuration: configuration)
//        self.view.addSubview(webView)
////        webView.delegate = self
//        return webView
//    }()
    
    lazy var webView:KKWebView = {
        
        let web = KKWebView()
        web.frame = UIScreen.main.bounds// [UIScreen mainScreen].bounds;
        
        return web
        
    }()
    
   class  func swiftLoad() {
        // do something
        print("swift load")
        NotificationCenter.default.addObserver(forName: UIApplication.didFinishLaunchingNotification, object: nil, queue: nil) { _ in
            
//            NotificationCenter.default.removeObserver(observer)
            
        }
        
//        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//            [self prepareWebView];
//            [[NSNotificationCenter defaultCenter] removeObserver:observer];
//        }];
        
    }
     func prepareWebView(){
        KKWebView.configCustomUA(with: .append, uaString: "KKJSBridge/1.0.0")
        KKWebViewPool.sharedInstance().makeWebViewConfiguration { configuration in
            configuration.allowsInlineMediaPlayback = true;
            configuration.preferences.minimumFontSize = 12;
        }
//        KKWebViewPool.sharedInstance().enqueue(KKWebView)
//        KKJSBridgeConfig.ajaxDelegateManager = self
        
        
    }
//    deinit {
//        HTFilteredProtocol.stopMonitor()
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(self.webView)
//        prepareWebView()
//        HTFilteredProtocol.startMonitor()
        
//       let configuration = WKWebViewConfiguration();
        //设置URLSchemeHandler来处理特定URLScheme的请求，URLSchemeHandler需要实现WKURLSchemeHandler协议
        //本例中WKWebView将把URLScheme为customScheme的请求交由CustomURLSchemeHandler类的实例处理
//        configuration.setURLSchemeHandler(HTWKURLSchemeHandler(), forURLScheme: "customScheme")
//        [configuration setURLSchemeHandler:[CustomURLSchemeHandler new] forURLScheme: @"customScheme"];
        
        
//        webView = KKWebViewPool.sharedInstance().dequeueWebView(with: KKWebView.self, webViewHolder: self)! as! KKWebView
////        [[KKWebViewPool sharedInstance] dequeueWebViewWithClass:KKWebView.class webViewHolder:self];
//        webView.navigationDelegate = self;
        
//        let  _jsBridgeEngine = KKJSBridgeEngine.bridge(for: self.webView)
//
////        [KKJSBridgeEngine bridgeForWebView:self.webView];
//        _jsBridgeEngine.config.isEnableAjaxHook = true
//        _jsBridgeEngine.bridgeReadyCallback = ^(KKJSBridgeEngine * _Nonnull engine) {
//            NSString *event = @"customEvent";
//            NSDictionary *data = @{
//                @"action": @"testAction",
//                @"data": @YES
//            };
//
//            engine.dispatchEvent:event data:data];
//        };
        
//        [self compatibleWebViewJavascriptBridge];
//        [self registerModule];
//        [self loadRequest];
         self.loadRequest()
        
//        if let url = URL(string: "http://122.51.132.117/") {
//            webView.load(URLRequest(url: url))
//        }
//
//        if #available(iOS 11.0, *) {
//            webView.scrollView.contentInsetAdjustmentBehavior = .never
//        }
//        webView.supportURLProtocol()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        if ((self.webView.title == nil)) {
            self.webView.reload()
//            [self.webView reload];
        }
//        HTSDKManager.bridgeMgr().registerJavaScriptHandler(bridge: self.bridge, ids: self)
        //        [[HTSDKManager bridgeMgr] registerJavaScriptHandler:self.jsBridge ids:self];
    }
   func loadRequest() {
      
       let request = URLRequest(url: URL(string: "http://122.51.132.117/")!)
       
//       [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
       self.webView.load(request)
//        [self.webView loadRequest:request];
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

extension TestVuejsViewController: WKUIDelegate,WKNavigationDelegate {
   
}
