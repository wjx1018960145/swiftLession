//
//  PackageManager.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit
import Alamofire

class PackageManager: NSObject,NSMachPortDelegate{
    
    private static let  WHAT_DOWNLOAD_SUCCESS:Int = 1;
    private static let  WHAT_DOWNLOAD_FAILURE:Int = 2;
    private static let  WHAT_START_UPDATE:Int = 3;
    private static let  WHAT_INIT_ASSETS:Int = 4;
    
    private static let  STATUS_PACKAGE_CANUSE:Int = 1;
    static var notificationName:String = "XMNotification"
    
    static let getInstance = PackageManager()
    private var  resourceManager:ResourceManager?
    private var  packageInstaller:PackageInstaller?
    private var assetResourceLoader:AssetResourceLoader?
    private var config:PackageConfig =  PackageConfig()
    
   
    var  isUpdating:Bool = false
    var  resourceLock:NSLock?;
     var localPackageEntity:PackageEntity?;
    public func inits()->Void {
        
//        Log.d("PackageManager","init");
//        this.context = context;
        self.resourceLock = NSLock()
        resourceManager =  ResourceManagerImpl();
        
        packageInstaller =  PackageInstallerImpl();
        
//        FileDownloader.init(context);
        /// 通知名
        
        /// 自定义通知
        ///
//        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name:  PackageManager.notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name(rawValue: PackageManager.notificationName), object: nil)
        
        let packageIndexFileName = FileUtils.getPackageIndexFileName();
        let filemanager = FileManager.default
//        File packageIndexFile = new File(packageIndexFileName);
        
        if (config.isEnableAssets() && !config.getAssetPath().isEmpty && !filemanager.fileExists(atPath: packageIndexFileName)) {
            
            assetResourceLoader =  AssetResourceLoaderImpl();
            ensurePackageThread();
           
            /// 发送简单数据
            let message = ["what":PackageManager.WHAT_INIT_ASSETS,"obj":""]  as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: PackageManager.notificationName), object: message)
//            Notification.default.post(name: PackageManager.notificationName, object: message)
//            packageHandler.sendEmptyMessage(WHAT_INIT_ASSETS);
        }
    }
    
    private func ensurePackageThread()->Void {
        
        

//        if (packageThread == nil) {
//            packageThread = new HandlerThread("offline_package_thread");
//            packageThread.start();
//            packageHandler = new PackageHandler(packageThread.getLooper());
//        }
    }
    
    //从服务端获取最新的packageIndex.json
    public func update(packageIndexStr:String) ->Void{
        if (isUpdating) {
            return;
        }
        if (packageIndexStr.isEmpty) {
          var  packageIndexStr = ""
        }
        ensurePackageThread();
        
//        Message message = Message.obtain();
//        message.what = WHAT_START_UPDATE;
//        message.obj = packageIndexStr;
//        packageHandler.sendMessage(message);

        let message = ["what":PackageManager.WHAT_START_UPDATE,"obj":packageIndexStr]  as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: PackageManager.notificationName), object: message)
        
    }
    //获取预置在assets中的离线包并解压到相应目录
    func performLoadAssets(){
        if (assetResourceLoader == nil) {
            return;
        }
       
        
        for index in 0..<Constants.LOCAL_ASSET_LIST.count {
            print("PKGM1",Constants.LOCAL_ASSET_LIST[index]);
            let packageInfo:PackageInfo = assetResourceLoader!.load(path: Constants.LOCAL_ASSET_LIST[index]);
            if (packageInfo is NSNull) {
                return;
            }
            print("PKGM2", packageInfo.packageId)
            print("performLoadAssets", "installPackage");
            installPackage(packageId: packageInfo.packageId, packageInfo: packageInfo, isAssets: true);
        }
    }
    //将预置在assets或刚下载的离线包解压到指定目录
    func installPackage( packageId:String,  packageInfo:PackageInfo,  isAssets:Bool){
        if (packageInfo != nil) {
//            //暂时关闭对下载文件的MD5校验
//            var isValid:Bool = (isAssets && assetValidator.validate(packageInfo)) || validator.validate(packageInfo);
//                        if (isValid) {
            self.resourceLock!.lock();
            let isSuccess = packageInstaller!.install(packageInfo: packageInfo, isAssets: isAssets);
            resourceLock!.unlock();
//            //安装失败情况下，不做任何处理，因为资源既然资源需要最新资源，失败了，就没有必要再用缓存了
            if (isSuccess) {
//                Log.d("installPackage", "version" + packageInfo.getVersion() + "| isAssets " + isAssets );
               _ = resourceManager!.updateResource(packageId: packageInfo.packageId, version: packageInfo.version);
//                //更新安装成功的离线包版本到packageIndex.json
                updatePackageIndexFile(packageId: packageInfo.packageId, version: packageInfo.version);
//                synchronized (packageStatusMap) {
//                    packageStatusMap.put(packageId, STATUS_PACKAGE_CANUSE);
//                }
            }
//                        }
        }
    }
    //更新packageIndex.json中packageId对应的离线包版本
    func updatePackageIndexFile( packageId:String,  version:String){
//        Log.d("updatePackageIndexFile1", packageId + "|"+version);
        var packageIndexFileName:String = FileUtils.getPackageIndexFileName();
        var packageIndexFile = FileManager.default;
        
        //若不存在packageIndex.json，则创建一个packageIndex.json
        if (!packageIndexFile.fileExists(atPath: packageIndexFileName)) {
            var isSuccess = true;
            
            do {
                isSuccess = packageIndexFile.createFile(atPath: packageIndexFileName, contents: nil, attributes: nil);
            }  catch  {
                isSuccess = false;
            }
            if (!isSuccess) {
                return;
            }
        }
        if (self.localPackageEntity == nil) {
//            FileInputStream indexFis = nil;
//            try {
//                indexFis = new FileInputStream(packageIndexFile);
//            } catch (FileNotFoundException e) {
//
//            }
//            if (indexFis == null) {
//                return;
//            }
            
//            localPackageEntity = GsonUtils.fromJsonIgnoreException(indexFis, PackageEntity.class);
        }
//        if (localPackageEntity == null) {
//            localPackageEntity = new PackageEntity();
//        }
//
//        //获取localPackageEntity下所有的离线包packageInfo，如果存在packageId对应的包，则更新版本状态等，没有则加进去
//        List<PackageInfo> packageInfoList = new ArrayList<>(2);
//        if (localPackageEntity.getItems() != null) {
//            packageInfoList.addAll(localPackageEntity.getItems());
//        }
//        PackageInfo packageInfo = new PackageInfo();
//        packageInfo.setPackageId(packageId);
//        int index = 0;
//        if ((index = packageInfoList.indexOf(packageInfo)) >= 0) {
//            packageInfoList.get(index).setVersion(version);
//        } else {
//            packageInfo.setStatus(PackageStatus.onLine);
//            packageInfo.setVersion(version);
//            packageInfoList.add(packageInfo);
//        }
//        localPackageEntity.setItems(packageInfoList);
//        if (localPackageEntity == null || localPackageEntity.getItems() == null
//            || localPackageEntity.getItems().size() == 0) {
//            return;
//        }
//
//        //将最新的数据写入到packageIndex.json文件中
//        String updateStr = new Gson().toJson(localPackageEntity);
//        try {
//            FileOutputStream outputStream = new FileOutputStream(packageIndexFile);
//            try {
//                outputStream.write(updateStr.getBytes());
//            } catch (IOException ignore) {
//                Logger.e("write packageIndex file error");
//            } finally {
//                if (outputStream != null) {
//                    try {
//                        outputStream.close();
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    }
//                }
//            }
//        } catch (Exception ignore) {
//            Logger.e("read packageIndex file error");
//        }
    }
    
    @objc func notificationAction(noti:Notification){
        /// 获取键盘的位置/高度/时间间隔...
        print(noti)
        let userinfo = noti.object as! Dictionary<String, Any>
        let index:Int = userinfo["what"] as! Int
        switch index {
        case PackageManager.WHAT_DOWNLOAD_SUCCESS:
            break
        case PackageManager.WHAT_DOWNLOAD_FAILURE:
            break
        case PackageManager.WHAT_START_UPDATE:
            break
        case PackageManager.WHAT_INIT_ASSETS:
            performLoadAssets()
            break
        default: break
            
        }
//        switch (index) {
//        case PackageManager.WHAT_DOWNLOAD_SUCCESS:
////            [self performDownloadSuccess:userinfo[@"obj"]];
//            break;
//        case PackageManager.WHAT_DOWNLOAD_FAILURE:
//
//            break;
//        case PackageManager.WHAT_START_UPDATE:
////            [self performUpdate:userinfo[@"obj"]];
//            break;
//        case PackageManager.WHAT_INIT_ASSETS:
////            [self  performLoadAssets];
//            break;
//
//        default:
//            break;
//        }
    }
   
}

