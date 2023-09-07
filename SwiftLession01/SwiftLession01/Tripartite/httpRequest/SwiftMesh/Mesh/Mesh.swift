//
//  MeshManager.swift
//  SwiftMesh
//
//  Created by iOS on 2019/12/26.
//  Copyright © 2019 iOS. All rights reserved.
//
import Foundation
import Alamofire

public enum NetworkStatus {
    case noReachable
    case unKnown
    case onWiFi
    case onCellular
}

public typealias RequestConfig = (_ config: MeshConfig) -> Void
public typealias RequestSuccess = (_ config: MeshConfig) -> Void
public typealias RequestFailure = (_ config: MeshConfig) -> Void
public typealias ProgressListener = (_ progress: Progress) -> Void

public class Mesh{
    
    public static var canLogging = false
    
    private static var globalHeaders: HTTPHeaders?
    private static var defaultParameters: [String: Any]?
    private static let networkManager = NetworkReachabilityManager()
    ///调用此方法可以防止网络请求被抓包,请在适当的位置调用,比如 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    public static func disableHttpsProxy(){
        let sessionConfig = URLSessionConfiguration.af.default
        let proxyDict = [AnyHashable : Any]()
        sessionConfig.connectionProxyDictionary = proxyDict // 主要是这一行
    }
    // MARK: 设置全局 headers
    /// 设置全局 headers
    /// - Parameter headers:全局 headers
    public static func setGlobalHeaders(_ headers: HTTPHeaders?) {
        globalHeaders = headers
    }
    
    // MARK: 设置默认参数
    /// 设置默认参数
    /// - Parameter parameters: 默认参数
    public static func setDefaultParameters(_ parameters: [String: Any]?) {
        defaultParameters = parameters
    }
    
    // MARK: 是否联网
    /// 是否联网
    public static var isReachable: Bool {
        get {
            return networkManager?.isReachable ?? false
        }
    }
    // MARK: 是否WiFi
    /// 是否WiFi
    public static var isReachableWiFi: Bool {
        get {
            return networkManager?.isReachableOnEthernetOrWiFi ?? false
        }
    }
    // MARK: 是否WWAN
    /// 是否运营商网络
    public static var isReachableCellular: Bool {
        get {
            return networkManager?.isReachableOnCellular ?? false
        }
    }
    
    ///私有方法
    private static func changeConfig(_ config: MeshConfig){
        ///设置默认参数
        var param = defaultParameters ?? [:]
        param.merge(config.parameters ?? [:]) { (_, new) in new}
        config.parameters = param
        ///设置默认header
        guard let headers = globalHeaders else {
            return
        }
        
        if let _ = config.addHeads{
            
        }else{
            config.addHeads = []
        }
        
        headers.forEach {
            config.addHeads?.update($0)
            
        }
    }
    
    // MARK:- 打印输出
    private static func meshLog(_ config: MeshConfig,
                                response: AFDataResponse<Data?>?) {
#if DEBUG
        if canLogging{
            print("\n\n<><><><><>-「Alamofire Log」-<><><><><>\n\n>>>>>>>>>>>>>>>接口API:>>>>>>>>>>>>>>>\n\n\(String(describing: config.URLString))\n\n>>>>>>>>>>>>>>>参数parameters:>>>>>>>>>>>>>>>\n\n\(String(describing: config.parameters))\n\n>>>>>>>>>>>>>>>头headers:>>>>>>>>>>>>>>>\n\n\(String(describing: config.addHeads))\n\n>>>>>>>>>>>>>>>报文response:>>>>>>>>>>>>>>>\n\n\(String(describing: response))\n\n<><><><><>-「Alamofire END」-<><><><><>\n\n")
        }
#endif
    }
}

// MARK: 统一发起请求 支持 GET POST PUT DELETE
extension Mesh{
    
    ///适配器闭包发起请求(回调适配器) 支持 GET POST PUT DELETE
    /// - Parameters:
    ///   - configBlock: 请求适配器
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 DataRequest
    @discardableResult
    public static func requestWithConfig(configBlock: RequestConfig?,
                                         success: RequestSuccess?,
                                         failure: RequestFailure?) -> DataRequest? {
        guard let block = configBlock else {
            return nil
        }
        let config = MeshConfig.init()
        block(config)
        
        return sendRequest(config: config, success: success, failure: failure)
    }
    
    /// 适配器发起请求 支持 GET POST PUT DELETE
    /// - Parameters:
    ///   - config: 实例好的适配器
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 DataRequest
    @discardableResult
    public static func sendRequest(config: MeshConfig,
                                   success: RequestSuccess?,
                                   failure: RequestFailure?)  -> DataRequest? {
        
        guard let url = config.URLString else {
            return nil
        }
        ///设置默认参数 header
        changeConfig(config)

        return AF.request(url,
                          method: config.requestMethod,
                          parameters: config.parameters,
                          encoding: config.requestEncoding,
                          headers: config.addHeads,
                          interceptor: config.retry,
                          requestModifier: { request in request.timeoutInterval = config.timeout}
        ).response { (response) in
            config.response = response
////            ///打印输出
            meshLog(config, response: response)
////
            guard let _ = response.data else {
                config.code = RequestCode.errorResponse.rawValue
                failure?(config)
                return
            }
            switch response.result {
            case .success:
                //可添加统一解析
                config.code = RequestCode.success.rawValue
                success?(config)
            case .failure:
                config.code = RequestCode.errorResult.rawValue
                failure?(config)
            }
        }
        
    }
    
}

// MARK: 下载请求
extension Mesh{
    
    /// 适配器闭包发起下载请求
    /// - Parameters:
    ///   - configBlock: 适配器闭包
    ///   - progress: 下载进度
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 DownloadRequest
    @discardableResult
    public static func downLoadWithConfig(configBlock: RequestConfig?,
                                          progress: ProgressListener?,
                                          success: RequestSuccess?,
                                          failure: RequestFailure?) -> DownloadRequest? {
        
        guard let block = configBlock else {
            return nil
        }
        let config = MeshConfig.init()
        block(config)
        
        changeConfig(config)
        
        switch config.downloadType {
        case .resume:
            return sendDownloadResume(config: config, progress: progress, success: success, failure: failure)
        default:
            return sendDownload(config: config, progress: progress, success: success, failure: failure)
        }
        
    }
    
    /// 通过实例适配器发起下载请求
    /// - Parameters:
    ///   - config: 实例适配器
    ///   - progress: 下载进度
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 DownloadRequest
    @discardableResult
    public static func sendDownload(config: MeshConfig,
                                    progress: ProgressListener?,
                                    success: RequestSuccess?,
                                    failure: RequestFailure?) -> DownloadRequest? {
        
        guard let url = config.URLString else {
            return nil
        }
        
    
        
        return AF.download(url,
                           method: config.requestMethod,
                           parameters: config.parameters,
                           encoding: config.requestEncoding,
                           headers: config.addHeads,
                           interceptor: config.retry,
                           requestModifier: { request in request.timeoutInterval = config.timeout},
                           to: config.destination
                           
        ).downloadProgress(closure: { (progr) in
            
            progress?(progr)
            
        }) .responseData { (responseData) in
//            var path = FileUtils.getPackageRootPath()+"/"
//            path.append((responseData.response?.suggestedFilename)!)
            config.fileURL =  responseData.fileURL
            config.resumeData = responseData.resumeData
            
            
//            return temporaryURL
            switch responseData.result {
            case .success:
                config.mssage = "下载完成"
                var path = FileUtils.getPackageRootPath()+"/"
                path.append((responseData.response?.suggestedFilename)!)
                config.fileURL = URL(fileURLWithPath: path)
                config.code = RequestCode.success.rawValue
               
                config.fileUrl = path
                success?(config)
            case .failure:
                config.mssage = "下载失败"
                config.code = RequestCode.errorResult.rawValue
                failure?(config)
            }
        }
    }
    
    /// 通过实例适配器发起继续下载请求
    /// - Parameters:
    ///   - config: 实例适配器
    ///   - progress: 下载进度
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 DownloadRequest
    @discardableResult
    public static func sendDownloadResume(config: MeshConfig,
                                          progress: ProgressListener?,
                                          success: RequestSuccess?,
                                          failure: RequestFailure?) -> DownloadRequest? {
        
        guard let resumeData = config.resumeData else {
            return nil
        }
        
        return AF.download(resumingWith: resumeData,
                           interceptor: config.retry,
                           to: config.destination
        ).downloadProgress(closure: { (progr) in
            
            progress?(progr)
            
        }).responseData { (responseData) in
            
            config.fileURL = responseData.fileURL
            config.resumeData = responseData.resumeData
            
            switch responseData.result {
            case .success:
                config.mssage = "下载完成"
                config.code = RequestCode.success.rawValue
                success?(config)
            case .failure:
                config.mssage = "下载失败"
                config.code = RequestCode.errorResult.rawValue
                failure?(config)
            }
            
        }
        
    }
}

// MARK: 上传请求
extension Mesh{
    
    /// 适配器闭包发起上传请求--支持表单通过适配器方法创建表单
    /// - Parameters:
    ///   - configBlock: 适配器闭包
    ///   - progress: 上传进度
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 UploadRequest
    @discardableResult
    public static func uploadWithConfig(configBlock: RequestConfig?,
                                        progress: ProgressListener?,
                                        success: RequestSuccess?,
                                        failure: RequestFailure?) -> UploadRequest? {
        
        guard let block = configBlock else {
            return nil
        }
        
        let config = MeshConfig.init()
        block(config)
        changeConfig(config)
        
        switch config.uploadType {
        case .multipart:
            return sendUploadMultipart(config: config, progress: progress, success: success, failure: failure)
        default:
            return sendUpload(config: config, progress: progress, success: success, failure: failure)
        }
    }
    
    /// 适配器发起上传请求--支持文件，流
    /// - Parameters:
    ///   - config: 适配器
    ///   - progress: 上传进度
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 UploadRequest
    @discardableResult
    public static func sendUpload(config: MeshConfig,
                                  progress: ProgressListener?,
                                  success: RequestSuccess?,
                                  failure: RequestFailure?) -> UploadRequest? {
        
        guard let url = config.URLString else {
            return nil
        }
        
        let uploadRequest : UploadRequest
        
        switch config.uploadType {
        case .file:
            guard let fileURL = config.fileURL else {
                return nil
            }
            uploadRequest = AF.upload(fileURL,
                                      to: url,
                                      method: config.requestMethod,
                                      headers: config.addHeads,
                                      interceptor: config.retry,
                                      requestModifier: { request in request.timeoutInterval = config.timeout})
            
        case .stream:
            guard let stream = config.stream else {
                return nil
            }
            uploadRequest = AF.upload(stream,
                                      to: url,
                                      method: config.requestMethod,
                                      headers: config.addHeads,
                                      interceptor: config.retry,
                                      requestModifier: { request in request.timeoutInterval = config.timeout})
            
        default:
            guard let fileData = config.fileData else {
                return nil
            }
            uploadRequest = AF.upload(fileData,
                                      to: url,
                                      method: config.requestMethod,
                                      headers: config.addHeads,
                                      interceptor: config.retry,
                                      requestModifier: { request in request.timeoutInterval = config.timeout})
            
        }
        
        uploadRequest.uploadProgress { (progr) in
            progress?(progr)
        }
        
        uploadRequest.responseData { (response) in
            switch response.result {
            case .success:
                config.code = RequestCode.success.rawValue
                config.mssage = "上传成功"
                success?(config)
            case .failure:
                config.code = RequestCode.errorResult.rawValue
                config.mssage = "上传失败"
                failure?(config)
            }
        }
        return uploadRequest
    }
    
    /// 适配器发起上传请求--表单 根据适配器中相应方法创建表单
    /// - Parameters:
    ///   - config: 适配器
    ///   - progress: 上传进度
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 返回请求 UploadRequest
    @discardableResult
    public static func sendUploadMultipart(config: MeshConfig,
                                           progress: ProgressListener?,
                                           success: RequestSuccess?,
                                           failure: RequestFailure?) -> UploadRequest? {
        
        guard let url = config.URLString, let uploadDatas = config.uploadDatas  else {
            return nil
        }
        
        return AF.upload(multipartFormData: { (multi) in
            
            uploadDatas.forEach { (updataConfig) in
                if let fileData = updataConfig.fileData{
                    ///Data数据表单,图片等类型
                    if let fileName = updataConfig.fileName,
                       let mimeType =  updataConfig.mimeType{
                        multi.append(fileData, withName: updataConfig.name ?? "", fileName: fileName, mimeType: mimeType)
                    }else{
                        multi.append(fileData, withName: updataConfig.name ?? "")
                    }
                }else if let fileURL = updataConfig.fileURL{
                    ///文件类型表单,从 URL 路径获取文件上传
                    if let fileName = updataConfig.fileName,
                       let mimeType =  updataConfig.mimeType{
                        multi.append(fileURL, withName: updataConfig.name ?? "", fileName: fileName, mimeType: mimeType)
                    }else{
                        multi.append(fileURL, withName: updataConfig.name ?? "")
                    }
                }
            }
            
        },
                         to: url,
                         method: config.requestMethod,
                         headers: config.addHeads,
                         interceptor: config.retry,
                         requestModifier: { request in request.timeoutInterval = config.timeout}
        ).response { (response) in
            
            switch response.result{
            case .success( _):
                config.code = RequestCode.success.rawValue
                config.mssage = "上传成功"
                success?(config)
                //                debugPrint("****:\(response) ****")
            case .failure( _):
                config.code = RequestCode.errorResult.rawValue
                config.mssage = "上传失败"
                failure?(config)
                //                debugPrint(error)
            }
            
        }
    }
}

// MARK: 取消请求
extension Mesh{
    /// 取消特定请求
    /// - Parameter url: 请求的地址,内部判断是否包含,请添加详细的 path
    public static func cancelRequest(_ url :String){
        
        Session.default.session.getAllTasks { (tasks) in
            tasks.forEach { (task) in
                if let _ : Bool = task.currentRequest?.url?.absoluteString.contains(url){
                    task.cancel()
                }
            }
        }
    }
    
    /// 清空所有请求
    public static func cancelAllRequest(){
        
        Session.default.session.getAllTasks { (tasks) in
            tasks.forEach { (task) in
                task.cancel()
            }
        }
    }
    
}


class CacheMesh {
    /// 缓存过期时间
    ///
    /// - Parameter expiry: 参考 DaisyExpiry
    public func cacheExpiryConfig(expiry: CacheExpiry) {
        CacheManager.default.expiryConfiguration(expiry: expiry)
    }
    
    /// 超时时间
    ///
    /// - Parameter timeInterval: 超时时间
   static public func timeoutIntervalForRequest(_ timeInterval: TimeInterval) {
        RequestManager.default.timeoutIntervalForRequest(timeInterval)
    }
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - url: url
    ///   - method: .get .post ...
    ///   - params: 参数字典
    ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
    ///   - encoding: 编码方式
    ///   - headers: 请求头
    /// - Returns:
    @discardableResult
   static public func request(_ url: String,
                        method: HTTPMethod = .get,
                        params: Parameters? = nil,
                        dynamicParams: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil) -> RequestTaskManager
    {
        return RequestManager.default.request(url, method: method, params: params, dynamicParams: dynamicParams, encoding: encoding, headers: headers)
    }
    
    /// urlRequest请求
    ///
    /// - Parameters:
    ///   - urlRequest: 自定义URLRequest
    ///   - params: URLRequest中需要的参数，作为key区分缓存
    ///   - dynamicParams: 变化的参数，例如 时间戳, `token` 等, 用来过滤`params`中的动态参数
    /// - Returns: RequestTaskManager?
    @discardableResult
    public func request(urlRequest: URLRequestConvertible,
                        params: Parameters,
                        dynamicParams: Parameters? = nil) -> RequestTaskManager?
    {
        return RequestManager.default.request(urlRequest: urlRequest, params: params, dynamicParams: dynamicParams)
    }
    
    /// 取消请求
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: 参数
    ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
    public func cancel(_ url: String, params: Parameters? = nil, dynamicParams: Parameters? = nil) {
        RequestManager.default.cancel(url, params: params, dynamicParams: dynamicParams)
    }
    
    /// 清除所有缓存
    ///
    /// - Parameter completion: 完成回调
    public func removeAllCache(completion: @escaping (Bool) -> ()) {
        RequestManager.default.removeAllCache(completion: completion)
    }

    /// 根据url和params清除缓存
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: 参数
    ///   - dynamicParams: 变化的参数，例如 时间戳-token 等
    ///   - completion: 完成回调
    public func removeObjectCache(_ url: String,
                                  params: [String: Any]? = nil,
                                  dynamicParams: Parameters? = nil,
                                  completion: @escaping (Bool) -> ())
    {
        RequestManager.default.removeObjectCache(url, params: params, dynamicParams: dynamicParams, completion: completion)
    }
}
