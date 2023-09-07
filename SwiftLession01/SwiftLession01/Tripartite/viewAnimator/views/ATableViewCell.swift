//
//  TableViewCell.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/17.
//

import UIKit
import ViewAnimator

class ATableViewCell: UITableViewCell {

    var userImageView: UIImageView = {
        let header = UIImageView()
        header.cornerRadius = 22.5
        header.maskToBounds = true
        return header
    }()
    var label: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17)
        title.text = "User name"
        return title
    }()
    
//    override func layoutSubviews() {
//        contentView.backgroundColor = .red
////        contentView.addSubview(userImageView)
////        userImageView.snp.makeConstraints { make in
////            make.top.left.equalTo(15)
////            make.size.equalTo(45)
////        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(userImageView)
        contentView.addSubview(label)
        userImageView.snp.makeConstraints { make in
            make.top.left.equalTo(5)
            make.size.equalTo(50)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(userImageView.snp.right).offset(30)
            make.width.equalTo(150)
            make.height.equalTo(30)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
