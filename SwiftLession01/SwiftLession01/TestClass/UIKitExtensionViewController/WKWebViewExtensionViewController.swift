//
//  WKWebViewExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit
import WebKit
class WKWebViewExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["WKWebViewConfiguration默认配置", "js注入", "js交互", "调整字体的比例", "加载网页", "获取WKWebView视图"]]
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
extension WKWebViewExtensionViewController {
    
    // MARK: 1.6、获取WKWebView视图
    @objc func test16() {
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: jx_kScreenH - jx_kNavFrameH))
        wkWebView.navigationDelegate = self
        let rul = URL(string:("https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_9743234139645720408%22%7D&n_type=0&p_from=1"))
        let request = URLRequest(url: rul!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            wkWebView.jx.snapShotContentScroll { image in
                guard let weakImage = image else {
                    return
                }
                print("开始保存图片------")
                weakImage.jx.savePhotosImageToAlbum { result, error in
                    if result {
                        print("保存图片成功------")
                    }
                    JXAsyncs.asyncDelay(2) {
                    } _: {
                        wkWebView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    // MARK: 1.5、加载网页
    @objc func test15() {
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: jx_kScreenH - jx_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            print("JS代码调用------------")
            wkWebView.jx.loadUrl("https://www.baidu.com")
            JXAsyncs.asyncDelay(10) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.4、调整字体的比例
    @objc func test14() {
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: jx_kScreenH - jx_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            print("JS代码调用------------")
            wkWebView.jx.javaScriptFromTextSizeRatio(200)
            JXAsyncs.asyncDelay(5) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.3、js交互
    @objc func test13() {
        let jsCode = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(200)%'"
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: jx_kScreenH - jx_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            print("JS代码调用------------")
            wkWebView.jx.evaluateJsCode(jsCode) { response, error in
                
            }
            JXAsyncs.asyncDelay(5) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.2、js注入
    @objc func test12() {
        
        // 以下代码适配大小
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: jx_kScreenH - jx_kNavFrameH))
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://www.jianshu.com/p/13b77f3e52bd"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            print("JS代码调用------------")
            wkWebView.jx.addUserScript(jScript)
            JXAsyncs.asyncDelay(5) {
            } _: {
                wkWebView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.1、WKWebViewConfiguration 默认配置
    @objc func test11() {
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.selectionGranularity = .dynamic
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        configuration.preferences.javaScriptEnabled = true
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: jx_kScreenW, height: jx_kScreenH - jx_kNavFrameH), configuration: configuration)
        wkWebView.navigationDelegate = self
        let url = URL(string:("https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_9743234139645720408%22%7D&n_type=0&p_from=1"))
        let request = URLRequest(url: url!)
        wkWebView.load(request)
        self.view.addSubview(wkWebView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            wkWebView.removeFromSuperview()
        }
    }
}

extension WKWebViewExtensionViewController: WKNavigationDelegate {
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("1 页面开始加载时调用")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("2 当内容开始返回时调用")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("3 页面加载完成之后调用")
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint("4 页面加载失败时调用")
    }
    
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("5 接收到服务器跳转请求之后调用")
    }
    
    // 在收到响应后，决定是否跳转 -> 默认允许
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        debugPrint("6 在收到响应后，决定是否跳转 -> 默认允许")
        // 允许跳转
        decisionHandler(.allow)
        // 不允许跳转
        // decisionHandler(.cancel)
    }
}

extension WKWebViewExtensionViewController: WKScriptMessageHandler {
    //用于与JS交互
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "和web那边一样的方法名") {
            debugPrint("JavaScript is sending a message \(message.body)")
        }
    }
}
