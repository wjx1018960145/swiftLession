//
//  ThemTableViewCell.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/24.
//

import UIKit
import Alamofire


class ThemTableViewCell: UITableViewCell {
    
    
    
    typealias swiftBlock = (_ str: Them) -> Void
    var callBack: swiftBlock?
    
//    var mode : Them!
//    public var themModel:Them? = Them(themName: "", colorValue: "")
    
    private var tempModel:Them!
    var model : Them {
        set {
            tempModel = newValue
            self.colorLabel.text = tempModel?.themName
//            self.priceLabel?.text = (tempModel?.price!)!+"积分"
//            self.productStockpileLabel?.text = "商品库存:"+(tempModel?.stock!)!
            bgView.image = creatImage(color: tempModel.colorValue)
            //在这里给cell里的属性赋值
        }
        get {
            return (self.tempModel)!
        }
        
    }
    
    
    
    
    var bgView : UIImageView = {
        let view = UIImageView()
        view.layer.shadowColor = UIColor.black.cgColor;
        view.layer.shadowOpacity = 1;
        view.layer.shadowOffset = CGSize(width: 0, height: 8);
        view.layer.shadowOpacity = 0.5;
    //    _bankBGView.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 20;
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 16;
        
        
       
//        let tap = UITapGestureRecognizer(target: self, action: #selector(cleck))
//        view.addGestureRecognizer(tap)
        return view
    }()
    
    var colorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangSC-Medium", size: 16)
        label.textAlignment = .center
        label.textColor = UIColor.white
         return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        bgView.isUserInteractionEnabled = true
       
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cleck)))
        self.addSubview(bgView)
        bgView.addSubview(colorLabel)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        colorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
    }
//    func clickViewblcok(complete:(clickViewblcok))->(){
//        let re: String = "Cookie"
//        complete(re)
//    }
    //3. 定义一个方法,方法的参数为和swiftBlock类型一致的闭包,并赋值给callBack
    func callBackBlock(indexPath:NSIndexPath, block: @escaping (_ str: Them) -> Void) {
            
            callBack = block
        }
        @objc func cleck(){
            print(model.themName,model.themName)
         if (callBack != nil) {
             callBack!(model)
         }
       

    }
    func creatImage(color:String) -> UIImage {
         let image = UIImage.jx.gradient([UIColor.hexStringColor(hexString:color), UIColor.hexStringColor(hexString: color)], size: CGSize(width: self.frame.size.width, height: 80), radius: 10, locations: nil, direction: .leftOblique)
        return image!
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
