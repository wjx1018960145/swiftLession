//
//  ResourceInfo.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class ResourceInfo: NSObject {
    //所关联的package id
    //后续需要根据该id索引离线包信息
//    @Expose(deserialize = false, serialize = false)
    private var  packageId:String="";
    
    //远端路径
    private var  remoteUrl:String="";
    
    //相对路径
    private var  path:String="";
    
//    @Expose(deserialize = false, serialize = false)
    //本地绝对路径
    private var  localPath:String="";
    
    //类型
    private var  mimeType:String="";
    
    private var  md5:String="";

}
