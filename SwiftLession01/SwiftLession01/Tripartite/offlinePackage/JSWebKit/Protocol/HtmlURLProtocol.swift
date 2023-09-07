//
//  HtmlURLProtocol.swift
//  SwiftLession01
//
//  Created by wjx on 2022/7/6.
//

import UIKit
import WebKit

 func HtmlURLProtocol_WKWebView_ContextControllerClass()->AnyObject {
     var cls:AnyObject?
    if (cls == nil) {
        if #available(iOS 8.0, *)  {
            cls = WKWebView().value(forKey: "browsingContextController") as AnyObject
//            [[[WKWebView new] valueForKey:@"browsingContextController"] class];
//            let cls  = type(of: vc) as AnyObject
        }
    }
     return cls!
}
//customSchemes
//SEL HtmlURLProtocol_WKWebView_RegisterSchemeSelector() {
//    return NSSelectorFromString(@"registerSchemeForCustomProtocol:");
//}
//
//SEL HtmlURLProtocol_WKWebView_UnregisterSchemeSelector() {
//    return NSSelectorFromString(@"unregisterSchemeForCustomProtocol:");
//}

let  kKKJSBridgeNSURLProtocolKey: String   = "kKKJSBridgeNSURLProtocolKey1"

class HtmlURLProtocol: URLProtocol {
    
    var dataTask: URLSessionDataTask!
    var sessionDelegateQueue: OperationQueue!
    var response: URLResponse!
    var requestId:String?
    var requestHTTPMethod:String?
    
    override open class func canInit(with request: URLRequest) -> Bool{
        //  如果已经拦截过请求就放行，避免出现死循环
        if (URLProtocol.property(forKey: kKKJSBridgeNSURLProtocolKey, in: request) != nil) {
            return false
        }
     
        
        print("HtmlURLProtocol\( request)")
        return true
    }
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        let newRequest = request as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: kKKJSBridgeNSURLProtocolKey, in: newRequest)
        print("request.URL.absoluteString = \(String(describing: request.url?.absoluteString))")
        if let data = newRequest.httpBody {
            let dataStr = String(data: data, encoding: .utf8)
            print("requst数据: \(String(describing: dataStr))")
        }
        
        return newRequest as URLRequest
    }
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    /// 重写父类开始加载
    override open func startLoading() {
        guard let mutableRequest = (self.request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
            // Handle the error
            return
        }
//        let mutableReqeust = self.request.mutableCopy()
        //[[self request] mutableCopy];
        //给我们处理过的请求设置一个标识符, 防止无限循环,
        URLProtocol.setProperty(true, forKey: kKKJSBridgeNSURLProtocolKey, in: mutableRequest)
//        [URLProtocol setProperty:@YES forKey:kKKJSBridgeNSURLProtocolKey inRequest:mutableReqeust];
        //        print("request.URL.absoluteString = \(String(describing: request.url?.absoluteString))")
        
        // 处理离线资源，或者替换资源的样式
        let configuration = URLSessionConfiguration.default
        
        sessionDelegateQueue = OperationQueue()
        sessionDelegateQueue.maxConcurrentOperationCount = 1
        sessionDelegateQueue.name = "com.pankehong.session.queue"
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: sessionDelegateQueue)
        
        let requestNew = URLRequest(url: URL(string: "http://www.mangobanker.com/static/image/82a5b5f7-8389-49da-8b14-91b33c9882d8.png")!)
        
        dataTask = session.dataTask(with: requestNew)
        dataTask.resume()
        
    }
    
    /// 重写父类的重复加载
    override open func stopLoading() {
        if dataTask != nil {
            dataTask.cancel()
        }
    }
    
    static func HtmlURLProtocolRegisterScheme(scheme:String){
        let vc:AnyObject = HtmlURLProtocol_WKWebView_ContextControllerClass() as AnyObject
        let cls  = type(of: vc) as AnyObject
        let sel = NSSelectorFromString("registerSchemeForCustomProtocol:")
        if (cls.responds(to:sel)) {
//            #pragma clang diagnostic push
//            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            cls.perform(sel,with: scheme, afterDelay: 0.0)
//            [(id)cls performSelector:sel withObject:scheme];
//            #pragma clang diagnostic pop
        }
    }
    static func HtmlURLProtocolUnregisterScheme(scheme:String){
        let cls:AnyObject = HtmlURLProtocol_WKWebView_ContextControllerClass() as AnyObject
        let sel = NSSelectorFromString("unregisterSchemeForCustomProtocol:")
        if (cls.responds(to:sel)) {
//            #pragma clang diagnostic push
//            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            cls.performSelector(inBackground: sel, with: scheme)
//            [(id)cls performSelector:sel withObject:scheme];
//            #pragma clang diagnostic pop
        }
    }
}

extension HtmlURLProtocol: URLSessionDelegate,URLSessionDataDelegate{
    
    // 当服务端返回信息时，这个回调函数会被ULS调用，在这里实现http返回信息的截取
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
        
        if let dataStr  = String(data: data, encoding: .utf8) {
            print("截取返回数据: \(dataStr)")
        }
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
        completionHandler(URLSession.ResponseDisposition.allow)
        self.response = response
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        self.response = response
        client?.urlProtocol(self, wasRedirectedTo: request, redirectResponse: response)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        }else {
            client?.urlProtocolDidFinishLoading(self)
        }
        dataTask = nil
    }
}
