//
//  AdViewViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/14.
//

import UIKit

class AdViewViewController: UIViewController, TSDownloadDelegate {
    func tsDownloadSucceeded() {
        
    }
    
    func tsDownloadFailed() {
        
    }
    
    func update(progress: Float) {
        print("update(progress:() == \(progress) ")
        let str = String(format: "%.2f%%", progress*100)
        parserBtn.setTitle(str, for: .normal)
    }
    
    func downloadSpeedUpdate(speed: String) {
        speedlab.text = speed
    }
    
    func m3u8ParserSuccess(tsModels: [TSModel]) {
        print("tsDownloadSucceeded()() ")
        pauseBtn.isHidden = true
        speedlab.text = "已完成下载"
        localVideoBtn.isHidden = false
    }
    
    func m3u8ParserFailed() {
        print("m3u8ParserFailed() ")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if let delegate = UIApplication.shared.delegate as? AppDelegate {
//            let rootVC = RootViewController()
//            let nav = UINavigationController(rootViewController: rootVC)
//            delegate.window?.rootViewController = nav
//        }
        
    }
    
    private lazy var parserBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("显示广告业", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(showAd), for: .touchUpInside)
        btn.frame = CGRect(x: 30, y: 100, width: 100, height: 40)
        return btn
    }()
    
    private lazy var pauseBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("pause", for: .normal)
        btn.setTitle("resume", for: .selected)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.white, for: .normal)
//        btn.addTarget(self, action: #selector(showVideoVC(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 150, y: 100, width: 70, height: 40)
        btn.isHidden = true
        return btn
    }()
    
    private let speedlab: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 250, y: 100, width: 100, height: 40)
        return lab
    }()
    
    private lazy var localVideoBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("playLocal", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(showVideoVC(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 30, y: 150, width: 100, height: 40)
        btn.isHidden = true
        return btn
    }()
    
    lazy var tsManager: TSManager = {
        let tsm = TSManager()
        tsm.delegate = self
        return tsm
    }()
    let videoUrl = ""
    var isAdShow: Bool = false
    public func dataToJSON(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data , options: .mutableContainers) as? [String: Any]
        } catch {
           print(error)
        }
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(pauseBtn)
        self.view.addSubview(parserBtn)
        view.addSubview(speedlab)
        /// 闪屏广告
        showAd()
        // Do any additional setup after loading the view.
    }
   @objc func showAd() {
        loadADView()
    }
    func loadADView() {
        if let currentAd = SwiftAdFileConfig.readCurrentAdModel() { // 1. 检测 本地 有没有 广告
            showAdView(currentAd)
        } else {
            showDefaultAd()  // 2. 本地没找到对应的广告文件，展示默认广告
        }
        // 3. 检测服务器是否 换了新广告
        loadAdAPI()
    }
    /// 展示默认 广告， 或者不展示广告
    func showDefaultAd() {
        /// image
        //let fileImage = Bundle.main.path(forResource: "guide02", ofType: "png") ?? ""
        /// gif
        let fileGif = Bundle.main.path(forResource: "foldingcell", ofType: "gif") ?? ""
        /// 视频
        // let fileVideo = Bundle.main.path(forResource: "1", ofType: "mp4") ?? ""
        
        let admodel = AdFileModel(adUrl: fileGif, adType: .gif, adHerfUrl: "https://github.com/shiliujiejie/RootTabBarController", adId: 1, customSaveKey: nil)
        
        showAdView(admodel)
    }
    func showAdView(_ adModel: AdFileModel) {
        let advc = SwiftAdView(config: configModel(), adModel: adModel)
        advc.modalPresentationStyle = .fullScreen
        self.present(advc, animated: false, completion: nil)
        isAdShow = true
        advc.skipBtnClickHandler = {
            
        }
        advc.adClickHandler = { (adModel) in
            print("跳转")
//            let webvc = WebKitController(url: URL(string: adModel.adHerfUrl ?? "")!)
//            self.navigationController?.pushViewController(webvc, animated: true)
        }
    }
    /// 广告页面属性 - 配置
    func configModel() -> SwiftAdFileConfig {
        let config = SwiftAdFileConfig()
        config.duration = 10
        config.autoDissMiss = false
        config.openInSafari = false
        config.videoGravity = .resizeAspectFill
        return config
    }
    /// 这里模拟网络请求到 广告数据 后的操作
    func loadAdAPI() {
        
        // 模拟网络请求1.5秒
        self.sleep(1.5) {
            /// 请求结果 构造 model (根据了 链接对应的数据 的文件格式。确定 adType : "image"   "gif"  "video")
            // https://github.com/shiliujiejie/adResource/raw/master/1.mp4
            // https://github.com/shiliujiejie/adResource/raw/master/2.mp4
            // https://github.com/shiliujiejie/adResource/raw/master/3.mp4
            // https://github.com/shiliujiejie/adResource/raw/master/folding-cell.gif
            // https://github.com/shiliujiejie/adResource/raw/master/maskp.gif
            // https://github.com/shiliujiejie/adResource/raw/master/timg.jpeg
            // http://cdn-hw.570920.com/video_ad/ao/7c/12ao7c3ee37f66d36b7f413a58d6483054aae59128.m3u8
            
            let admodel = AdFileModel.init(adUrl: "https://github.com/shiliujiejie/adResource/raw/master/2.mp4", adType: .video, adHerfUrl: "https://github.com/shiliujiejie/RootTabBarController", adId: 0 , customSaveKey: nil)
            
            /// 下载广告, 下次启动展示
            SwiftAdFileConfig.downLoadAdData(admodel)
        }
    }
    /// 线程延时
    private func sleep(_ time: Double,mainCall:@escaping ()->()) {
        let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
        DispatchQueue.main.asyncAfter(deadline: time) {
            mainCall()
        }
    }
    @objc func parseM3u8(_ sender: UIButton) {
       
        if sender.tag == 99 {
            sender.setTitle("解析中...", for: .normal)
            tsManager.directoryName =  "1231234"
            tsManager.m3u8URL = videoUrl
            tsManager.downloadFromLastInterruptedIndex()
            pauseBtn.isHidden = false
        } else if sender.tag == -1 {
            print("当前视频已经下载了")
        } else if sender.tag == 0 {
            sender.setTitle("解析中...", for: .normal)
            tsManager.directoryName =  "1231234"
            tsManager.m3u8URL = videoUrl
            tsManager.download(nil, ["referer":"http://www.com"])
            pauseBtn.isHidden = false
        }
    }
    @objc func showVideoVC(_ sender: UIButton) {
        if sender == localVideoBtn {
            let identifer = "1231234"
            if tsManager.downloadSucceeded(identifer) {
//                let localPlayVC = DownLoadedVideoPlayerVC()
//                localPlayVC.identifer = identifer
//                navigationController?.pushViewController(localPlayVC, animated: true)
            }
        } else if sender == pauseBtn {
            if sender.isSelected {
                tsManager.resume()
                sender.isSelected = false
            } else {
                tsManager.parse(nil, ["referer":"http://www.qq.com"])
                sender.isSelected = true
            }
        }
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
