//
//  MeshRequest.swift
//  SwiftMesh
//
//  Created by iOS on 2019/12/27.
//  Copyright © 2019 iOS. All rights reserved.
//
import Foundation
import Alamofire

/// 泛型封装普通请求,支持解析后直接返回泛型model
public class MeshRequest{
 
    ///
    public typealias requestCallBack<T: Codable> = (_ data: T?) -> Void
    
    
    /// get请求
    /// - Parameters:
    ///   - url: 请求地址
    ///   - parameters: 参数
    ///   - modelType: model类型
    ///   - modelKeyPath: model解析路径
    ///   - callBack: 返回model实例
    /// - Returns: 请求
    @discardableResult
    public static func get<T: Codable>(_ url: String,
                                       parameters: [String: Any] = [:],
                                       modelType: T.Type,
                                       modelKeyPath: String? = nil,
                                       callBack: requestCallBack<T>?) -> DataRequest? {
        return request(url,
                       parameters: parameters,
                       modelType: modelType,
                       modelKeyPath: modelKeyPath,
                       callBack: callBack)
    }
    
    /// post请求
    /// - Parameters:
    ///   - url: 请求地址
    ///   - parameters: 参数
    ///   - modelType: model类型
    ///   - modelKeyPath: model解析路径
    ///   - callBack: 返回model实例
    /// - Returns: 请求
    @discardableResult
    public static func post<T: Codable>(_ url: String,
                                        parameters: [String: Any] = [:],
                                        modelType: T.Type,
                                        modelKeyPath: String? = nil,
                                        callBack: requestCallBack<T>?) -> DataRequest? {
        return request(url,
                       requestMethod: .post,
                       parameters: parameters,
                       modelType: modelType,
                       modelKeyPath: modelKeyPath,
                       callBack: callBack)
    }
    
    static private func request<T: Codable>(_ url: String,
                                            requestMethod : HTTPMethod = .get,
                                            parameters: [String: Any] = [:],
                                            modelType: T.Type,
                                            modelKeyPath: String? = nil,
                                            callBack: requestCallBack<T>?) -> DataRequest? {
        return request(configBlock: { config in
            config.requestMethod = requestMethod
            config.URLString = url
            config.parameters = parameters
        }, modelType: modelType, modelKeyPath: modelKeyPath, callBack: callBack)
    }
    
    @discardableResult
    static public func request<T: Codable>(configBlock: RequestConfig?,
                                           modelType: T.Type,
                                           modelKeyPath: String? = nil,
                                           callBack: requestCallBack<T>?) -> DataRequest? {
        
        return Mesh.requestWithConfig(configBlock: configBlock) { config in
            if let keypath = modelKeyPath, keypath.count > 0 {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let data = config.response?.data, let model = try? decoder.decode(modelType.self, from: data, keyPath: keypath) else {
                    callBack?(nil)
                    return
                }
                
                callBack?(model)
                
            }else{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let data = config.response?.data, let model = try? decoder.decode(modelType.self, from: data) else {
                    callBack?(nil)
                    return
                }
                
                callBack?(model)
            }
        } failure: { config in
            callBack?(nil)
        }
    }
    
    
    
}

class RequestManager {
    
    static let `default` = RequestManager()
    private var requestTasks = [String: RequestTaskManager]()
    private var timeoutIntervalForRequest: TimeInterval? /// 超时时间
    
    func timeoutIntervalForRequest(_ timeInterval: TimeInterval) {
        timeoutIntervalForRequest = timeInterval
        RequestManager.default.timeoutIntervalForRequest = timeoutIntervalForRequest
    }

    ///
    func request(
        
        _ url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        dynamicParams: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
    -> RequestTaskManager
    {
        let key = cacheKey(url, params, dynamicParams)
        var taskManager: RequestTaskManager?
        if requestTasks[key] == nil {
            if timeoutIntervalForRequest != nil {
                taskManager = RequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
            } else {
                taskManager = RequestTaskManager()
            }
            requestTasks[key] = taskManager
        } else {
            taskManager = requestTasks[key]
        }
        
        taskManager?.completionClosure = {
            self.requestTasks.removeValue(forKey: key)
        }
        var tempParam = params == nil ? [:] : params!
        let dynamicTempParam = dynamicParams == nil ? [:] : dynamicParams!
        dynamicTempParam.forEach { arg in
            tempParam[arg.key] = arg.value
        }
        taskManager?.request(url, method: method, params: tempParam, cacheKey: key, encoding: encoding, headers: headers)
        return taskManager!
    }
    
    
    func request(
        urlRequest: URLRequestConvertible,
        params: Parameters,
        dynamicParams: Parameters? = nil)
    -> RequestTaskManager?
    {
        if let urlStr = urlRequest.urlRequest?.url?.absoluteString {
            let components = urlStr.components(separatedBy: "?")
            if components.count > 0 {
                let key = cacheKey(components.first!, params, dynamicParams)
                var taskManager: RequestTaskManager?
                if requestTasks[key] == nil {
                    if timeoutIntervalForRequest != nil {
                        taskManager = RequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
                    } else {
                        taskManager = RequestTaskManager()
                    }
                    requestTasks[key] = taskManager
                } else {
                    taskManager = requestTasks[key]
                }
                
                taskManager?.completionClosure = {
                    self.requestTasks.removeValue(forKey: key)
                }
                var tempParam = params
                let dynamicTempParam = dynamicParams == nil ? [:] : dynamicParams!
                dynamicTempParam.forEach { arg in
                    tempParam[arg.key] = arg.value
                }
                taskManager?.request(urlRequest: urlRequest, cacheKey: key)
                return taskManager!
            }
            return nil
        }
        return nil
    }
    
    /// 取消请求
    func cancel(_ url: String, params: Parameters? = nil, dynamicParams: Parameters? = nil) {
        let key = cacheKey(url, params, dynamicParams)
        let taskManager = requestTasks[key]
        taskManager?.dataRequest?.cancel()
    }
    
    /// 清除所有缓存
    func removeAllCache(completion: @escaping (Bool)->()) {
        CacheManager.default.removeAllCache(completion: completion)
    }
    
    /// 根据key值清除缓存
    func removeObjectCache(_ url: String, params: [String: Any]? = nil, dynamicParams: Parameters? = nil, completion: @escaping (Bool)->()) {
        let key = cacheKey(url, params, dynamicParams)
        CacheManager.default.removeObjectCache(key, completion: completion)
    }
}

public class RequestTaskManager {
    fileprivate var dataRequest: DataRequest?
    fileprivate var cache: Bool = false
    fileprivate var cacheKey: String!
    fileprivate var sessionManager: Session?
    fileprivate var completionClosure: (()->())?
    
    @discardableResult
    fileprivate func timeoutIntervalForRequest(_ timeInterval: TimeInterval)->RequestTaskManager {
       
        let sessionManager:Session = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = timeInterval
            return Session(configuration: configuration)
        }()
        
        self.sessionManager = sessionManager
        return self
    }
    
    @discardableResult
    fileprivate func request(
        _ url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        cacheKey: String,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
    -> RequestTaskManager
    {
        self.cacheKey = cacheKey
        if sessionManager != nil {
            dataRequest = sessionManager?.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        } else {
            dataRequest = AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        }
        
        return self
    }
    
    /// request
    ///
    /// - Parameters:
    ///   - urlRequest: urlRequest
    ///   - cacheKey: cacheKey
    /// - Returns: RequestTaskManager
    @discardableResult
    fileprivate func request(
        urlRequest: URLRequestConvertible,
        cacheKey: String)
    -> RequestTaskManager
    {
        self.cacheKey = cacheKey
        if sessionManager != nil {
            dataRequest = sessionManager?.request(urlRequest)
        } else {
            dataRequest = AF.request(urlRequest)
        }
        return self
    }
    
    /// 缓存data是否存在
    public func cacheDataIsExist()->Bool {
        let data = CacheManager.default.objectSync(forKey: cacheKey)?.data
        return data != nil
    }
    
    /// 是否缓存数据
    public func cache(_ cache: Bool)->RequestTaskManager {
        self.cache = cache
        return self
    }
    
    /// 获取缓存Data
    @discardableResult
    public func cacheData()->Data? {
        let dataResponse = DaisyDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return dataResponse.cacheData()
    }
    
    /// 响应Data
    public func responseData(queue: DispatchQueue = .main, completion: @escaping (CacheValue<Data>)->()) {
        let dataResponse = DaisyDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        dataResponse.responseData(queue: queue, completion: completion)
    }
    
    /// 先获取Data缓存，再响应Data
    public func responseCacheAndData(queue: DispatchQueue = .main, completion: @escaping (CacheValue<Data>)->()) {
        let dataResponse = DaisyDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        dataResponse.responseCacheAndData(queue: queue, completion: completion)
    }
    
    /// 获取缓存String
    @discardableResult
    public func cacheString()->String? {
        let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return stringResponse.cacheString()
    }
    
    /// 响应String
    public func responseString(queue: DispatchQueue = .main, completion: @escaping (CacheValue<String>)->()) {
        let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        stringResponse.responseString(queue: queue, completion: completion)
    }
    
    /// 先获取缓存String,再响应String
    public func responseCacheAndString(queue: DispatchQueue = .main, completion: @escaping (CacheValue<String>)->()) {
        let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        stringResponse.responseCacheAndString(queue: queue, completion: completion)
    }
    
    /// 获取缓存JSON
    @discardableResult
    public func cacheJson()->Any? {
        let jsonResponse = DaisyJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        return jsonResponse.cacheJson()
    }
    
    /// 响应JSON
    public func responseJson(queue: DispatchQueue = .main, completion: @escaping (CacheValue<Any>)->()) {
        let jsonResponse = DaisyJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        jsonResponse.responseJson(queue: queue, completion: completion)
    }
    
    /// 先获取缓存JSON，再响应JSON
    public func responseCacheAndJson(queue: DispatchQueue = .main, completion: @escaping (CacheValue<Any>)->()) {
        let jsonResponse = DaisyJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
        jsonResponse.responseCacheAndJson(queue: queue, completion: completion)
    }
}


// MARK: - DaisyBaseResponse

public class DaisyResponse {
    fileprivate var dataRequest: DataRequest
    fileprivate var cache: Bool
    fileprivate var cacheKey: String
    fileprivate var completionClosure: (()->())?
    fileprivate init(dataRequest: DataRequest, cache: Bool, cacheKey: String, completionClosure: (()->())?) {
        self.dataRequest = dataRequest
        self.cache = cache
        self.cacheKey = cacheKey
        self.completionClosure = completionClosure
    }
    
    ///
    fileprivate func response<T>(response: AFDataResponse<T>, completion: @escaping (CacheValue<T>)->()) {
        responseCache(response: response) { result in
            completion(result)
        }
    }
    
    /// isCacheData
    fileprivate func responseCache<T>(response: AFDataResponse<T>, completion: @escaping (CacheValue<T>)->()) {
        if completionClosure != nil { completionClosure!() }
        let result = CacheValue(isCacheData: false, result: response.result, response: response.response)
//        if openResultLog {
            print("================请求数据=====================")
//        }
//        if openUrlLog {
            print(response.request?.url?.absoluteString ?? "")
//        }
        switch response.result {
        case .success:
//            if openResultLog {
                if let data = response.data,
                   let str = String(data: data, encoding: .utf8)
                {
                    print(str)
                }
//            }
            if cache { /// 写入缓存
                var model = CacheModel()
                model.data = response.data
                CacheManager.default.setObject(model, forKey: cacheKey)
            }
        case .failure(let error):
//            if openResultLog {
                print(error.localizedDescription)
//            }
        }
        completion(result)
    }
}

// MARK: - DaisyJsonResponse

public class DaisyJsonResponse: DaisyResponse {
    /// 响应JSON
    func responseJson(queue: DispatchQueue, completion: @escaping (CacheValue<Any>)->()) {
        dataRequest.responseJSON(queue: queue, completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    
    fileprivate func responseCacheAndJson(queue: DispatchQueue, completion: @escaping (CacheValue<Any>)->()) {
        if cache {
            if let json = cacheJson() {
                let res = CacheValue(isCacheData: true, result: AFResult.success(json), response: nil)
                queue.async {
                    completion(res)
                }
            }
        }
        dataRequest.responseJSON(queue: queue) { response in
            self.responseCache(response: response, completion: completion)
        }
    }
    
    /// 获取缓存json
    @discardableResult
    fileprivate func cacheJson()->Any? {
        if let data = CacheManager.default.objectSync(forKey: cacheKey)?.data,
           let json = try? JSONSerialization.jsonObject(with: data, options: [])
        {
//            if openResultLog {
                print("=================缓存=====================")
                if let str = String(data: data, encoding: .utf8) {
                    print(str)
                }
//            }
            return json
        } else {
//            if openResultLog {
                print("读取缓存失败")
//            }
            return nil
        }
    }
}

// MARK: - DaisyStringResponse

public class DaisyStringResponse: DaisyResponse {
    /// 响应String
    func responseString(queue: DispatchQueue, completion: @escaping (CacheValue<String>)->()) {
        dataRequest.responseString(queue: queue, completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    
    @discardableResult
    fileprivate func cacheString()->String? {
        if let data = CacheManager.default.objectSync(forKey: cacheKey)?.data,
           let str = String(data: data, encoding: .utf8)
        {
            return str
        } else {
//            if openResultLog {
                print("读取缓存失败")
//            }
            return nil
        }
    }
    
    fileprivate func responseCacheAndString(queue: DispatchQueue, completion: @escaping (CacheValue<String>)->()) {
        if cache {
            if let str = cacheString() {
                let res = CacheValue(isCacheData: true, result: AFResult.success(str), response: nil)
                queue.async {
                    completion(res)
                }
            }
        }
        dataRequest.responseString(queue: queue) { response in
            self.responseCache(response: response, completion: completion)
        }
    }
}

// MARK: - DaisyDataResponse

public class DaisyDataResponse: DaisyResponse {
    /// 响应Data
    func responseData(queue: DispatchQueue, completion: @escaping (CacheValue<Data>)->()) {
        dataRequest.responseData(queue: queue, completionHandler: { response in
            self.response(response: response, completion: completion)
        })
    }
    
    @discardableResult
    fileprivate func cacheData()->Data? {
        if let data = CacheManager.default.objectSync(forKey: cacheKey)?.data {
            return data
        } else {
//            if openResultLog {
                print("读取缓存失败")
//            }
            return nil
        }
    }
    
    fileprivate func responseCacheAndData(queue: DispatchQueue, completion: @escaping (CacheValue<Data>)->()) {
        if cache {
            if let data = cacheData() {
                let res = CacheValue(isCacheData: true, result: AFResult.success(data), response: nil)
                queue.async {
                    completion(res)
                }
            }
        }
        dataRequest.responseData(queue: queue) { response in
            self.responseCache(response: response, completion: completion)
        }
    }
}


public extension JSONDecoder {
    
    func decode<T>(_ type: T.Type,
                   from data: Data,
                   keyPath: String,
                   keyPathSeparator separator: String = ".") throws -> T where T : Decodable {
        userInfo[keyPathUserInfoKey] = keyPath.components(separatedBy: separator)
        return try decode(KeyPathWrapper<T>.self, from: data).object
    }
}

private let keyPathUserInfoKey = CodingUserInfoKey(rawValue: "keyPathUserInfoKey")!

private final class KeyPathWrapper<T: Decodable>: Decodable {
    
    enum KeyPathError: Error {
        case `internal`
    }
    
    struct Key: CodingKey {
        init?(intValue: Int) {
            self.intValue = intValue
            stringValue = String(intValue)
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            intValue = nil
        }
        
        let intValue: Int?
        let stringValue: String
    }
    
    typealias KeyedContainer = KeyedDecodingContainer<KeyPathWrapper<T>.Key>
    
    init(from decoder: Decoder) throws {
        guard let keyPath = decoder.userInfo[keyPathUserInfoKey] as? [String],
              !keyPath.isEmpty
        else { throw KeyPathError.internal }
        
        func getKey(from keyPath: [String]) throws -> Key {
            guard let first = keyPath.first,
                  let key = Key(stringValue: first)
            else { throw KeyPathError.internal }
            return key
        }
        
        func objectContainer(for keyPath: [String],
                             in currentContainer: KeyedContainer,
                             key currentKey: Key) throws -> (KeyedContainer, Key) {
            guard !keyPath.isEmpty else { return (currentContainer, currentKey) }
            let container = try currentContainer.nestedContainer(keyedBy: Key.self, forKey: currentKey)
            let key = try getKey(from: keyPath)
            return try objectContainer(for: Array(keyPath.dropFirst()), in: container, key: key)
        }
        
        let rootKey = try getKey(from: keyPath)
        let rooTContainer = try decoder.container(keyedBy: Key.self)
        let (keyedContainer, key) = try objectContainer(for: Array(keyPath.dropFirst()), in: rooTContainer, key: rootKey)
        object = try keyedContainer.decode(T.self, forKey: key)
    }
    
    let object: T
}


