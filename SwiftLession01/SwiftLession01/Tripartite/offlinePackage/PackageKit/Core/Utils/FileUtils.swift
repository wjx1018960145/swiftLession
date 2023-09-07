//
//  FileUtils.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class FileUtils: NSObject {

    
    /**
     * 获取根容器的地址
     */
    public static func getPackageRootPath()->String {
        
        let libraryPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                               FileManager.SearchPathDomainMask.userDomainMask, true)
        let libraryPath = libraryPaths[0]
        return libraryPath;
    }
    //获取packageIndex.json地址
    public static func  getPackageIndexFileName()->String {
        let root = getPackageRootPath();
        if (root.isEmpty) {
            return "";
        }
        makeDir(path: root);
        return root + Constants.PACKAGE_FILE_INDEX;
    }
    
    public static func  makeDir(path:String)->Bool {
        let manager = FileManager.default
        var isDirectory: ObjCBool = ObjCBool(false)
        let isExist = manager.fileExists(atPath: path, isDirectory: &isDirectory)
        
        if !isExist {
            do {
                
                try manager.createDirectory(at: URL(fileURLWithPath: path) , withIntermediateDirectories: true, attributes: nil)
                return true
            } catch {
                return false
                print("createDirectory error:\(error)")
            }
        }
        return false
    }
    
}
