//
//  JXDefaultVC.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/16.
//

import UIKit
import JXBanner
import JXPageControl

class JXDefaultVC: UIViewController {

    var pageCount = 5

    var banner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "linearBanner"
       
        return banner
    }()
    var verticalBanner: JXBanner = {
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(banner)
        view.addSubview(verticalBanner)
        banner.delegate = self
        banner.dataSource = self
        banner.snp.makeConstraints { maker in
            maker.left.right.equalTo(view)
            maker.height.equalTo(150)
            maker.top.equalTo(view.snp.top).offset(100)
        }
        
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "banner"
        banner.delegate = self
        banner.dataSource = self
        
        verticalBanner.snp.makeConstraints { maker in
            maker.left.right.equalTo(view)
            maker.height.equalTo(150)
            maker.top.equalTo(view.snp.top).offset(300)
        }
        verticalBanner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        verticalBanner.delegate = self
        verticalBanner.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    deinit {
        print("\(#function) ----------> \(#file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? #file)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        banner.reloadView()
    }

}
//MARK:- JXBannerDataSource
extension JXDefaultVC: JXBannerDataSource {
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "JXDefaultVCCell")
    }
    
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return pageCount }
    
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell = cell as! JXBannerCell
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            tempCell.imageView.image = UIImage(named: "\(index).jpg")
            tempCell.msgLabel.text = String(index) + "---来喽来喽,他真的来喽~"
            return tempCell
    }
    
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
        
        
        if banner.indentify == "banner" {
            return layoutParams
                .itemSize(CGSize(width: 300, height: 150))
                .itemSpacing(20)
        } else {
            return layoutParams
                .itemSize(CGSize(width: 300, height: 150))
                .itemSpacing(20)
                .scrollDirection(.vertical)
        }
    }
    
}

//MARK:- JXBannerDelegate
extension JXDefaultVC: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        print(index)
    }
    
    
    
}
