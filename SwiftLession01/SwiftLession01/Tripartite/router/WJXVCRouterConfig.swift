//
//  WJXVCRouterConfig.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/24.
//

import UIKit
import JLRoutes


class WJXVCRouterConfig: NSObject {
    
    static let  url_server = "http://172.17.1.196:8095/"
    //#define list_URL @"/lol/api/v1/authors"
    static let url_path = "getRouterMaps"
    static let  utils=Utils()
    static func configMapInfo(){
        //取缓存
       
        JLRoutes.removeAllRoutes()
        //取不到 取本地
        let routerMapInfo = utils.getlockSourceForDic(fileName: "RouterMap.geojson")
        
        WJXVCRouter.registerRouter(routerMapInfo:routerMapInfo)
        //网络请求下 再次初始化
        downloadRouters()
        
    }
    static func downloadRouters(){
        
        let urlStr = url_server+url_path
        let params: [String: Any] = [:]
        
        /// 10s超时
        CacheMesh.timeoutIntervalForRequest(60)
        
        CacheMesh.request(urlStr, params: params).cache(true).responseCacheAndJson(queue: .main) { value in
            switch value.result {
            case .success(let string):
                print(Thread.current)
                if value.isCacheData {
                    print("缓存数据",string)
//                    self.cacheTextView.text = string
                } else {
                    print("请求数据",string)
//                    self.textView.text = string
                }
               
           
                WJXVCRouter.registerRouter(routerMapInfo:string as! NSDictionary)
            case .failure(let error):
                print(error)
                
                
                
            }
        }
        
    }
}
