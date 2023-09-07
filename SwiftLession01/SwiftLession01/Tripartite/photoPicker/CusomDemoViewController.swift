//
//  CusomDemoViewController.swift
//  HEPhotoPicker_Example
//
//  Created by heyode on 2018/11/6.
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
import RxSwift


class CusomDemoViewController: UIViewController {

    @IBOutlet weak var singleVideoView: UIView!
    
    @IBOutlet weak var singleImageView: UIView!
    
   lazy var pickerTypeSegment: UISegmentedControl = {
        let items = ["image", "video", "img&V","imgOrV"] as [Any]
        let segmented = UISegmentedControl(items:items)
        segmented.frame = CGRect(x: 0, y: 200, width: KScreenWidth, height: 30)
        segmented.selectedSegmentIndex = 0 //默认选中第二项
        segmented.addTarget(self, action: #selector(segumentClick), for: .valueChanged)  //添加值改变监听
        segmented.tintColor = .blue
        return segmented
    }()
    lazy var ascendingSwitchDesLab: UILabel = {
        let des = UILabel()
        des.text = "是否根据图片创建时间升序展示"
        des.textColor = .black
        return des
    }()
    lazy var ascendingSwitch: UISwitch = {
        
        let sh = UISwitch()
        return sh
    }()
    lazy var videoSwitchDesLab: UILabel = {
        let des = UILabel()
        des.text = "是否支持视频单选（不支持img&V模式）"
        des.textColor = .black
        return des
    }()
    lazy var videoSwitch: UISwitch = {
        let sh = UISwitch()
        return sh
    }()
    lazy var pickturSwitchDesLab: UILabel = {
        let des = UILabel()
        des.text = "是否支持图片单选（不支持img&V和imageOrV模式"
        des.adjustsFontSizeToFitWidth = true
        des.textColor = .black
        return des
    }()
    lazy var pickturSwitch: UISwitch = {
        let sh = UISwitch()
        return sh
    }()
   lazy var maxCountTextfield: UITextField = {
        let maxImge = UITextField()
        maxImge.text("9")
        maxImge.placeholder("可选择图片的最大个数")
        maxImge.keyboardType(.numberPad)
        return maxImge
    }()
    lazy var collectionView: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 111, height: 111)
        let collection = UICollectionView(frame: CGRect.init(x: 10, y: 40, width: KScreenWidth-20, height: 150), collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.jx.register(cellClass: MasterCell.self)
        return collection
    }()
    lazy var accumulationSwitchDesLab: UILabel = {
        let des = UILabel()
        des.text = "是否支持多次累加选择"
        des.textColor = .black
        return des
    }()
   lazy var accumulationSwitch: UISwitch = {
       let sh = UISwitch()
       sh.jx.setHandle { isOn in
           
       }
       return sh
    }()
   lazy var macCountOfVideoTextfield: UITextField = {
        let maxVideo = UITextField()
        maxVideo.text("1")
        maxVideo.placeholder("可选择视频的最大个数")
        maxVideo.keyboardType(.numberPad)
        return maxVideo
    }()
    lazy var selectorBtn :UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("选择照片", for: .normal)
        button.textColor(UIColor.blue)
        button.addTarget(self, action: #selector(selectorBtnClick), for: .touchUpInside)
        return button
    }()
    var selectedModel = [HEPhotoAsset]()
    var visibleImages = [UIImage](){
        didSet{
            if oldValue != visibleImages{
                collectionView.reloadData()
            }
        }
    }
    
    var animator : HEPhotoBrowserAnimator = {
        let a = HEPhotoBrowserAnimator()
        a.transitionType = .modal
        return a
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(84)
            make.left.equalTo(10)
            make.width.equalTo(KScreenWidth-20)
            make.height.equalTo(160)
        }
        self.view.addSubview(pickerTypeSegment)
        
        pickerTypeSegment.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(KScreenWidth)
            make.height.equalTo(30)
        }
        self.view.addSubview(maxCountTextfield)
        maxCountTextfield.snp.makeConstraints { make in
            make.top.equalTo(pickerTypeSegment.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(30)
        }
        self.view.addSubview(macCountOfVideoTextfield)
        macCountOfVideoTextfield.snp.makeConstraints { make in
            make.top.equalTo(maxCountTextfield.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(ascendingSwitch)
        ascendingSwitch.snp.makeConstraints { make in
            make.top.equalTo(macCountOfVideoTextfield.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        self.view.addSubview(ascendingSwitchDesLab)
        ascendingSwitchDesLab.snp.makeConstraints { make in
            make.top.equalTo(ascendingSwitch)
            make.left.equalTo(ascendingSwitch.snp.right).offset(10)
            make.width.equalTo(KScreenWidth-60)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(accumulationSwitch)
        accumulationSwitch.snp.makeConstraints { make in
            make.top.equalTo(ascendingSwitch.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        self.view.addSubview(accumulationSwitchDesLab)
        accumulationSwitchDesLab.snp.makeConstraints { make in
            make.top.equalTo(accumulationSwitch)
            make.left.equalTo(accumulationSwitch.snp.right).offset(10)
            make.width.equalTo(KScreenWidth-60)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(videoSwitch)
        videoSwitch.snp.makeConstraints { make in
            make.top.equalTo(accumulationSwitch.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        self.view.addSubview(videoSwitchDesLab)
        videoSwitchDesLab.snp.makeConstraints { make in
            make.top.equalTo(videoSwitch)
            make.left.equalTo(videoSwitch.snp.right).offset(10)
            make.width.equalTo(KScreenWidth-60)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(pickturSwitch)
        pickturSwitch.snp.makeConstraints { make in
            make.top.equalTo(videoSwitch.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        self.view.addSubview(pickturSwitchDesLab)
        pickturSwitchDesLab.snp.makeConstraints { make in
            make.top.equalTo(pickturSwitch)
            make.left.equalTo(pickturSwitch.snp.right).offset(10)
            make.width.equalTo(KScreenWidth-60)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(selectorBtn)
        selectorBtn.snp.makeConstraints { make in
            make.top.equalTo(pickturSwitch.snp.bottom).offset(50)
            make.left.equalTo(10)
            make.width.equalTo(KScreenWidth-20)
            make.height.equalTo(30)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.backgroundColor = .white
 
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func imageSwitchClick(_ sender: UISwitch) {
       cleanSelectedBtnClick()
    }
    @IBAction func videoSwitchClick(_ sender: UISwitch) {
        cleanSelectedBtnClick()
    }
    
    @objc func segumentClick(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 2 : //break
           pickturSwitch.isHidden = true
           videoSwitch.isHidden = true
        case 3 :
//            break
            pickturSwitch.isHidden = true
            videoSwitch.isHidden = false
        default:
//            break
            pickturSwitch.isHidden = false
            videoSwitch.isHidden = false
        }
        cleanSelectedBtnClick()
    }
    
    @objc func selectorBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        guard let str = maxCountTextfield.text,let count = Int(str) else {
            return
        }
        guard let videoStr = macCountOfVideoTextfield.text,let videoCount = Int(videoStr) else {
            return
        }
        
        
        let options = HEPickerOptions.init()
        options.ascendingOfCreationDateSort = ascendingSwitch.isOn
        
        options.singlePicture = pickturSwitch.isOn
        options.singleVideo = videoSwitch.isOn
        switch pickerTypeSegment.selectedSegmentIndex{
        case 0:
            options.mediaType = .image
        case 1:
            options.mediaType = .video
        case 2 :
            options.mediaType = .imageAndVideo
        case 3 :
            options.mediaType = .imageOrVideo
        default:
            fatalError()
        }
        if accumulationSwitch.isOn {
            options.defaultSelections = selectedModel
        }
        options.maxCountOfImage = count
        options.maxCountOfVideo = videoCount
        let picker = HEPhotoPickerViewController.init(delegate: self, options: options)
        hePresentPhotoPickerController(picker: picker, animated: true)
        
    }
  func cleanSelectedBtnClick() {
        view.endEditing(true)
        selectedModel = [HEPhotoAsset]()
        visibleImages = [UIImage]()
        
    }
}
extension CusomDemoViewController : HEPhotoPickerViewControllerDelegate{
    func pickerController(_ picker: UIViewController, didFinishPicking selectedImages: [UIImage],selectedModel:[HEPhotoAsset]) {
        // 实现多次累加选择时，需要把选中的模型保存起来，传给picker
        self.selectedModel = selectedModel
        self.visibleImages = selectedImages
   
    }
    func pickerControllerDidCancel(_ picker: UIViewController) {
        // 取消选择后的一些操作
    }
    
}
extension CusomDemoViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MasterCell.className, for: indexPath) as? MasterCell else {
            fatalError("unexpected cell in collection view")
        }

            
            cell.mediaModel = self.selectedModel[indexPath.row]
            
            cell.closeBtn.isHidden = false
            cell.closeBtnClickHandle = {[weak self] in
                self?.visibleImages.remove(at: indexPath.row)
                self?.selectedModel.remove(at: indexPath.row)
                self?.collectionView.reloadData()
            }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < selectedModel.count {
            animator.selIndex = indexPath
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            option.resizeMode = .none
            let size = CGSize.init(width: kScreenWidth, height: kScreenWidth)
            HETool.heRequestImage(for:selectedModel[indexPath.row].asset ,
                                                  targetSize: size,
                                                  contentMode: .aspectFill)
            { (image, nil) in
                let browser = BrowserViewController()
                browser.image = image!
                browser.imageIndex = indexPath
                browser.models = self.selectedModel
                browser.selectedModels = self.selectedModel
                self.animator.popDelegate = browser
                self.animator.pushDelegate = self
                browser.modalPresentationStyle = .custom
                
                browser.transitioningDelegate = self.animator
                self.present(browser, animated: true, completion: nil)
             }
        }
    }
    
}

extension CusomDemoViewController: HEPhotoBrowserAnimatorPushDelegate{
    
    public func imageViewRectOfAnimatorStart(at indexPath: IndexPath) -> CGRect {
        // 获取指定cell的laout
        let cellLayout = collectionView.layoutAttributesForItem(at: indexPath)
        let homeFrame =  UIApplication.shared.keyWindow?.convert(cellLayout?.frame ??  CGRect.zero, from: collectionView) ?? CGRect.zero
        //返回具体的尺寸
        return homeFrame
    }
    public func imageViewRectOfAnimatorEnd(at indexPath: IndexPath) -> CGRect {
        //取出cell
        let cell = (collectionView.cellForItem(at: indexPath))! as! MasterCell
        //取出cell中显示的图片
        let image = cell.imageView.image
        let x: CGFloat = 0
        let width: CGFloat = kScreenWidth
        let height: CGFloat = width / (image!.size.width) * (image!.size.height)
        var y: CGFloat = 0
        if height < kScreenHeight {
            y = (kScreenHeight -   height) * 0.5
        }
        //计算方法后的图片的frame
        return CGRect(x: x, y: y, width: width, height: height)
        
    }
    public func imageView(at indexPath: IndexPath) -> UIImageView {
        //创建imageView对象
        let imageView = UIImageView()
        //取出cell
        let cell = (collectionView.cellForItem(at: indexPath))! as! MasterCell
        //取出cell中显示的图片
        let image = cell.imageView.image
        //设置imageView相关属性(拉伸模式)
        imageView.contentMode = .scaleAspectFit
        //设置图片
        imageView.image = image
        //将多余的部分裁剪
        imageView.clipsToBounds = true
        //返回图片
        return imageView
    }
}
