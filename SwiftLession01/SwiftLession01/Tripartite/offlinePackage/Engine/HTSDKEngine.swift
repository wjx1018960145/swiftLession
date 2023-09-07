//
//  HTSDKEngine.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/20.
//

import Foundation
import MBProgressHUD
import SSZipArchive
import WebKit
import WKWebViewJavascriptBridge

public typealias HTAppInstallProcess = (_ res:Float)->Void

public typealias HTAppInstallFinish = (_ res:Bool)->Void

public typealias HTRequestFinish = (_ data:NSDictionary ,_ error:NSError)->Void

class HTSDKEngine: NSObject{
    
    static let sharedInstance = HTSDKEngine()
    static let  utils=Utils()
    static let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    static let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
    
    static  let unzipPath    : URL = libraryURL.appendingPathComponent("Offline")
    static let blueDiretory : URL = unzipPath.appendingPathComponent("H5/")
  
    
    static func registerDefaults(appId:String){

    }
    static func initNebula(){
        
    }
    
    
    /**
     *  基于在线url，创建一个H5容器
     *
     *  @param params H5容器的启动参数，必填参数：url，其他可选参数参考文档
     *
     */
    func startH5ViewControllerWithParams(params:Any?){
        
        let dic = params as! Dictionary<String, Any>
        
        if dic["url"] == nil{
            print("URL为必传项")
            return
        }
        
        
//        self.viewController = UIViewController();
////        [self initNaviItem];
//         self.createBaseView()
//        self.loadingURL(urltring: dic["url"] as! String)
        
        let _ = WJXVCRouter.openURL(url: "Pages/Web/H5",parameters:["params":dic] as NSDictionary)
    }
   
    /**
     *  基于传入的离线包信息，创建一个H5容器，并自动push打开
     *
     *  @param params H5容器的启动参数，必填参数：appId，其他可选参数参考文档
     *
     */
    func startH5ViewControllerWithNebulaApp(params:Any?){
        
        var dic = params as! Dictionary<String, Any>
        
        if dic["appId"] == nil {
            print("appId为必传项")
            return
        }
        
     
        
        let appId = dic["appId"] as! String
        

        let url =  HTSDKEngine.unzipPath.path + "/" + appId+"/"+appId+HTApp.main_url!
        
        dic["url"] = "file://" + url
        
        
        let _ = WJXVCRouter.openURL(url: "Pages/Web/H5",parameters:["params":dic] as NSDictionary)
        
    }
    /**
     *  基于传入的离线包信息，创建一个H5容器，并返回创建的H5容器实例。一般用在首页tab页面
     *
     *  @param params H5容器的启动参数，必填参数：appId，其他可选参数参考文档
     *
     *  @return 创建的H5容器vc实例
     */
    func  createH5ViewControllerWithNebulaApp(params:Any?) ->UIViewController {
        
        return UIViewController()
    }
    
   
   
    
    /**
     *  安装离线包
     *
     *  @param app         离线包信息，可通过findApp：查找
     *  @param process   安装过程回调, 过程包含: 异步下载离线包->解压离线包
     *  @param finish       安装完成的回调
     */
    func installNebulaApp(app:HTApp,process:@escaping HTAppInstallProcess,finish:@escaping HTAppInstallFinish){
//        let manager = FileManager.default
        let zipPath = HTSDKEngine.cachesURL.appendingPathComponent(HTApp.app_id!+".zip")
//        _ = try? manager.removeItem(at: zipPath)
//        _ = try? manager.moveItem(at: location, to: zipPath)
        
//        let isSuccess = SSZipArchive.unzipFile(atPath: zipPath.path,
//                                               toDestination: HTSDKEngine.unzipPath.path)
        let isSuccess = SSZipArchive.unzipFile(atPath: zipPath.path, toDestination: HTSDKEngine.unzipPath.path, overwrite: false, password: "123456") { entry, info, entryNumber, total  in
            
            process(Float(entryNumber))
        }
//        let res =
        var isok:Bool?
        if isSuccess == true {
            isok = true
        }else{
            isok = false
        }
        print(zipPath)
        DispatchQueue.main.async {
            finish(isok!)
        }
        
    }
   
    static func SDKEngineVersion()->String {
        return HT_SDK_VERSION
    }
    static func initSDKEnvironment(){
        self.registerDefaultModules()
        self.registerDefaultHandlers()
    }
    
    
    /**
     *  单个应用请求
     *
     *  注:
     *      9.9.9前: 请求成功后Wifi下自动下载离线包,非Wifi只下载auto_install为YES的离线包
     *      9.9.9及之后: 可针对每个应用配置下载时机, 通过服务端配置, 默认WIFI下载
     *
     *  @param params   请求列表 格式:{appid:version},可传多个appid,不指定version时传空传,默认取最高版本
     *                支持版本号模糊匹配 e.g. '*' 匹配最高版本号 '1.*' 匹配1开头的版本号总最高版本号等,最长4位
     *  @param finish 完成回调
     */
    func requestNebulaAppsWithParams(params:Any?,finish:HTRequestFinish){
        
    }
    
    /**
     *  全量下载包信息池中的离线包
     *
     *
     */
    func downLoadAllNebulaApps(){
        let session = URLSession.shared
        let URL = Foundation.URL(string: HTApp.package_url!)
        let task  = session.downloadTask(with: URL!, completionHandler: {
            location, response, error in
            guard let location = location , error == nil else {
                DispatchQueue.main.async {
                    assert(false,"diwnload fail")
//                    handler(false)
                }
                return
            }
            
        })
        task.resume()
    }
    /**
     *  批量下载指定的离线包
     *
     *  @param params 字典{appId:version},指定要下载的appId和版本号,从包管理池中读取并下载
     */
    func downLoadNebulaAppsWithParams(params:Any?){
        
    }
    
    
    static func downloadBlueTask(appId:String, _ handler: @escaping (_ isSuccess: Bool) -> Void) {
        
        
        let session = URLSession.shared
        let url = "http:172.17.6.52:8095/api/v1.0/offline/package/download?appId="+appId
        let URL = Foundation.URL(string: url)
//        let HUD = navigationController!.showHUD("Download Theme...")
        let task = session.downloadTask(with: URL!, completionHandler: { location, response, error in
            
            guard let location = location , error == nil else {
                DispatchQueue.main.async {
                    handler(false)
                }
                return
            }
            
            let manager = FileManager.default
            let zipPath = cachesURL.appendingPathComponent(appId+".zip")
            
            _ = try? manager.removeItem(at: zipPath)
            _ = try? manager.moveItem(at: location, to: zipPath)
//            HUD.label.text = isSuccess ? "Successful!" : "Failure!"
//            HUD.mode = .text
//            HUD.hide(animated: true, afterDelay: 1)
            
            let isSuccess = SSZipArchive.unzipFile(atPath: zipPath.path,
                                                   toDestination: unzipPath.path)
            
            print(zipPath)
            DispatchQueue.main.async {
                handler(isSuccess)
            }
            
        })
        
        task.resume()
    }
    
    static func initNebulaWithCustomPresetApplistPath(customPresetApplistPath:String?,customPresetAppPackagePath:String,customPluginsJsapisPath:String?){
        
        if customPresetApplistPath != nil {
            
            let app = HTApp()
            let dic = utils.getlockSourceForDic(fileName: customPresetApplistPath!)
            
            let arr = dic["data"] as! Array<Any>
            
            app.initWithDict(dictionary: arr[0]  as! Dictionary<String,AnyObject>)
            
            
        }
        
        if customPluginsJsapisPath != nil {
            //注册 jsf方法
            
            
            
        }
        
        
        
    }
}


extension HTSDKEngine {
    
    static func registerDefaultModules(){
        
        
        
        self.registerModule(name: "HT", className: "DefaultMoudle", withClasss: ["HTNavigatorModule"])
    }
    static func registerDefaultHandlers(){
        
        self.registerHandler(handler: HTNavigationDefaultImpl(), pro: HTNavigationProtocol.self)
        
//        [self registerHandler:[HTResourceRequestHandlerDefaultImpl new] withProtocol:@protocol(HTResourceRequestHandler)];
        
    }
    static func registerModule(name:String?, className:String?,withClasss:Array<Any>?){
        
        if (name == nil || withClasss == nil || className == nil) {
            return;
        }
        if((className?.isEmpty) != nil){
//            className = "HTBaseViewController"
        }
        
        
        let bridege = HTSDKManager.bridgeMgr()
        let dic:Dictionary<String,Any> = [className!:withClasss! as Array]

        bridege.initModulesName(moduleName: className, modules: dic)
        
        
        
    }
    
    static func registerModule(name:String?,withClass:AnyClass?){
//        assert(name && withClass, "Fail to register the module, please check if the parameters are correct ！");
        
        if (withClass != nil || name != nil) {
            return;
        }
        
        let moduleName = HTModuleFactory.registerModule(name: name!, clazz: withClass!)
        let dict = HTModuleFactory.moduleMethodMapsWithName(name: name!)
        
        HTSDKManager.bridgeMgr().initModulesName(moduleName: moduleName, modules: dict)
        
    }
    
    
    static func registerModule(name:String,className:String,withClasss:[Array<Any>]){
        
    }
    static func registerComponent(name:String,withClass:String){
        
    }
    static func registerExtendCallNative(name:String,withClass:String){
        
    }
    static func registerComponent(name:String,withClass:String,withProperties:[String: String]){
        
    }
    static func registerService(name:String,serviceScript:String,options:[String:String]){
        
    }
    static func registerHandler(handler:Any,pro:Protocol){
        
        HTHandlerFactory.registerHandler(handler: handler, pro: pro)
    }
}
