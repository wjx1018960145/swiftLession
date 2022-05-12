//
//  AVAssetExportSessionExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/8.
//

import UIKit
import AVFoundation
class AVAssetExportSessionExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、有关视频压缩的扩展"]
        dataArray = [["本地视频压缩"]]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - 一、有关视频压缩的扩展
extension AVAssetExportSessionExtensionViewController {
    // MARK: 1.1、本地视频压缩
    @objc func test11() {
        
        AVAssetExportSession.jx.assetExportSession(inputPath: "是本地视频路径", outputPath: "导出视频的路径", outputFileType: .mp4, completionHandler: { (exportSession, duration, videoSize, localVideoPath) in
            switch exportSession.status{
            case .waiting:
                print("等待压缩")
                break
            case .exporting:
                print("压缩中：")
                break
            case .completed:
                print("转码成功")
                //上传
                break
            case .cancelled:
                print("取消")
                break
            case .failed:
                print("失败...\(String(describing: exportSession.error?.localizedDescription))")
                break
            default:
                print("..")
                break
            }
        }, shouldOptimizeForNetworkUse: true)
    }
}
