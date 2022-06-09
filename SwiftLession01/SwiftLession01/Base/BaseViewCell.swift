//
//  BaseViewCell.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/4.
//

import UIKit
import SnapKit
class BaseViewCell: UITableViewCell {
    
    var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    var contentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
//        self.backgroundColor = .white
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(lineView)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 1))
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
