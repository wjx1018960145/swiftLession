//
//  PackageInfo.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class PackageInfo: NSObject ,NSCoding {
    
    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
    //实际的md5
    public var  md5:String=""
    
    public var  module_name:String=""
    
    public var packageId:String=""
    
    //离线包版本号
    public var  version:String=""
    
    //离线包的状态 {@link PackageStatus}
    public var  status:Int = PackageStatus.onLine
    
    //是否是patch包
    public var  is_patch:Bool = false
    
    
    // 实际上的下载地址
    public var  file_path:String = ""
    
    
    
    //离线包md值 由后端下发
    public var  patch_file_md5:String="";
    public var  origin_file_md5:String="";
    public var  patch_file_path:String="";
    public var  origin_file_path:String="";
    
}
