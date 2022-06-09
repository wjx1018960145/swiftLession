//
//  TableViewCell.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var bankBGView:UIImageView = {
        let imageview = UIImageView()
        imageview.layer.shadowColor = UIColor.black.cgColor;
        imageview.layer.shadowOpacity = 1;
        imageview.layer.shadowOffset = CGSize(width: 0, height: 8);
        imageview.layer.shadowOpacity = 0.5;
    //    _bankBGView.layer.masksToBounds = YES;
        imageview.layer.cornerRadius = 8;
        imageview.layer.masksToBounds = true;
        imageview.layer.cornerRadius = 20;
        imageview.layer.masksToBounds = true;
        imageview.layer.cornerRadius = 16;
        return imageview
    }()
    var headImgView:UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
        imageview.clipsToBounds = true
        imageview.backgroundColor = UIColor.white
        return imageview
    }()
    
    var contentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(bankBGView)
        bankBGView.addSubview(contentLabel)
//        bankBGView.backgroundColor = UIColor.white
        bankBGView.addSubview(headImgView)
        guard let image = UIImage.jx.gradient([UIColor.hexStringColor(hexString: "#c3282b"), UIColor.hexStringColor(hexString: "#e43639  ")], size: CGSize(width: self.frame.size.width, height: 150), radius: 10, locations: nil, direction: .leftOblique) else {
            return
        }
        
        bankBGView.image = image
        headImgView.image = UIImage(named: "")
        bankBGView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(152)
        }
        headImgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 1))
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
