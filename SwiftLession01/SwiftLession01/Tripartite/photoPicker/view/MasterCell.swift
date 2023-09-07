//
//  MasterCell.swift
//  SwiftPhotoSelector
//
//  Created by heyode on 2018/9/26.
//  Copyright (c) 2018 heyode <1025335931@qq.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import Photos

class MasterCell: UICollectionViewCell {
    typealias MasterCellHandle = ()->Void
    lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "close-btn"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return button
    }()
    var closeBtnClickHandle : MasterCellHandle?
    lazy var imageView: UIImageView={
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        return image
    }()
    var representedAssetIdentifier : String!
    lazy var durationLab: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.italicSystemFont(ofSize: 10)
        return label
    }()
    lazy var durationBackView: UIView = {
        let timeView = UIView()
        return timeView
    }()
    
    var mediaModel:HEPhotoAsset!{
        didSet{
            
            self.addSubview(imageView)
            imageView.addSubview(durationBackView)
            durationBackView.addSubview(durationLab)
            imageView.addSubview(closeBtn)
            imageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(111)
            }
            durationBackView.snp.makeConstraints { make in
                make.height.equalTo(20)
                make.width.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            durationLab.snp.makeConstraints { make in
                make.height.equalTo(20)
                make.width.equalTo(100)
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            closeBtn.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.right.equalToSuperview()
                make.size.equalTo(22)
            }
            imageView.image = UIImage()

            let scale : CGFloat = 1.5
            self.representedAssetIdentifier = mediaModel.asset.localIdentifier
            let   thumbnailSize = CGSize(width: self.bounds.size.width * scale, height: self.bounds.size.height  * scale )
            HETool.heRequestImage(for: mediaModel.asset,
                                                  targetSize:thumbnailSize,
                                                  contentMode: .aspectFill)
            { (image, nil) in
                DispatchQueue.main.async {
                    if self.representedAssetIdentifier == self.mediaModel.asset.localIdentifier{
                        self.imageView.image = image
                    }
                }
            }
            
            if mediaModel.asset.mediaType == .video{// 如果是视频,加显示时长标签
                durationBackView.isHidden = false
                let timeStamp = lroundf(Float(mediaModel.asset.duration))
                let s = timeStamp % 60
                let m = (timeStamp - s) / 60 % 60
                let time = String(format: "%.2d:%.2d",  m, s)
                durationLab.text = time
                self.layoutSubviews()
            }else{
                durationBackView.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setMaskColor()
    }
     
    func setMaskColor(){
        let maskLayer = CAGradientLayer()
        maskLayer.colors = [UIColor.clear.cgColor,UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor]
        maskLayer.startPoint = CGPoint.init(x: 0, y: 0)
        maskLayer.endPoint = CGPoint.init(x: 0, y: 1)
        maskLayer.locations = [0,1]
        maskLayer.borderWidth = 0
        self.durationBackView.layer.insertSublayer(maskLayer, at: 0)
        maskLayer.frame = self.durationBackView.bounds 
    }
   @objc func closeBtnClick(_ sender: Any) {
        if let blcok = closeBtnClickHandle{
            blcok()
        }
    }
    
}
