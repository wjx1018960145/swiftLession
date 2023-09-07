//
//  Constants.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class Constants: NSObject {
    public static  var LOCAL_ASSET_LIST:[String] = ["main.zip"]
    
    // 服务器地址
    public static   var BASE_URL:String = "http://172.17.1.196:8095";
    
    // package.json请求地址
    public static  var BASE_PACKAGE_INDEX:String = BASE_URL + "/api/v1.0/offline/getPackageIndex?appId=12345678";
    
    /***
     * 所有离线包的根目录
     * */
    public static var  PACKAGE_FILE_ROOT_PATH:String = "offlinepackage";
    
    /***
     * 配置信息
     * */
    public static var  PACKAGE_FILE_INDEX:String = "packageIndex.json";
    /***
     * 每个离线包的索引信息文件
     * */
    public static var  RESOURCE_INDEX_NAME:String = "index.json";
    
    /**
     * 工作目录
     */
    public static var  PACKAGE_WORK:String = "work";
    
    /***
     *
     * 更新临时目录
     * */
    public static var  PACKAGE_UPDATE_TEMP:String = "update_tmp.zip";
    
    /***
     *
     * 更新目录
     * */
    public static var  PACKAGE_UPDATE:String = "update.zip";
    
    /**
     * 下载文件名称
     */
    public static var  PACKAGE_DOWNLOAD:String = "download.zip";
    
    /**
     * merge路径
     */
    public static var  PACKAGE_MERGE:String = "merge.zip";
    
    /**
     * 中间路径
     */
    public static var  RESOURCE_MIDDLE_PATH:String = "package";
    
    /**
     * asstes文件名称
     */
    public static var  PACKAGE_ASSETS:String = "package.zip";
}
