//
//  CollectionViewCell.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/17.
//

import UIKit

class ACollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView.superview == nil {
            imageView.frame = bounds
            imageView.layer.cornerRadius = layer.cornerRadius
            addSubview(imageView)
        }
    }
}
