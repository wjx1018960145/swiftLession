//
//  TestJSCallNativeViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge

class TestJSCallNativeViewController: UIViewController {

    let webView = WKWebView(frame: CGRect(), configuration: WKWebViewConfiguration())
//    var bridge: WKWebViewJavascriptBridge!
    let callbackBtn = UIButton(type: .custom)
    let reloadBtn = UIButton(type: .custom)
    var bridge: WKWebViewJavascriptBridge!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        webView.navigationDelegate = self
        view.addSubview(webView)
        callbackBtn.backgroundColor = UIColor(red: 255.0/255, green: 166.0/255, blue: 124.0/255, alpha: 1.0)
        callbackBtn.setTitle("Call Handler", for: .normal)
        callbackBtn.addTarget(self, action: #selector(callHandler), for: .touchUpInside)
        view.insertSubview(callbackBtn, aboveSubview: webView)
        callbackBtn.frame = CGRect(x: 10, y: UIScreen.main.bounds.size.height - 80, width: UIScreen.main.bounds.size.width * 0.4, height: 35)
        bridge = WKWebViewJavascriptBridge(webView: webView)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDemoPage()
        HTSDKManager.bridgeMgr().registerJavaScriptHandler(bridge: self.bridge, ids: self)
//        [[HTSDKManager bridgeMgr] registerJavaScriptHandler:self.jsBridge ids:self];
    }
    
    @objc func callHandler() {
        let data = ["greetingFromiOS": "Hi there, JS!"]
        bridge.call(handlerName: "testJavascriptHandler", data: data) { (response) in
            print("testJavascriptHandler responded: \(String(describing: response))")
        }
    }
    
    func loadDemoPage() {
        enum LoadDemoPageError: Error {
            case nilPath
        }
        
        do {
            guard let pagePath = Bundle.main.path(forResource: "Demo", ofType: "html") else {
                throw LoadDemoPageError.nilPath
            }
            let pageHtml = try String(contentsOfFile: pagePath, encoding: .utf8)
            let baseURL = URL(fileURLWithPath: pagePath)
            webView.loadHTMLString(pageHtml, baseURL: baseURL)
        } catch LoadDemoPageError.nilPath {
            print(print("webView loadDemoPage error: pagePath is nil"))
        } catch let error {
            print("webView loadDemoPage error: \(error)")
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
extension TestJSCallNativeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webViewDidStartLoad")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webViewDidFinishLoad")
    }
}
