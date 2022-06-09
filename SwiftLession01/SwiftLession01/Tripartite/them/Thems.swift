//
//  Thems.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/24.
//

import Foundation
import MBProgressHUD
import SSZipArchive

let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]


private let lastThemeIndexKey = "lastedThemeIndex"
private let defaults = UserDefaults.standard

enum Themes: Int {
    
    case red   = 0
    case yello = 1
    case blue  = 2
    case night = 3
    
    // MARK: -
    
//    static var current = Themes.red 当前主题色
//    static var before  = Themes.red 之前主题色
    static var current: Themes {
        return Themes(rawValue: ThemeManager.currentThemeIndex)!
    }
    static var before = Themes.red
//
    // MARK: - Switch Theme
    
    // MARK: - Switch Theme
    
    static func switchTo(theme: Themes) {
        before  = current
//        current = theme
        
        switch theme {
        case .red   : ThemeManager.setTheme(jsonName: "Red", path: .mainBundle)
        case .yello : ThemeManager.setTheme(jsonName: "Yellow", path: .mainBundle)
        case .blue  : ThemeManager.setTheme(jsonName: "Blue", path: .sandbox(blueDiretory))
        case .night : ThemeManager.setTheme(jsonName: "Night", path: .mainBundle)
        }
        
//        ThemeManager.setTheme(index: theme.rawValue)
    }
    
    static func switchToNext() {
        var next = current.rawValue + 1
        var max  = 2 // without Blue and Night
//
//        if isBlueThemeExist() { max += 1 }
//        if next >= max { next = 0 }
       
//        var next = ThemeManager.currentThemeIndex + 1
        if isBlueThemeExist() {
            max += 1
            
        }
        if next >= max {
            next = 0
            
        }
        ThemeManager.currentThemeIndex = next
        self.saveLastTheme()
        switchTo(theme: Themes(rawValue: next)!)
        print(defaults.value(forKey: lastThemeIndexKey) ?? "")
        
    }
    
    // MARK: - Switch Night
    
    static func switchNight(_ isToNight: Bool) {
        switchTo(theme: isToNight ? .night : before)
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
    
    // MARK: - Download
    
    static func downloadBlueTask(_ handler: @escaping (_ isSuccess: Bool) -> Void) {
        
        
        let session = URLSession.shared
        let url = "https://github.com/wxxsw/SwiftThemeResources/blob/master/20170128/Blue.zip?raw=true"
        let URL = Foundation.URL(string: url)
         
        let task = session.downloadTask(with: URL!, completionHandler: { location, response, error in
            
            guard let location = location , error == nil else {
                DispatchQueue.main.async {
                    handler(false)
                }
                return
            }
            
            let manager = FileManager.default
            let zipPath = cachesURL.appendingPathComponent("Blue.zip")
            
            _ = try? manager.removeItem(at: zipPath)
            _ = try? manager.moveItem(at: location, to: zipPath)
            
            let isSuccess = SSZipArchive.unzipFile(atPath: zipPath.path,
                                        toDestination: unzipPath.path)
            
            DispatchQueue.main.async {
                handler(isSuccess)
            }
        })
        
        task.resume()
    }
    
    static func isBlueThemeExist() -> Bool {
        return FileManager.default.fileExists(atPath: blueDiretory.path)
    }
    
    static let blueDiretory : URL = unzipPath.appendingPathComponent("Blue/")
    static let unzipPath    : URL = libraryURL.appendingPathComponent("Themes/20170128")
    // MARK: - Save & Restore
    
    static func restoreLastTheme() {
        switchTo(theme: Themes(rawValue: defaults.integer(forKey: lastThemeIndexKey))!)
    }
    
    static func saveLastTheme() {
        defaults.set(ThemeManager.currentThemeIndex, forKey: lastThemeIndexKey)
    }
}
